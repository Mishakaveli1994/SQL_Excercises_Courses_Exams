USE Bank
GO

CREATE TABLE NotificationEmails(
	Id INT IDENTITY PRIMARY KEY,
	Recipient NVARCHAR(200) NOT NULL,
	[Subject] NVARCHAR(MAX) NOT NULL,
	Body NVARCHAR(MAX) NOT NULL,
)

CREATE OR ALTER TRIGGER tr_SendMail ON Logs AFTER INSERT
AS
	INSERT INTO NotificationEmails(Recipient,[Subject],Body)
	SELECT i.AccountId,
	'Balance change for account: ' + CAST(i.AccountId AS nvarchar),
	'On ' + convert(varchar(32),GETDATE(),100) + ' your balance was changed from ' + CAST(i.OldSum AS nvarchar) + ' to ' + CAST(i.NewSum AS nvarchar) + '.'
	FROM inserted AS i

SELECT * FROM Accounts
ORDER BY AccountHolderId -- Use ID 8

UPDATE Accounts
SET Balance += 10
WHERE AccountHolderId = 8
SELECT * FROM NotificationEmails
