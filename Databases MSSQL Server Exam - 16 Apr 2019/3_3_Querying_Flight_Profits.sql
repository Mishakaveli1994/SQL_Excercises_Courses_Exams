SELECT t.FlightId, SUM(Price) AS Price FROM Tickets AS t
GROUP BY t.FlightId
ORDER BY Price DESC, t.FlightId