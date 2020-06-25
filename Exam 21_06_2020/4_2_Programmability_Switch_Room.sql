CREATE OR ALTER PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
DECLARE @InitialRoomId INT = (SELECT RoomId FROM Trips WHERE Id = @TripId)
DECLARE @InitialHotelId INT = (SELECT HotelId FROM Rooms WHERE Id = @InitialRoomId)
DECLARE @TargetHotelId INT = (SELECT HotelId FROM Rooms WHERE Id = @TargetRoomId)
DECLARE @TargetAvailableBeds INT = (SELECT Beds FROM Rooms WHERE Id = @TargetRoomId)
DECLARE @TripAccounts INT = (SELECT COUNT(*) FROM AccountsTrips
							WHERE TripId = 10)

IF (@InitialHotelId != @TargetHotelId)
BEGIN
	THROW 50000, 'Target room is in another hotel!' , 16
END

IF (@TargetAvailableBeds < @TripAccounts)
BEGIN
	THROW 50001 , 'Not enough beds in target room!', 16
END 

UPDATE Trips
SET RoomId = @TargetRoomId