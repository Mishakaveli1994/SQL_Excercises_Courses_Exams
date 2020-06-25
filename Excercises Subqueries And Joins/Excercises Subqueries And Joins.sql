USE SoftUni

--1. Employee Address
SELECT TOP (5) EmployeeId, e.JobTitle, a.AddressID, a.AddressText FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY AddressID

--2. Addresses with Towns
SELECT TOP (50) e.FirstName,e.LastName,t.Name,a.AddressText FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY e.FirstName,e.LastName

SELECT * FROM Addresses
SELECT * FROM Employees

--3. Sales Employee
SELECT e.EmployeeID,e.FirstName,e.LastName,d.Name FROM Employees AS e
JOIN Departments AS d on e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY EmployeeID

--4. Employee Departments
SELECT TOP (5) e.EmployeeID, e.FirstName,e.Salary,d.Name FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--5. Employees Without Project
SELECT TOP (3) e.EmployeeID, e.FirstName FROM Employees AS e
WHERE e.EmployeeID NOT IN (SELECT p.EmployeeID FROM EmployeesProjects AS p)
ORDER BY e.EmployeeID

--6. Employees Hired After
SELECT e.FirstName, e.LastName, e.HireDate,d.Name AS DeptName FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Sales','Finance')
AND e.HireDate > '1999.1.1'
ORDER BY e.HireDate

--7. Employees with Project
SELECT TOP (5) e.EmployeeID, e.FirstName, k.Name FROM EmployeesProjects AS p
JOIN Employees AS e ON e.EmployeeID = p.EmployeeID
JOIN Projects AS k ON k.ProjectID = p.ProjectID
WHERE k.StartDate > '2002.08.13'
AND k.EndDate IS NULL
ORDER BY e.EmployeeID

--8. Employee 24
SELECT e.EmployeeID, e.FirstName,
CASE
WHEN k.StartDate > '2005' THEN NULL
ELSE
k.Name
END
FROM EmployeesProjects AS p
JOIN Employees AS e ON e.EmployeeID = p.EmployeeID
JOIN Projects AS k ON k.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--9. Employee Manager
SELECT e.EmployeeID,e.FirstName,e.ManagerID,k.FirstName AS ManagerName FROM Employees AS e
JOIN Employees AS k ON e.ManagerID = k.EmployeeID
WHERE e.ManagerID IN (3,7)
ORDER BY e.EmployeeID

--10. Employee Summary
SELECT TOP (50) e.EmployeeID,e.FirstName + ' ' + e.LastName AS EmployeeName,
k.FirstName + ' ' + k.LastName AS ManagerName, d.Name AS DepartmentName
FROM Employees AS e
JOIN Employees AS k ON e.ManagerID = k.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

--11. Min Average Salary
SELECT TOP(1) AVG(e.Salary) AS MinAverageSalary FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY MinAverageSalary


--12. Highest Peaks in Bulgaria
USE Geography

SELECT c.CountryCode,m.MountainRange,p.PeakName,p.Elevation FROM MountainsCountries AS cm
JOIN Countries AS c ON cm.CountryCode = c.CountryCode
JOIN Mountains AS m ON m.Id = cm.MountainId
JOIN Peaks AS p ON p.MountainId = m.Id
WHERE c.CountryCode = 'BG'
AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--13. Count Mountain Ranges
SELECT c.CountryCode,COUNT(m.MountainRange) AS MountainRanges FROM MountainsCountries AS cm
JOIN Countries AS c ON cm.CountryCode = c.CountryCode
JOIN Mountains AS m ON m.Id = cm.MountainId
WHERE c.CountryCode IN ('BG','US','RU')
GROUP BY c.CountryCode

--14. Countries with Rivers

SELECT TOP (5) c.CountryName,r.RiverName FROM CountriesRivers AS cr
RIGHT JOIN Countries AS c ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

--15. Continents and Currencies
SELECT ContinentCode,CurrencyCode,CurrencyCount FROM
	(SELECT ContinentCode,
		   CurrencyCode,
		   CurrencyCount,
		   DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY CurrencyCount DESC) AS CurrencyRank
	FROM 
	(SELECT ContinentCode,CurrencyCode,COUNT(*) AS CurrencyCount FROM Countries
	GROUP BY ContinentCode,CurrencyCode
	HAVING COUNT(*) > 1) AS CurrenctQuery) AS CurrencyRankQuery
WHERE CurrencyRank = 1

--15.5 Countries Without Any Mountains
SELECT COUNT(CountryName) AS [Count] FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
WHERE MountainId IS NULL

--16. Highest Peak and Longest River by Country
SELECT TOP (5) RiverRankQuery.CountryName,
			   PeakRankQuery.Elevation AS HighestPeakElevation,
			   RiverRankQuery.[Length] AS LongestRiverLength FROM 
(
(SELECT c.CountryName,
	   r.Length, 
	   RANK() OVER (PARTITION BY c.CountryName ORDER BY r.Length DESC) AS RiverRank 
	   FROM CountriesRivers AS cr
JOIN Countries  AS c ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id) RiverRankQuery

JOIN 

(SELECT c.CountryName,
	   p.Elevation,
	   RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS PeakRank 
	   FROM MountainsCountries AS mc
JOIN Countries AS c ON c.CountryCode = mc.CountryCode
JOIN Mountains AS m ON m.Id = mc.MountainId
JOIN Peaks AS p ON p.MountainId = m.Id) PeakRankQuery

ON PeakRankQuery.CountryName = RiverRankQuery.CountryName

)
WHERE RiverRankQuery.RiverRank = 1 AND PeakRankQuery.PeakRank = 1
ORDER BY HighestPeakElevation DESC,LongestRiverLength DESC ,RiverRankQuery.CountryName

--17. Highest Peak Name and Elevation by Country
SELECT TOP(5) CountryName AS Country,
	   ISNULL(PeakName,'(no highest peak)') AS 'Highest Peak Name',
	   ISNULL(Elevation,0) AS 'Highest Peak Elevation',
	   ISNULL(MountainRange,'(no mountain)') AS 'Mountain'
	   FROM
(SELECT c.CountryName,
	   p.PeakName,
	   p.Elevation,
	   DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation) AS PeakRank,
	   m.MountainRange
	   FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
LEFT JOIN Mountains AS m ON m.Id = mc.MountainId) PeakRankQuery
WHERE PeakRank = 1
ORDER BY Country,'Highest Peak Name'