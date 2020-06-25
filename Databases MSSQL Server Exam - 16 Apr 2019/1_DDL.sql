CREATE DATABASE Airport
GO
USE Airport
GO

CREATE TABLE Planes(
	Id INT IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	Seats INT NOT NULL,
	[Range] INT NOT NULL,

	CONSTRAINT PK_Planes PRIMARY KEY (Id)
)

CREATE TABLE Flights(
	Id INT IDENTITY,
	DepartureTime DATETIME,
	ArrivalTime DATETIME,
	Origin VARCHAR(50) NOT NULL,
	Destination VARCHAR(50) NOT NULL,
	PlaneId INT NOT NULL,

	CONSTRAINT PK_Flights PRIMARY KEY (Id),
	CONSTRAINT FK_Flights_Planes FOREIGN KEY (PlaneId) REFERENCES Planes(Id)
)

CREATE TABLE Passengers(
	Id INT IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Age INT NOT NULL,
	[Address] VARCHAR(30) NOT NULL,
	PassportId CHAR(11) NOT NULL,

	CONSTRAINT PK_Passengers PRIMARY KEY (Id)
)

CREATE TABLE LuggageTypes(
	Id INT IDENTITY,
	[Type] VARCHAR(30) NOT NULL,

	CONSTRAINT PK_LuggageTypes PRIMARY KEY (Id)
)

CREATE TABLE Luggages(
	Id INT IDENTITY,
	LuggageTypeId INT NOT NULL,
	PassengerId INT NOT NULL,

	CONSTRAINT PK_Luggages PRIMARY KEY (Id),
	CONSTRAINT FK_Luggages_LuggageTypes FOREIGN KEY (LuggageTypeId) REFERENCES LuggageTypes(Id),
	CONSTRAINT FK_Luggages_Passengers FOREIGN KEY (PassengerId) REFERENCES Passengers(Id)
)
-- PassengerId for some reason one of the 'e' chars is faulty (different collation ?)
CREATE TABLE Tickets(
	Id INT IDENTITY,
	PassengerId INT NOT NULL,
	FlightId INT NOT NULL,
	LuggageId INT NOT NULL,
	Price DECIMAL(15,2) NOT NULL,

	CONSTRAINT PK_Tickets PRIMARY KEY (Id),
	CONSTRAINT FK_Tickets_Passengers FOREIGN KEY (PassengerId) REFERENCES Passengers(Id),
	CONSTRAINT FK_Tickets_Flights FOREIGN KEY (FlightId) REFERENCES Flights(Id),
	CONSTRAINT FK_Tickets_Luggages FOREIGN KEY (LuggageId) REFERENCES Luggages(Id)
)
