CREATE TABLE People(
	Id BIGINT UNIQUE IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY (MAX) CHECK (DATALENGTH(Picture) <= 2048 * 1024),
	[Height] DECIMAL(5,2),
	[Weight] DECIMAL(5,2),
	[Gender] char(1) Not null CHECK(Gender='m' OR Gender='f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
)


INSERT INTO People(Name,Picture,Height,Weight,Gender,Birthdate,Biography)
VALUES
	('Misho',NULL,185,82,'m','1994-02-14','Yes'),
	('Misho1',NULL,185,82,'m','1994-02-14','Yes'),
	('Misho2',NULL,185,82,'m','1994-02-14','Yes'),
	('Misho3',NULL,185,82,'m','1994-02-14','Yes'),
	('Misho4',NULL,185,82,'m','1994-02-14','Yes')

SELECT * FROM People