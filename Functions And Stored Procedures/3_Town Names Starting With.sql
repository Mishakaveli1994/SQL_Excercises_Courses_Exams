CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith (@StartsWIth NVARCHAR(MAX))
AS
SELECT [Name] FROM Towns
WHERE [Name] LIKE @StartsWIth + '%'
GO

EXECUTE usp_GetTownsStartingWith 'b'