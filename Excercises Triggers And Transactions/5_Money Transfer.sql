CREATE PROCEDURE usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL(15,4))
AS
	-- Check if the sender ID is valid
	IF (SELECT COUNT(*) FROM Accounts WHERE Id = @SenderId) != 1
		THROW 50000, 'Invalid Sender ID!', 1
	-- Check if the receiver ID is valid
	IF (SELECT COUNT(*) FROM Accounts WHERE Id = @ReceiverId) != 1
		THROW 50001, 'Invalid Receiver ID!', 1
	-- Check if the money amount is valid
	IF @Amount < 0
		THROW 50001, 'Invalid money amount!', 1
	-- Check if the sender has enough money
	IF (SELECT Balance FROM Accounts WHERE id = @SenderId) < @Amount
		THROW 50001, 'Insufficient amont of money!', 1

	UPDATE Accounts
	SET Balance -= @Amount
	WHERE id = @SenderId

	UPDATE Accounts
	SET Balance += @Amount
	WHERE id = @ReceiverId