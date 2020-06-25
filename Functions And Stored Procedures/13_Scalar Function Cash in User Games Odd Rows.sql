CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@gName NVARCHAR(MAX))
RETURNS @result TABLE(SumCash MONEY)AS
BEGIN
WITH Games_CTE (SumCash) AS
	(SELECT SUM(Cash) FROM
	(SELECT ROW_NUMBER() OVER(PARTITION BY g.[Name] ORDER BY Cash DESC) AS RowNum, ug.Cash FROM dbo.UsersGames AS ug
	JOIN Games AS g ON g.Id = ug.GameId
	WHERE g.[Name] = @gName)tmp
	WHERE RowNum % 2 <> 0)
	INSERT INTO @result SELECT SumCash FROM Games_CTE
	RETURN
END
GO

select*
from dbo.ufn_CashInUsersGames('Love in a mist') prd