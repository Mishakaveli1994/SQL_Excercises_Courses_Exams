--2. Insert
INSERT INTO Planes([Name],Seats,[Range])
VALUES
	('Airbus 336', 112, 5132),
	('Airbus 330', 432, 5325),
	('Boeing 369', 231, 2355),
	('Stelt 297', 254, 2143) ,
	('Boeing 338', 165, 5111),
	('Airbus 558', 387, 1342),
	('Boeing 128', 345, 5541)

INSERT INTO LuggageTypes([Type])
VALUES
	('Crossbody Bag'),
	('School Backpack'),
	('Shoulder Bag')

--3. Update
UPDATE Tickets
SET Price += Price * 0.13
FROM Flights AS f
JOIN Tickets AS t ON f.Id = t.FlightId
WHERE f.Destination = 'Carlsbad'

--4. Delete

DECLARE @FlightId INT = (SELECT f.Id FROM Flights AS f
WHERE f.Destination = 'Ayn Halagim')

DELETE FROM Tickets WHERE FlightId = @FlightId
DELETE FROM Flights WHERE Id = @FlightId
