SELECT ISNULL(e.FirstName + ' ' + e.LastName,'None') AS Fullname,
ISNULL(d.[Name],'None'),c.[Name],r.[Description],FORMAT(r.OpenDate,'dd.MM.yyyy') AS OpenDate,
st.[Label],u.[Name]
FROM Reports AS r
LEFT JOIN Employees AS e ON e.Id = r.EmployeeId
LEFT JOIN Departments AS d ON d.Id = e.DepartmentId
LEFT JOIN Categories AS c ON c.Id = r.CategoryId
LEFT JOIN [Status] AS st ON st.Id = r.StatusId
LEFT JOIN Users AS u ON u.Id = r.UserId
ORDER BY FirstName DESC, LastName DESC, d.[Name],c.[Name],r.[Description],OpenDate,st.[Label],u.[Name]  