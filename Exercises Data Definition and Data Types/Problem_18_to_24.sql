USE SoftUni

INSERT INTO Towns([Name])
VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO Addresses(AddressText,TownId)
VALUES
	('one',1),
	('two',2),
	('three',3),
	('four',4)

INSERT INTO Departments([Name])
VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees(FirstName,MiddleName,LastName,JobTitle,DepartmentId,HireDate,Salary,AddressId)
VALUES
	('Ivan','Ivanov','Ivanov','.NET,Developer',4,'2013-02-01',3500.00,1),
	('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00,2),
	('Maria','Petrova','Ivanova','Intern',5,'2016-8-28',525.25,3),
	('Georgi','Teziev','Ivanov','CEO',2,'2007-12-09',3000.00,4),
	('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88,4)

SELECT * FROM Towns
ORDER BY [Name]
SELECT * FROM Departments
ORDER BY [Name]
SELECT * FROM Employees
ORDER BY SALARY DESC

SELECT [Name] FROM Towns
ORDER BY [Name]
SELECT [Name] FROM Departments
ORDER BY [Name]
SELECT FirstName,LastName,JobTitle,Salary FROM Employees
ORDER BY Salary DESC

SELECT * FROM Employees
UPDATE Employees
SET Salary = Salary * 1.1
SELECT Salary FROM Employees

USE Hotel
UPDATE Payments
SET TaxRate = TaxRate - TaxRate*0.03
SELECT TaxRate FROM Payments