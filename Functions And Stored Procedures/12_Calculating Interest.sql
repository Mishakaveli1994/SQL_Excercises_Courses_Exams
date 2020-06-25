CREATE OR ALTER PROCEDURE CalculateFutureValueForAccount(@AccId INT, @Interest FLOAT)
AS
BEGIN
	SELECT ah.Id AS 'Account Id',
	ah.FirstName AS 'First Name',
	ah.LastName AS 'Last Name',
	ac.Balance AS 'Current Balance',
	dbo.ufn_CalculateFutureValue(ac.Balance,@Interest,5) AS 'Balance in 5 years'
	FROM AccountHolders AS ah
	JOIN Accounts AS ac ON ac.AccountHolderId = ah.Id
	WHERE ac.Id = @AccId
END

GO

EXECUTE CalculateFutureValueForAccount 1,0.1

SELECT * FROM Accounts