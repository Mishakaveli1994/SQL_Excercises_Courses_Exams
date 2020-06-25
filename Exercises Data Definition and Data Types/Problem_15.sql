CREATE DATABASE Hotel

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	Title NVARCHAR(100) NOT NULL,
	Notes TEXT
)

CREATE TABLE Customers(
	AccountNumber INT PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	PhoneNumber INT,
	EmergencyName NVARCHAR(100),
	EmergencyNumber INT,
	Notes TEXT
)

CREATE TABLE RoomStatus(
	RoomStatus NVARCHAR(100) PRIMARY KEY,
	Notes TEXT
)

CREATE TABLE RoomTypes(
	RoomType NVARCHAR(100) PRIMARY KEY,
	Notes TEXT
)

CREATE TABLE BedTypes(
	BedTypes NVARCHAR(100) PRIMARY KEY,
	Notes TEXT
)

CREATE TABLE Rooms(
	RoomNumber INT PRIMARY KEY,
	RoomType NVARCHAR(100) NOT NULL,
	BedTypes NVARCHAR(100) NOT NULL,
	Rate DECIMAL(5,2) NOT NULL,
	RoomStatus NVARCHAR(100) NOT NULL,
	Notes TEXT
)

CREATE TABLE Payments(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL,
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATETIME2 NOT NULL,
	LastDateOccupied DATETIME2 NOT NULL, 
	TotalDays INT NOT NULL,
	AmountCharged DECIMAL(5,2) NOT NULL,
	TaxRate DECIMAL(5,2) NOT NULL,
	TaxAmount DECIMAL(5,2) NOT NULL,
	PaymentTotal DECIMAL(5,2)NOT NULL,
	Notes TEXT
)

CREATE TABLE Occupancies(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL,
	DateOccupied DATETIME2 NOT NULL,
	AccountNumber INT NOT NULL,
	RoomNumber INT NOT NULL,
	RateApplied DECIMAL(5,2) NOT NULL,
	PhoneCharge DECIMAL(5,2) NOT NULL,
	Notes TEXT
)

INSERT INTO Employees(FirstName,LastName,Title)
VALUES
	('Mihail','Ivanov','Manager'),
	('Petar','Ivanov','Employee'),
	('Georgi','Ivanov','Employee')

INSERT INTO Customers(AccountNumber,FirstName,LastName)
VALUES
	(31231,'Betchi','Koketchi'),
	(31234,'Petar','Bastun'),
	(31212,'Koci','Baba')

INSERT INTO RoomStatus(RoomStatus)
VALUES
	('one'),
	('two'),
	('three')

INSERT INTO RoomTypes(RoomType)
VALUES
	('Luxury'),
	('Middle'),
	('Low')

INSERT INTO BedTypes(BedTypes)
VALUES
	('Double'),
	('King'),
	('Queen')

INSERT INTO Rooms(RoomNumber,RoomType,BedTypes,Rate,RoomStatus)
VALUES
	(101,'Luxury','Double',22.4,0),
	(102,'Middle','King',22.4,0),
	(103,'Low','Queen',22.4,0)

INSERT INTO Payments(EmployeeId ,PaymentDate ,AccountNumber ,FirstDateOccupied ,LastDateOccupied ,TotalDays ,AmountCharged ,TaxRate ,TaxAmount ,PaymentTotal)
VALUES
	(1,'02-02-1994',31231,'02-03-1994','02-04-1994',2,123.4,12.2,12.4,123.4),
	(2,'02-02-1994',31234,'02-03-1994','02-04-1994',2,123.4,12.2,12.4,123.4),
	(3,'02-02-1994',31212,'02-03-1994','02-04-1994',2,123.4,12.2,12.4,123.4)

INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge)
VALUES
	(1,'02-03-1994',31231,101,12.4,12.1),
	(2,'02-03-1994',31231,101,12.4,12.1),
	(3,'02-03-1994',31231,101,12.4,12.1)
