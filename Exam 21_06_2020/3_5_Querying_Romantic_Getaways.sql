SELECT a.Id,a.Email,c.[Name],COUNT(t.Id) AS Trips FROM AccountsTrips AS act
JOIN Accounts AS a ON a.Id = act.AccountId
JOIN Trips AS t ON t.Id = act.TripId
JOIN Rooms AS r ON r.Id = t.RoomId
JOIN Hotels AS h ON h.Id = r.HotelId
JOIN Cities AS c ON c.Id = a.CityId
WHERE a.CityId = h.CityId
GROUP BY a.Id,a.Email,c.[Name]
ORDER BY Trips DESC, a.Id