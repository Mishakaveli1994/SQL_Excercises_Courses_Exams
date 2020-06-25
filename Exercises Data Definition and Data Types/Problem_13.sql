CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(100) UNIQUE NOT NULL,
	Notes TEXT
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(100) UNIQUE NOT NULL,
	Notes TEXT
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(100) UNIQUE NOT NULL,
	Notes TEXT
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(100) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear SMALLINT CHECK (LEN(CopyrightYear) = 4),
	[Length] INT,
	GenreId INT NOT NULL,
	CategoryID INT NOT NULL,
	Rating TINYINT,
	Notes TEXT
)


INSERT INTO Directors(DirectorName)
VALUES 
	('John1'),
	('John2'),
	('John3'),
	('John4'),
	('John5')

INSERT INTO Genres(GenreName)
VALUES 
	('Horror'),
	('Comedy'),
	('Action'),
	('Romantic'),
	('Mystery')

INSERT INTO Categories(CategoryName)
VALUES 
	('Pie1'),
	('Pie2'),
	('Pie3'),
	('Pie4'),
	('Pie5')

INSERT INTO Movies(Title,DirectorId,CopyrightYear,GenreId,CategoryID)
VALUES
	('Movie1',1,1994,1,1),
	('Movie2',2,1995,2,2),
	('Movie3',3,1996,3,3),
	('Movie4',4,1997,4,4),
	('Movie5',5,1998,5,5)