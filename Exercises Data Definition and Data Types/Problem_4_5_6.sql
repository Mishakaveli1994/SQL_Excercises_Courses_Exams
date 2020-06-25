USE Minions
INSERT INTO Towns (Id,[Name])
	VALUES
		(1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna')
SELECT * FROM Towns

USE Minions
INSERT INTO Minions (Id,[Name],Age,TownID)
	VALUES
		(1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)

TRUNCATE TABLE Minions

DROP TABLE Minions
DROP TABLE Towns