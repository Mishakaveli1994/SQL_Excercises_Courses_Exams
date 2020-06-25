CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber
(@SalaryAbove DECIMAL (18,4))
AS 
SELECT FirstName, LastName FROM Employees
WHERE Salary >= @SalaryAbove
GO

EXECUTE usp_GetEmployeesSalaryAboveNumber 20000