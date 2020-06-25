UPDATE Tickets
SET Price += Price * 0.13
FROM 
Tickets AS t JOIN Flights AS f ON t.FlightId = f.Id
WHERE f.Destination = 'Carlsbad'
