SELECT TOP(5) c.[Name] AS CategoryName, COUNT(r.CategoryId) AS ReportsNumber FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
GROUP BY c.[Name]
ORDER BY ReportsNumber DESC, CategoryName