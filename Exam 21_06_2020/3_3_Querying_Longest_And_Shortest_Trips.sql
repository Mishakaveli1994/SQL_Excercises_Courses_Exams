SELECT a.Id, 
	   a.FirstName + ' ' + a.LastName AS FullName,
	   MAX (DATEDIFF(DAY,ArrivalDate,ReturnDate)) AS LongestTrip,
	   MIN (DATEDIFF(DAY,ArrivalDate,ReturnDate)) AS ShortestTrip
FROM Accounts AS a
JOIN AccountsTrips AS act ON act.AccountId = a.Id
JOIN Trips AS t ON t.Id = act.TripId
WHERE t.CancelDate IS NULL AND a.MiddleName IS NULL
GROUP BY a.Id, a.FirstName + ' ' + a.LastName
ORDER BY LongestTrip DESC, ShortestTrip