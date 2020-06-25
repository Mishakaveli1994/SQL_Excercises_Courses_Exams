CREATE OR ALTER FUNCTION udf_CalculateTickets(@origin NVARCHAR(MAX), @destination NVARCHAR(MAX), @peopleCount INT) 
RETURNS VARCHAR(100)
AS 
BEGIN
	IF (@peopleCount <= 0)
	BEGIN
		RETURN 'Invalid people count!'
	END

	DECLARE @FlightId INT
	SET @FlightId = (SELECT Id FROM Flights WHERE Origin = @origin AND Destination = @destination)
	IF @FlightId IS NULL
	BEGIN
		RETURN 'Invalid flight!'
	END
	DECLARE @TotalPrice DECIMAL(15,2)
	SET @TotalPrice = (SELECT Price FROM Tickets WHERE FlightId = @FlightId) * @peopleCount

RETURN 'Total price ' + CAST(@TotalPrice AS VARCHAR(30))
END

SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', 33)
SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', -1)
SELECT dbo.udf_CalculateTickets('Invalid','Rancabolang', 33)