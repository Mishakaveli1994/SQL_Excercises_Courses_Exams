CREATE PROCEDURE usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
DECLARE @EmployeeDepartment INT = (SELECT e.DepartmentID FROM Employees AS e 
								   WHERE e.Id = @EmployeeId)
DECLARE @ReportDepartment INT = (SELECT d.Id FROM Reports AS r
								 JOIN Categories AS c ON c.Id = r.CategoryId
								 JOIN Departments AS d ON d.Id = c.DepartmentId
								 WHERE r.Id = @ReportId)
IF (@EmployeeDepartment != @ReportDepartment)
	THROW 50000, 'Employee doesn''t belong to the appropriate department!', 16
ELSE
UPDATE Reports 
SET EmployeeId = @EmployeeId
WHERE Id = @ReportId
