CREATE OR ALTER FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS VARCHAR(300)
AS
BEGIN
DECLARE @Result VARCHAR (300)
DECLARE @SuitableRoom INT =	(SELECT RoomId FROM
						(SELECT DISTINCT t.RoomId,
						RANK() OVER (ORDER BY (h.BaseRate + r.Price)* @People DESC) AS Rank
						FROM Hotels AS h
						JOIN Rooms AS r ON r.HotelId = h.Id
						LEFT JOIN Trips AS t ON t.RoomId = r.Id
						WHERE 
						h.Id = @HotelId
						AND r.Beds >= @People
						AND t.RoomId NOT IN (SELECT t.RoomId
											FROM Hotels AS h
											JOIN Rooms AS r ON r.HotelId = h.Id
											LEFT JOIN Trips AS t ON t.RoomId = r.Id
											WHERE h.Id = @HotelId
											AND r.Beds >= @People
											AND '2015-07-26' BETWEEN t.ArrivalDate AND t.ReturnDate AND t.CancelDate IS NULL))tmp
						WHERE Rank = 1)
IF (@SuitableRoom IS NOT NULL)
	BEGIN
	 	DECLARE @Price DECIMAL(15,2) = (SELECT (h.BaseRate + r.Price)* @People FROM Hotels AS h
		JOIN Rooms AS r ON r.HotelId = h.Id
		WHERE r.Id = @SuitableRoom
		)
		DECLARE @RoomType VARCHAR(300) = (SELECT r.[Type] FROM Hotels AS h
		JOIN Rooms AS r ON r.HotelId = h.Id
		WHERE r.Id = @SuitableRoom
		)
		DECLARE @Beds INT = (SELECT r.Beds FROM Hotels AS h
		JOIN Rooms AS r ON r.HotelId = h.Id
		WHERE r.Id = @SuitableRoom
		)
		SET @Result = 'Room ' + CAST(@SuitableRoom AS VARCHAR(100)) + ': ' + @RoomType + ' (' + CAST(@Beds AS VARCHAR (100)) + ' beds) - $' + CAST(@Price AS VARCHAR(100))
	END
ELSE
	SET @Result = 'No rooms available'
RETURN @Result
END