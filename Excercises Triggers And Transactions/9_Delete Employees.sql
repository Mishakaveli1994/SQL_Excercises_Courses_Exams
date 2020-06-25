CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY NOT NULL,
FirstName NVARCHAR(MAX) NOT NULL,
LastName NVARCHAR(MAX) NOT NULL,
MiddleName NVARCHAR(MAX) NOT NULL,
JobTitle NVARCHAR(MAX) NOT NULL,
DepartmentId INT NOT NULL,
Salary MONEY) 

CREATE TRIGGER tr_DeletedEmployees ON Employees AFTER DELETE
AS
BEGIN
INSERT INTO Deleted_Employees(FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary)
SELECT FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary FROM deleted AS d
END


SELECT * FROM Employees