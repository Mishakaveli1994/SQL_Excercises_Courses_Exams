USE Minions
ALTER TABLE Minions
ADD TownID INT FOREIGN KEY REFERENCES Towns(Id)
