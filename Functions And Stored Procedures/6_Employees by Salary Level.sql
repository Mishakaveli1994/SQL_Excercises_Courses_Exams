CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel(@SalaryLevel NVARCHAR(10))
AS
SELECT FirstName,LastName FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel

EXEC usp_EmployeesBySalaryLevel 'High'