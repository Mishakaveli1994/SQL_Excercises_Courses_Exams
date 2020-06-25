SELECT lt.[Type], COUNT(*) AS MostUsedLuggage FROM Passengers AS p
JOIN Luggages AS l ON l.PassengerId = p.Id
JOIN LuggageTypes AS lt ON lt.Id = l.LuggageTypeId
GROUP BY lt.[Type]
ORDER BY MostUsedLuggage DESC, lt.[Type]