CREATE DATABASE Test
USE Test

CREATE TABLE Students(
	StudentID INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE Exams(
	ExamID INT NOT NULL,
	[Name] NVARCHAR(100) NOT NULL
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL
)


ALTER TABLE Students
ADD PRIMARY KEY (StudentID)

ALTER TABLE Exams
ADD PRIMARY KEY (ExamID)

ALTER TABLE StudentsExams
ADD PRIMARY KEY (StudentID,ExamID),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)

INSERT INTO Students(StudentID,[Name])
VALUES
	(1,'Mila'),
	(2,'Toni'),
	(3,'Ron')

INSERT INTO Exams(ExamID,[Name])
VALUES
	(101,'SpringMVC'),
	(102,'Neo4j'),
	(103,'Oracle 11g')

INSERT INTO StudentsExams(StudentID,ExamID)
VALUES
	(1,101),
	(1,102),
	(2,101),
	(3,103),
	(2,102),
	(2,103)