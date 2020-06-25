CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	SET @setOfLetters = LOWER(@SetOfLetters)
	SET @word = LOWER(@word)
	DECLARE @Count INT = 1

	WHILE @Count <= LEN(@word)
	BEGIN
		IF CHARINDEX(SUBSTRING(@word,@Count,1),@setOfLetters) > 0
			SET @Count += 1
		ELSE
			RETURN 0
	END
	RETURN 1
END



SELECT dbo.ufn_IsWordComprised('oistmiahf','halves')

SELECT dbo.ufn_IsWordComprised('bobr','Rob')

SELECT dbo.ufn_IsWordComprised('pppp','Guy')
