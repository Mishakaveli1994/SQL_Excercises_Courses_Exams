USE SoftUni
--Problem 1. Find Names of All Employees by First Name
SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%'

--Problem 2. Find Names of All employees by Last Name 
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'

--Problem 3. Find First Names of All Employees

SELECT FirstName FROM Employees
WHERE DepartmentID IN (3,10)
AND DATEPART(YEAR,HireDate) >= '1995' and DATEPART(YEAR,HireDate) < '2006'

--Problem 4. Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE '%[eE]ngineer%' 

--Problem 5.	Find Towns with Name Length
SELECT [Name] FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name]

--Problem 6. Find Towns Starting With
SELECT TownID,[Name] FROM Towns
WHERE [Name] LIKE '[MKBE]%'
ORDER BY [Name]

--Problem 7. Find Towns Not Starting With
SELECT TownID,[Name] FROM Towns
WHERE [Name] NOT LIKE '[RBD]%'
ORDER BY [Name]

--Problem 8. Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS 
SELECT FirstName,LastName FROM Employees
WHERE DATEPART(YEAR,HireDate) > '2000'

--Problem 9. Length of Last Name
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

--Problem 10.	Rank Employees by Salary
SELECT * FROM 
(SELECT EmployeeID,FirstName,LastName,Salary,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) as DRank FROM Employees
WHERE Salary BETWEEN 10000 and 50000) as tmp
ORDER BY Salary DESC

--Problem 11. Find All Employees with Rank 2 *
SELECT * FROM 
(SELECT EmployeeID,FirstName,LastName,Salary,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) as DRank FROM Employees
WHERE Salary BETWEEN 10000 and 50000) as tmp
WHERE DRank = 2
ORDER BY Salary DESC

--Problem 12.Countries Holding ‘A’ 3 or More Times

SELECT CountryName, IsoCode FROM Countries
WHERE LOWER(CountryName) LIKE '%[a]%[a]%[a]%'
ORDER BY IsoCode

--Problem 13. Mix of Peak and River Names
SELECT PeakName, RiverName, LOWER(PeakName) +  LOWER(SUBSTRING(RiverName,2,(LEN(RiverName)-1))) AS mix FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY mix

--Problem 14. Games from 2011 and 2012 year
USE Diablo
SELECT TOP 50 [Name],CONVERT(varchar, [Start], 23) as Start FROM Games
WHERE DATEPART(YEAR,[Start]) in (2011,2012)
ORDER BY Start,[Name]

--Problem 15. User Email Providers
SELECT Username, RIGHT(Email,LEN(SUBSTRING(Email,1,LEN(Email) - CHARINDEX('@',Email)))) AS Email
FROM Users
ORDER BY Email,Username

--Problem 16. Get Users with IPAdress Like Pattern
SELECT Username,IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--Problem 17. Show All Games with Duration and Part of the Day
SELECT [Name],
CASE 
WHEN (DATEPART(hour,[Start]) BETWEEN 0 and 11) THEN 'Morning'
WHEN (DATEPART(hour,[Start]) BETWEEN 12 and 17) THEN 'Afternoon'
WHEN (DATEPART(hour,[Start]) BETWEEN 18 and 25) THEN 'Evening'
ELSE 'Unspecified'
END AS 'Part of the Day',
CASE 
WHEN (ISNULL(Duration,0) BETWEEN 1 and 3) THEN 'Extra Short'
WHEN (ISNULL(Duration,0) BETWEEN 4 and 6) THEN 'Short'
WHEN (ISNULL(Duration,0) > 6) THEN 'Long'
ELSE 'Extra Long'
END AS 'Duration'
FROM Games
ORDER BY [Name],[Duration],[Part of the Day]

--Problem 18. Orders Table
USE Orders
SELECT ProductName, OrderDate,
DATEADD(day,3,OrderDate) as 'Pay Due',
DATEADD(month,1,OrderDate) as 'Deliver Due'
FROM Orders

