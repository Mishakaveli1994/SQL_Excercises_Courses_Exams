USE Gringotts
--1. Records’ Count
SELECT COUNT(*) FROM WizzardDeposits

--2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits

--2.5 Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits
GROUP BY DepositGroup

--2.6 Smallest Deposit Group Per Magic Wand Size
SELECT TOP (2) DepositGroup FROM
(SELECT DepositGroup,AVG(MagicWandSize) AS AvgWandSize FROM WizzardDeposits
GROUP BY DepositGroup)tmp
ORDER BY AvgWandSize ASC

--3. Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
GROUP BY DepositGroup

--4. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--5. Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

--6. Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--7. Age Groups
SELECT  
CASE 
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
ELSE '[61+]' END AS AgeGroup, COUNT(*) AS WizardCount
FROM WizzardDeposits
GROUP BY CASE
WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
ELSE '[61+]' END

--8. First Letter

SELECT LEFT(FirstName,1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)
ORDER BY FirstLetter

--9. Average Interest 
SELECT DepositGroup, IsDepositExpired,AVG(DepositInterest) AS AverageInterest FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY IsDepositExpired, DepositGroup
ORDER BY DepositGroup DESC, IsDepositExpired

--10. * Rich Wizard, Poor Wizard
SELECT SUM(Equation) AS SumDifference FROM
(SELECT DepositAmount - LEAD(DepositAmount,1) OVER (ORDER BY Id) AS Equation FROM WizzardDeposits)tmp

--11. Departments Total Salaries
USE SoftUni
GO
SELECT DepartmentID,SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--12. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN (2,5,7)
AND HireDate > '2000-01-01'
GROUP BY DepartmentID

--13. Employees Average Salaries
SELECT * INTO AverageSalaries FROM Employees
WHERE Salary > 30000
DELETE FROM AverageSalaries
WHERE ManagerID = 42
UPDATE AverageSalaries
SET Salary = Salary + 5000
WHERE DepartmentID = 1
SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM AverageSalaries
GROUP BY DepartmentID

--14. Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--15. Employees Count Salaries
SELECT COUNT(Salary) AS Count FROM Employees
WHERE ManagerID IS NULL

--16. *3rd Highest Salary
SELECT DepartmentId, Salary AS ThirdHIghestSalary FROM
(SELECT DepartmentID, Salary, RANK() OVER  (PARTITION BY DepartmentId ORDER BY Salary DESC) AS Rank  FROM Employees
GROUP BY Salary, DepartmentID)tmp
WHERE Rank = 3

--17. **Salary Challenge
SELECT TOP (10) a.FirstName,a.LastName,a.DepartmentID FROM
((SELECT FirstName,LastName,DepartmentId,Salary FROM Employees)a
JOIN 
(SELECT DepartmentId, AVG(Salary) AS AvgSalary FROM Employees
GROUP BY DepartmentID)b
ON a.DepartmentId = b.DepartmentId)
WHERE a.Salary > b.AvgSalary
ORDER BY DepartmentID
