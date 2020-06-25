CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
BEGIN
	DECLARE @SalaryLevel NVARCHAR(10)
	IF (@salary IS NULL)
		SET @SalaryLevel = NULL
	IF (@salary < 30000)
		SET @SalaryLevel = 'Low'
	ELSE IF (@salary <= 50000)
		SET @SalaryLevel = 'Average'
	ELSE IF (@salary > 50000)
		SET @SalaryLevel = 'High'
RETURN @SalaryLevel
END

SELECT [dbo].[ufn_GetSalaryLevel](50000)