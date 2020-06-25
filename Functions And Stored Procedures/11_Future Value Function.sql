CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(@sum DECIMAL (18,4),@yyr FLOAT,@years INT)
RETURNS DECIMAL (18, 4)
AS
BEGIN
	RETURN @sum * POWER((1 +@yyr),@years)
END
GO
SELECT dbo.ufn_CalculateFutureValue(1000,0.1,5)

