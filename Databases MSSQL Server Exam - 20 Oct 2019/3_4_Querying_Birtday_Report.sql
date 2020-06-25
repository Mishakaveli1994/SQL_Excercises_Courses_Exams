SELECT u.Username, c.[Name] FROM Reports AS r
JOIN Categories AS c ON c.Id = r.CategoryId
JOIN Users AS u ON u.Id = r.UserId
WHERE FORMAT(u.BirthDate, 'mm-dd') = FORMAT(r.OpenDate, 'mm-dd') 
ORDER BY u.Username, c.[Name]