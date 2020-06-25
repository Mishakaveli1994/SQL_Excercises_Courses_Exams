CREATE OR ALTER FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	DECLARE @Hours INT = DATEDIFF(hh,@StartDate,@EndDate)
	RETURN ISNULL(@Hours,0)
END

SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours
   FROM Reports
