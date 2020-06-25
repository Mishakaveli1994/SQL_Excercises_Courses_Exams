CREATE OR ALTER PROCEDURE usp_DepositMoney (@AccountId INT, @MoneyAmount DECIMAL (15,4))
AS
	IF (SELECT COUNT(*) FROM Accounts WHERE Id = @AccountId) != 1
		THROW 50000, 'The specified account does not exist!.' , 1;

	IF @MoneyAmount < 0
		THROW 50001, 'The specified money amount is invalid!.' , 1;

	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id = @AccountId

	SELECT id, FORMAT(Balance, '0.0000') FROM Accounts
	WHERE Id = @AccountId

EXECUTE usp_DepositMoney 1, 10

SELECT * FROM Accounts