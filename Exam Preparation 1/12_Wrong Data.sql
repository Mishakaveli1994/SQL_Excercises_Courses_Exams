CREATE PROCEDURE usp_CancelFlights
AS 
UPDATE Flights
SET DepartureTime = NULL , ArrivalTime = NULL
WHERE ArrivalTime > DepartureTime

EXECUTE usp_CancelFlights

SELECT * FROM Flights