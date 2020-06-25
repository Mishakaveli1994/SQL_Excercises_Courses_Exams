CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@Money MONEY)
AS
SELECT ah.FirstName, ah.LastName FROM AccountHolders AS ah
JOIN Accounts AS ac ON ah.Id = ac.AccountHolderId
GROUP BY FirstName, LastName, ah.Id
HAVING SUM(Balance) > @Money
ORDER BY ah.FirstName, ah.LastName