SELECT b.Id, a.FullName,a.[From],b.[Name] AS [To], b.Duration FROM
(SELECT a.FirstName + ' ' + ISNULL(a.MiddleName + ' ', '') + a.LastName AS 'FullName',
c.[Name] AS [From], act.TripId
FROM Accounts AS a
JOIN Cities AS c ON c.Id = a.CityId
JOIN AccountsTrips AS act ON act.AccountId = a.Id)a
JOIN
(SELECT DISTINCT c.[Name],t.Id,
CASE 
WHEN t.CancelDate IS NOT NULL THEN 'Cancelled'
ELSE CAST(DATEDIFF(DAY,t.ArrivalDate,t.ReturnDate) AS VARCHAR(100)) + ' days' END AS Duration
--SELECT * 
FROM AccountsTrips AS act
JOIN Trips AS t ON t.Id = act.TripId
JOIN Rooms AS r ON r.Id = t.RoomId
JOIN Hotels AS h ON h.Id = r.HotelId
LEFT JOIN Cities AS c ON c.Id = h.CityId)b
ON a.TripId = b.Id
ORDER BY a.FullName,a.TripId