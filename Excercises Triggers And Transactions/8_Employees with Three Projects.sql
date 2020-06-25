CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT) 
AS
	IF (SELECT COUNT(*) FROM EmployeesProjects WHERE EmployeeID = @emloyeeId) >= 3
	BEGIN
		RAISERROR('The employee has too many projects!', 16, 1)
		ROLLBACK
		RETURN
	END

INSERT INTO EmployeesProjects(EmployeeID,ProjectID)
VALUES(@emloyeeId,@projectID)