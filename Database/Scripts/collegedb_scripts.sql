-- collegedb - Concise with Relational Algebra
-- Author: Aryan Maharjan | Roll: 1404 | Course: CSC-265 | Date: 05/26/2026

CREATE DATABASE collegedb;
USE collegedb;

-- DDL: Create tables
CREATE TABLE Courses(c_code INT(5) PRIMARY KEY, c_name VARCHAR(25) UNIQUE, c_credits INT(3),
  c_duration INT(2), c_fee INT(10));

CREATE TABLE Students(roll_number INT(5) PRIMARY KEY, name VARCHAR(30) NOT NULL, email VARCHAR(30) UNIQUE, 
    course_code INT(5) NOT NULL, FOREIGN KEY (course_code) REFERENCES Courses(c_code));

CREATE TABLE Subjects(s_code INT(5) PRIMARY KEY, s_name VARCHAR(25), s_credit INT(3) DEFAULT 3);

CREATE TABLE Course_Subjects(Course_code INT(5), subject_code INT(5), PRIMARY KEY(Course_code, subject_code),
    FOREIGN KEY(Course_code) REFERENCES Courses(c_code), FOREIGN KEY(subject_code) REFERENCES Subjects(s_code));

-- DML: Insert data
INSERT INTO Courses VALUES (1,'BCA',120,4,1700000), (2,'BBA',120,4,160000), (3,'BIM',120,4,150000);
-- Courses ∪ {(2,'BBA',120,4,160000)}

INSERT INTO Students VALUES (1,'Ram Thapa','ram@gmail.com',1), (2,'Shyyam Shrestha','shyam@gmail.com',2),
    (3,'Sita','sita@gmail.com',2), (4,'Hari Gautam','hari@gmail.com',1);

INSERT INTO Subjects VALUES (1,'DBMS',3), (2,'SE',4), (3,'SL',3), (4,'DL',3), (5,'AI',3);

INSERT INTO Course_Subjects VALUES (1,1), (1,2), (1,3), (1,4), (2,1), (3,1), (3,2), (3,3);

-- DML: Update and Delete
UPDATE Courses SET c_credits=130, c_fee=1800000 WHERE c_code=1;
-- Courses - σ(c_code=1)(Courses) ∪ {(1,'BCA',130,4,1800000)}

DELETE FROM Courses WHERE c_code=4;
-- Courses - σ(c_code=4)(Courses)

-- DQL: Basic queries
SELECT * FROM Courses;
SELECT c_code, c_name FROM Courses;  -- π(c_code,c_name)(Courses)
SELECT * FROM Courses WHERE c_code=2;  -- σ(c_code=2)(Courses)
SELECT * FROM Courses WHERE c_name='BCA';
SELECT * FROM Courses WHERE c_fee<1800000;
SELECT * FROM Students WHERE name LIKE 'a%';
SELECT * FROM Students ORDER BY name DESC;

-- Aggregate functions
SELECT COUNT(name) FROM Students;  -- G COUNT(name)(Students)
SELECT AVG(c_fee), MIN(c_fee) FROM Courses;
SELECT * FROM Courses WHERE c_fee BETWEEN 1000000 AND 2000000;

-- Joins
SELECT * FROM Courses, Students;  -- π*(Courses × Students)
SELECT c_name, name FROM Courses, Students WHERE Courses.c_code=Students.course_code;
SELECT c_name, name FROM Courses JOIN Students ON Courses.c_code=Students.course_code;
-- π(c_name,name)(σ(Courses ⨝(Courses.c_code=Students.course_code) Students))

-- 3-table join: courses and subjects
SELECT c_name, s_name FROM Courses JOIN Course_Subjects ON Courses.c_code=Course_Subjects.course_code
    JOIN Subjects ON Course_Subjects.subject_code=Subjects.s_code;
-- π(c_name,s_name)(σ((Courses ⨝(Courses.c_code=Course_Subjects.course_code) Course_Subjects) ⨝(Course_Subjects.subject_code=Subjects.s_code) (Courses × Subjects × Course_Subjects)))

-- 4-table join: students, courses, and subjects
SELECT name, c_name, s_name FROM Courses JOIN Course_Subjects ON Courses.c_code=Course_Subjects.course_code
    JOIN Subjects ON Subjects.s_code=Course_Subjects.subject_code JOIN Students ON Courses.c_code=Students.course_code;

-- Query catalog tables
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='Courses';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Students';

-- View
CREATE VIEW S_Students AS SELECT name AS Student_Name, email AS Student_Email FROM Students;
SELECT * FROM S_Students;

-- Stored Procedures
DELIMITER &

CREATE PROCEDURE get_student_count() BEGIN SELECT COUNT(roll_number) FROM Students; END &
CALL get_student_count() &

CREATE PROCEDURE get_student_by_roll_number(IN var1 INT) BEGIN SELECT * FROM Students WHERE roll_number=var1; END &
CALL get_student_by_roll_number(3) &

CREATE PROCEDURE display_course_code(OUT cc INT) BEGIN SELECT course_code INTO cc FROM Students WHERE roll_number=3; END &
CALL display_course_code(@C) & SELECT @C &

CREATE PROCEDURE display_code(INOUT var1 INT) BEGIN SELECT course_code INTO var1 FROM Students WHERE roll_number=var1; END &
SET @R=3 & CALL display_code(@R) & SELECT @R &

-- Trigger
CREATE TABLE Student_Marks(RollNo INT PRIMARY KEY, FirstName VARCHAR(100), EnglishMarks INT, PhysicsMarks INT, 
    ChemistryMarks INT, MathMarks INT, TotalMarks INT, Percentage FLOAT(5,3));

CREATE TRIGGER Student_Marks_Trigger BEFORE INSERT ON Student_Marks FOR EACH ROW
    SET NEW.TotalMarks=NEW.EnglishMarks+NEW.PhysicsMarks+NEW.ChemistryMarks+NEW.MathMarks,
    NEW.Percentage=(NEW.TotalMarks/400)*100;

INSERT INTO Student_Marks VALUES (1,'Ram',88,75,69,92,0,0);
SELECT * FROM Student_Marks;