CREATE DATABASE CarRental

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(200) NOT NULL,
	DailyRate DECIMAL(5,2) NOT NULL,
	WeeklyRate DECIMAL(5,2) NOT NULL,
	MonthlyRate DECIMAL(5,2) NOT NULL,
	WeekendRate DECIMAL(5,2) NOT NULL,
)

CREATE TABLE Cars(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber INT NOT NULL,
	Manufacturer NVARCHAR(100) NOT NULL,
	Model NVARCHAR(100) NOT NULL,
	CarYear SMALLINT CHECK (LEN(CarYear) = 4),
	CategoryId INT NOT NULL,
	Doors TINYINT,
	Picture VARBINARY(MAX),
	Condition NVARCHAR(100),
	Available BIT NOT NULL
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50),
	Notes TEXT,
)

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY,
	DriverLicenceNumber INT NOT NULL,
	FullName NVARCHAR(100) NOT NULL,
	[Address] NVARCHAR(100) NOT NULL,
	City NVARCHAR(100),
	ZIPCode SMALLINT,
	Notes TEXT
)


CREATE TABLE RentalOrders(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	TankLevel DECIMAL(5,2),
	KilometrageStart DECIMAL(30,2),
	KilometrageEnd DECIMAL(30,2),
	TotalKilometrage DECIMAL(30,2),
	StartDate DATETIME2,
	EndDate DATETIME2,
	TotalDays SMALLINT,
	RateApplied DECIMAL(5,2),
	TaxRate DECIMAL(5,2),
	OrderStatus BIT,
	Notes TEXT
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
	('Sedan',10.2,11.2,12.2,13.2),
	('Coupe',10.2,11.2,12.2,13.2),
	('Cabrio',10.2,11.2,12.2,13.2)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Condition, Available)
VALUES
	(11231234,'Ford','Siesta',1994,1,4,'Good',0),
	(11243234,'Toyota','Corolla',1995,2,4,'Bad',0),
	(11111234,'Mitsubishi','Lancer',1997,3,4,'Excellent',0)

INSERT INTO Employees(FirstName, LastName, Title)
VALUES
	('Mihail','Ivanov','Mishaka'),
	('Stoyan','Georgiev','Caki'),
	('Lugata','Brat','Seshtashse')

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode)
VALUES
	(123123123,'Ivan Petrov','dasasdagf fgdssadf','Sofia',1404),
	(123333123,'Ivan Petrov2','dasasdagf fgdssadf','Sofia',1404),
	(123123123,'Ivan Petrov3','dasasdagf fgdssadf','Sofia',1404)

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus)
VALUES
	(1,1,1,12.3,12.1,12.2,12.3,'12-12-2020','12-12-2020',12,12.1,10.1,1),
	(2,2,2,12.3,12.1,12.2,12.3,'12-12-2020','12-12-2020',12,12.1,10.1,1),
	(3,3,3,12.3,12.1,12.2,12.3,'12-12-2020','12-12-2020',12,12.1,10.1,1)