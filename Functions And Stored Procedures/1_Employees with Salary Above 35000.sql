USE SoftUni
GO

--1. Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT FirstName, LastName FROM Employees
	WHERE Salary > 35000
GO

EXECUTE usp_GetEmployeesSalaryAbove35000
