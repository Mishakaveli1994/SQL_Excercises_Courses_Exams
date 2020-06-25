--5. The "Tr" Planes
SELECT * FROM Planes
WHERE [Name] LIKE '%tr%'
ORDER BY Id, [Name], Seats, [Range]

--6. Flight Profits
SELECT FlightId, SUM(Price) FROM Tickets
GROUP BY FlightId
ORDER BY SUM(Price) DESC, FlightId

--7. Passenger Trips
SELECT p.FirstName + ' ' + p.LastName AS 'Full Name',
f.Origin, f.Destination
FROM Tickets AS t
JOIN Flights AS f ON f.Id = t.FlightId
JOIN Passengers AS p ON p.Id = t.PassengerId
ORDER BY 'Full Name', f.Origin, f.Destination

--8. Non Adventures People
SELECT p.FirstName, p.LastName, p.Age FROM Passengers AS p
LEFT JOIN Tickets AS t ON t.PassengerId = p.Id
WHERE t.Id IS NULL
ORDER BY p.Age DESC, p.FirstName, p.LastName

--9. Full Info
SELECT 
p.FirstName + ' ' + p.LastName AS 'Full Name',
pl.[Name],
f.Origin + ' - ' + f.Destination,
lt.[Type]
FROM Tickets AS t
JOIN Passengers AS p ON t.PassengerId = p.Id
JOIN Flights AS f ON f.Id = t.FlightId
JOIN Planes AS pl ON pl.Id = f.PlaneId
JOIN Luggages AS lu ON lu.Id = t.LuggageId
JOIN LuggageTypes AS lt ON lt.Id = lu.LuggageTypeId
ORDER BY 'Full Name', pl.[Name], f.Origin, f.Destination,lt.[Type]

--10. PSP
SELECT p.[Name], p.Seats, COUNT(PassengerId) FROM Tickets AS t
RIGHT JOIN Flights AS f ON f.Id = t.FlightId
RIGHT JOIN Planes AS p ON p.Id = f.PlaneId
GROUP BY p.[Name], p.Seats
ORDER BY COUNT(PassengerId) DESC, p.[Name], p.Seats 