USE SoftUni
SELECT * FROM Departments

SELECT [Name] FROM Departments

SELECT FirstName, LastName, Salary FROM Employees

SELECT FirstName, MiddleName, LastName FROM Employees

SELECT CONCAT(FirstName,'.',LastName,'@softuni.bg') as 'Full Email Address' FROM Employees

SELECT DISTINCT Salary FROM Employees

SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'

SELECT FirstName, LastName, JobTitle FROM Employees
WHERE Salary BETWEEN 20000 and 30000

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) as 'Full Name' FROM Employees
WHERE Salary in (25000,14000,12500,23600)

SELECT FirstName, LastName FROM Employees
WHERE ManagerID IS NULL

SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

SELECT TOP 5 FirstName, LastName FROM Employees
ORDER BY Salary DESC 

SELECT  FirstName, LastName FROM Employees
WHERE DepartmentID <> 4

SELECT * FROM Employees
ORDER BY Salary DESC, FirstName,LastName DESC, MiddleName

CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary FROM Employees


CREATE VIEW V_EmployeeNameJobTitle AS
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) as 'Full Name', JobTitle FROM Employees

SELECT DISTINCT JobTitle FROM Employees

SELECT TOP 10 * FROM Projects
ORDER BY StartDate, Name


SELECT TOP 7 FirstName, LastName, HireDate FROM Employees
ORDER BY HireDate DESC

UPDATE Employees
SET Salary = Salary * 1.12
FROM Employees a
JOIN Departments b ON a.DepartmentID = b.DepartmentID
WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing','Information Services')
SELECT Salary FROM Employees
