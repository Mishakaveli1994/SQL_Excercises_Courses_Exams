CREATE PROCEDURE usp_GetEmployeesFromTown (@TownName NVARCHAR(MAX))
AS
SELECT FirstName, LastName FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON t.TownID = a.TownID
WHERE t.[Name] = @TownName
GO

EXECUTE usp_GetEmployeesFromTown 'Sofia'