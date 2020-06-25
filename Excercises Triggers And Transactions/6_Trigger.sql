-- Create Trigger to check character and item level

CREATE TRIGGER tr_VerifyHeroLevel ON UserGameItems INSTEAD OF INSERT
AS
DECLARE @itemId INT = (SELECT ItemId FROM inserted)
DECLARE @userGameId INT = (SELECT UserGameId FROM inserted)

DECLARE @itemLevel INT = (SELECT MinLevel FROM Items WHERE id = @itemId)
DECLARE @userGameLevel INT = (SELECT [Level] FROM UsersGames WHERE Id = @userGameId)

IF (@userGameLevel >= @itemLevel)
BEGIN
	INSERT INTO UserGameItems(ItemId,UserGameId)
	VALUES (@itemId,@userGameId)
END
------------------------------------------------------------------------------------------------------
-- Updade with + 50000 Cash

UPDATE UsersGames
SET Cash += 50000
WHERE GameId = (SELECT Id FROM Games WHERE [Name] = 'Bali')
AND 
UserId In (SELECT Id FROM Users WHERE Username IN ('baleremuda', 'loosenoise',
'inguinalself', 'buildingdeltoid', 'monoxidecos'))
------------------------------------------------------------------------------------------------------
-- Buy Items
CREATE OR ALTER PROCEDURE usp_BuyItem(@userId INT, @GameId INT, @itemId INT)
AS
BEGIN TRANSACTION
DECLARE @User INT = (SELECT Id FROM Users WHERE Id = @userId)
DECLARE @Item INT = (SELECT Id FROM Items WHERE Id = @itemId)
IF (@User IS NULL OR @Item IS NULL)
BEGIN
	ROLLBACK;
	RAISERROR('Invalid user or item id!', 16, 1)
	RETURN
END

DECLARE @PlayerCash DECIMAL(15,2) = (SELECT Cash FROM UsersGames WHERE GameId = @GameId AND UserId = @userId)
DECLARE @ItemPrice DECIMAL(15,2) = (SELECT Price FROM Items WHERE Id = @itemId)
DECLARE @UserGameId INT = (SELECT Id FROM UsersGames WHERE GameId = @GameId AND UserId = @userId)

IF (@PlayerCash - @ItemPrice < 0)
BEGIN
	ROLLBACK;
	RAISERROR('Insufficient funds!', 16 , 2)
	RETURN
END

UPDATE UsersGames
SET Cash -= @ItemPrice
WHERE GameId = @GameId AND UserId = @userId

INSERT INTO UserGameItems(ItemId,UserGameId)
VALUES (@itemId, @UserGameId)

COMMIT
------------------------------------------------------------------------------------------------------
-- Create loop to verify above logic
DECLARE @ItId INT = 251;

WHILE (@ItId <= 299)
BEGIN
	EXEC usp_BuyItem 22, 212, @ItId
	EXEC usp_BuyItem 37, 212, @ItId
	EXEC usp_BuyItem 52, 212, @ItId
	EXEC usp_BuyItem 61, 212, @ItId
	EXEC usp_BuyItem 12, 212, @ItId
	SET @ItId += 1
END

SET @ItId = 501;

WHILE (@ItId <= 539)
BEGIN
	EXEC usp_BuyItem 22, 212, @ItId
	EXEC usp_BuyItem 37, 212, @ItId
	EXEC usp_BuyItem 52, 212, @ItId
	EXEC usp_BuyItem 61, 212, @ItId
	EXEC usp_BuyItem 12, 212, @ItId
	SET @ItId += 1
END
------------------------------------------------------------------------------------------------------
-- Sort required Output
SELECT u.Id, u.Username,g.[Name],ug.Cash,i.[Name] FROM Users AS u
	JOIN UsersGames AS ug ON ug.UserId = u.Id
	JOIN Games AS g ON g.Id = ug.GameId
	JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
	JOIN Items AS i ON i.Id = ugi.ItemId
WHERE g.[Name] = 'Bali' AND u.Username IN ('baleremuda', 'loosenoise',
'inguinalself', 'buildingdeltoid', 'monoxidecos')
ORDER BY u.Username,i.[Name]

