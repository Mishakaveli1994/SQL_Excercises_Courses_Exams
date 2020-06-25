CREATE TABLE Logs(
	LogId INT IDENTITY PRIMARY KEY,
	AccountId INT,
	OldSum DECIMAL (15,2), 
	NewSum DECIMAL (15,2),
)

CREATE OR ALTER TRIGGER tr_TransactionLog ON Accounts AFTER UPDATE
AS
	INSERT INTO Logs(AccountId,OldSum,NewSum)
	SELECT i.AccountHolderId,d.Balance,i.Balance FROM inserted AS i
	JOIN deleted AS d ON i.AccountHolderId = d.AccountHolderId
	WHERE i.AccountHolderId = d.AccountHolderId AND i.Id = d.Id

UPDATE Accounts
SET Balance += 20
WHERE AccountHolderId = 1