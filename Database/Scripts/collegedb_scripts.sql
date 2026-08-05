/*  @author: Aryan Maharjan
    @date: 05/26/2026
    @rollNumber:1404
    @courseCode: CSC-265
    @databaseName: collegedb
*/

mysql -u root

show databases;

--Data Definition Language (DDL)
CREATE DATABASE collegedb;
USE collegedb;
SHOW TABLES;

CREATE TABLE Course(c_code INT(5), c_name VARCHAR(25),c_credits INT(3),c_duration INT(2));

RENAME TABLE Course TO Courses;

SHOW TABLES;
DESC Courses;

ALTER TABLE Courses ADD total_fee INT(10);

ALTER TABLE Courses ADD CONSTRAINT PK_Courses PRIMARY KEY (c_code);
ALTER TABLE Courses ADD CONSTRAINT UC_Coursename UNIQUE (c_name);

ALTER TABLE Courses RENAME COLUMN total_fee TO c_fee;--DIDN'T WORK
ALTER TABLE Courses CHANGE COLUMN `total_fee` `c_fee` INT(10);


CREATE TABLE Students(roll_number INT(5) PRIMARY KEY, name VARCHAR(30) NOT NULL,
            email VARCHAR(30) UNIQUE, course_code INT(5) NOT NULL,
            FOREIGN KEY (course_code) REFERENCES Courses(c_code));

CREATE TABLE Subjects(s_code INT(5) PRIMARY KEY,s_name VARCHAR(25),s_credit INT(3));

ALTER TABLE Subjects ALTER s_credit SET DEFAULT 3;


CREATE TABLE Course_Subjects(Course_code INT(5),subject_code INT(5),PRIMARY KEY(Course_code,subject_code),
            FOREIGN KEY(course_code) REFERENCES Courses(c_code),
            FOREIGN KEY(subject_code) REFERENCES Subjects(s_code));


--Data Manipulation Language (DML)
INSERT INTO Courses(c_code,c_name,c_credits,c_duration,c_fee) VALUES (1,"BCA",120,4,1700000);

SELECT * FROM Courses; --/DQL

INSERT INTO Courses VALUES(2,"BBA",120,4,160000);
--relaltional algebra
--Courses U{(2,"BBA",120,4,160000)}

INSERT INTO Courses VALUES(3,"BIM",120,4,150000),(4,"BIT",110,4,120000);

INSERT INTO Students VALUES(1,"Ram Thapa","ram@gmail.com",1),(2,"Shyyam Shrestha","shyam@gmail.com",2),
    (3,"Sita","sita@gmail.com",2),(4,"Hari Gautam","hari@gmail.com",1),
    (5,"Krishna Shrestha","krishna@gmail.com",3),(6,"Gita","gita@gmail.com",2);

INSERT INTO Subjects VALUES(1,"DBMS",3),(2,"SE",4),(3,"SL",3),(4,"DL",3);

INSERT INTO Subjects(s_code,s_name)VALUES(5,"AI");

INSERT INTO Course_Subjects VALUES(1,1),(1,2),(1,3),(1,4),(2,1),(3,1),(3,2),(3,3);

UPDATE Courses SET c_credits = 130,c_fee=1800000 WHERE c_code=1;
--Courses -σ(c_code=1)(Courses)
--Courses U{(1,"BCA",130,4,1700000)}

DELETE FROM Courses WHERE c_code='4';

--Courses -σ(c_code='4')(Courses)



--Data Quert Language(DQL)
SELECT * FROM Courses;

SELECT c_code,c_name FROM Courses;
--π(c_code,c_name)(Courses)

SELECT * FROM Courses WHERE c_code=2;
--π*(σ(c_code=2)(Courses))

SELECT * FROM Courses WHERE c_name="BCA";
SELECT * FROM Courses WHERE c_fee<1800000;
SELECT * FROM Courses WHERE c_fee<1800000 AND c_duration=3;
SELECT * FROM Students WHERE name LIKE 'a%';
SELECT * FROM Students ORDER BY name DESC;

SELECT COUNT(name) FROM Students;
--G COUNT(name)(Students)

SELECT AVG(c_fee) FROM Courses;
SELECT MIN(c_fee) FROM Courses;

SELECT * FROM Courses WHERE c_fee BETWEEN 1000000 AND 2000000;

 SELECT * FROM Courses,Students;--πx(Courses X Students)

 SELECT c_name,name FROM Courses,Students WHERE Courses.c_code=Students.course_code;
 --alternate
 SELECT C.c_name AS Course_Name,S.name AS Student_Name From Courses AS C,Students AS S WHERE C.c_code = S.course_code;

 SELECT c_name,name FROM Courses JOIN Students ON Courses.c_code=Students.course_code;
 --π(c_name,name)(σ(Courses ⨝(Courses.c_code=Students.course_code) Students)

 --list of courses and subjects offered in those courses(joining 3 tables)
SELECT c_name,s_name FROM Courses JOIN Course_Subjects ON Courses.c_code=Course_Subjects.course_code
JOIN Subjects ON Course_Subjects.subject_code=Subjects.s_code;

--another way
SELECT c_name,s_name FROM Courses, sUBJECTS, Course_Subjects WHERE Courses.c_code=Course_Subjects.course_code 
AND Subjects.s_code=Course_Subjects.subject_code;
 
--π(c_name,s_name)σ((Courses ⨝(Courses.c_code=Course_Subjects.course_code) Course_Subjects) ⨝
--(Course_Subjects.subject_code=Subjects.s_code) (Courses X Subjects X Course_Subjects))

 --write sql to find names of students, the courses they study and the subjects of those courses.(joining 4 tables)
    SELECT name,c_name,s_name FROM Courses JOIN Course_Subjects ON Courses.c_code=Course_Subjects.course_code
    JOIN Subjects on Subjects.s_code=Course_Subjects.subject_code
JOIN Students ON Courses.c_code=Students.course_code;


--constraints details
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Courses';

SELECT c_name,s_name FROM Courses JOIN Course_Subjects ON Courses.c_code=Course_Subjects.course_code
JOIN Subjects on Subjects.s_code=Course_Subjects.subject_code;


---Query catalog tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES;

--view columsn of a table:
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Students';

--backup database
mysqldump -u root collegedb > collegedb_9_June_2026.sql

--restore database
mysql -u root collegedbrestore < collegedb_9_June_2026.sql

--view
CREATE VIEW S_Students AS
SELECT name AS Student_Name, email AS Student_Email FROM Students;

SELECT * FROM S_Students;


--pl sql
use collegedb;

DELIMITER &

--1. procedure without parameters
--create procedure
CREATE PROCEDURE get_student_count()
BEGIN
    SELECT COUNT(roll_number) FROM Students;
END &

--invoke a stored precedure
CALL get_student_count() &

--show list of proocedures
SHOW PROCEDURE STATUS WHERE db='collegedb' &

DROP PROCEDURE get_student_count &

--2 Procedure with IN parameters
--DELIMITER &

CREATE PROCEDURE get_student_by_roll_number(IN var1 INT)
    BEGIN
        SELECT * FROM Students WHERE roll_number=var1;
    END &

CALL get_student_by_roll_number(3) &

--3 procedure with OUT parameters
--DELIMITER & 
CREATE PROCEDURE display_course_code(OUT cc INT)
BEGIN
    SELECT course_code INTO cc FROM Students WHERE roll_number='3';
END &

CALL display_course_code(@C)&

SELECT @C&

--4. procedure with INOUT parameters

CREATE PROCEDURE display_code(INOUT var1 INT)
BEGIN
 SELECT course_code INTO var1 FROM Students WHERE roll_number = var1;
 END &

 SET @R='3'&
 CALL display_code(@R)&
 SELECT @R&

 --triggers
 CREATE TABLE Student_Marks(
    RollNo INT PRIMARY KEY,
    FirstName VARCHAR(100),
    EnglishMarks INT,
    PhysicsMarks INT,
    ChemistryMarks INT,
    MathMarks INT,
    TotalMarks INT,
    Percentage FLOAT(5,3)
 );


 CREATE TRIGGER Student_Marks_Trigger
 BEFORE INSERT ON Student_Marks
 FOR EACH ROW
 SET NEW.TotalMarks = new.EnglishMarks +new.PhysicsMarks + new.ChemistryMarks + new.MathMarks,
 new.Percentage =(new.TotalMarks/400)*100;

 INSERT INTO Student_Marks (RollNo,FirstName,EnglishMarks,PhysicsMarks,ChemistryMarks,MathMarks,TotalMarks,Percentage) VALUES 
 (1,'Ram',88,75,69,92,0,0);

 SELECT * FROM Student_Marks;
