CREATE DATABASE Airport
GO
USE Airport
GO
CREATE TABLE Planes(
	Id INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(30) NOT NULL,
	Seats INT NOT NULL,
	[Range] INT NOT NULL,
)
CREATE TABLE Flights(
	Id INT IDENTITY PRIMARY KEY,
	DepartureTime DATETIME,
	ArrivalTime DATETIME,
	Origin NVARCHAR(50) NOT NULL,
	Destination NVARCHAR(50) NOT NULL,
	PlaneId INT FOREIGN KEY REFERENCES Planes(Id) NOT NULL
)
CREATE TABLE Passengers(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Age INT CONSTRAINT CheckAge CHECK (Age >= 0) NOT NULL,
	[Address] NVARCHAR(30) NOT NULL,
	PassportId CHAR(11) NOT NULL
)
CREATE TABLE LuggageTypes(
	Id INT IDENTITY PRIMARY KEY,
	[Type] NVARCHAR(30) NOT NULL
)
CREATE TABLE Luggages(
	Id INT IDENTITY PRIMARY KEY,
	LuggageTypeId INT FOREIGN KEY REFERENCES LuggageTypes(Id) NOT NULL,
	PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL
)
CREATE TABLE Tickets(
	Id INT IDENTITY PRIMARY KEY,
	PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL,
	FlightId INT FOREIGN KEY REFERENCES Flights(Id) NOT NULL,
	LuggageId INT FOREIGN KEY REFERENCES Luggages(Id) NOT NULL,
	Price DECIMAL(15,2) NOT NULL
)