/*====================================================
        HOSPITAL MANAGEMENT SYSTEM DATABASE
======================================================*/

-- Create Database
CREATE DATABASE HospitalDB_activity3;

-- Use Database
USE HospitalDB_activity3;

------------------------------------------------------
-- Create Department Table
------------------------------------------------------

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

------------------------------------------------------
-- Create Doctor Table
------------------------------------------------------

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    DepartmentID INT NOT NULL,

    CONSTRAINT FK_Doctor_Department
    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
);

------------------------------------------------------
-- Create Patient Table
------------------------------------------------------

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(20),
    Address VARCHAR(255)
);

------------------------------------------------------
-- Create Appointment Table
------------------------------------------------------

CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,

    CONSTRAINT FK_Appointment_Patient
    FOREIGN KEY (PatientID)
    REFERENCES Patient(PatientID),

    CONSTRAINT FK_Appointment_Doctor
    FOREIGN KEY (DoctorID)
    REFERENCES Doctor(DoctorID)
);

------------------------------------------------------
-- Insert Department Data
------------------------------------------------------

INSERT INTO Department (DepartmentName, Description)
VALUES
('Cardiology','Heart diseases'),
('Neurology','Brain and nervous system'),
('Orthopedics','Bone and joint treatment'),
('Pediatrics','Children healthcare'),
('Dermatology','Skin treatment');

------------------------------------------------------
-- Insert Doctor Data
------------------------------------------------------

INSERT INTO Doctor
(Name, Specialization, ContactNumber, Email, DepartmentID)
VALUES
('Dr. John Smith','Cardiologist','9801111111','john@hospital.com',1),
('Dr. Emily Brown','Neurologist','9802222222','emily@hospital.com',2),
('Dr. David Lee','Orthopedic','9803333333','david@hospital.com',3),
('Dr. Sarah Wilson','Pediatrician','9804444444','sarah@hospital.com',4),
('Dr. Michael Green','Dermatologist','9805555555','michael@hospital.com',5);

------------------------------------------------------
-- Insert Patient Data
------------------------------------------------------

INSERT INTO Patient
(Name, DateOfBirth, Gender, ContactNumber, Address)
VALUES
('Aryan Maharjan','2002-08-15','Male','9812345678','Kathmandu'),
('John Doe','1998-03-10','Male','9809876543','Pokhara'),
('Emma Watson','1995-11-20','Female','9841234567','Lalitpur'),
('Sophia Brown','2001-07-08','Female','9856781234','Bhaktapur');

------------------------------------------------------
-- Insert Appointment Data
------------------------------------------------------

INSERT INTO Appointment
(PatientID, DoctorID, AppointmentDate, AppointmentTime)
VALUES
(1,1,'2025-07-01','09:00:00'),
(2,2,'2025-07-01','10:30:00'),
(3,3,'2025-07-02','11:00:00'),
(4,4,'2025-07-03','02:00:00'),
(1,5,'2025-07-05','03:30:00');

------------------------------------------------------
-- Show Tables
------------------------------------------------------

SHOW TABLES;

------------------------------------------------------
-- View Data
------------------------------------------------------

SELECT * FROM Department;

SELECT * FROM Doctor;

SELECT * FROM Patient;

SELECT * FROM Appointment;

------------------------------------------------------
-- Query 1
-- Display Patients with their Appointments
------------------------------------------------------

SELECT
P.PatientID,
P.Name,
A.AppointmentDate,
A.AppointmentTime
FROM Patient P
JOIN Appointment A
ON P.PatientID = A.PatientID;

------------------------------------------------------
-- Query 2
-- Display Doctors and Their Departments
------------------------------------------------------

SELECT
D.DoctorID,
D.Name,
D.Specialization,
DP.DepartmentName
FROM Doctor D
JOIN Department DP
ON D.DepartmentID = DP.DepartmentID;

------------------------------------------------------
-- Query 3
-- Display Appointment Details
------------------------------------------------------

SELECT
A.AppointmentID,
P.Name AS Patient,
D.Name AS Doctor,
DP.DepartmentName,
A.AppointmentDate,
A.AppointmentTime
FROM Appointment A
JOIN Patient P
ON A.PatientID = P.PatientID
JOIN Doctor D
ON A.DoctorID = D.DoctorID
JOIN Department DP
ON D.DepartmentID = DP.DepartmentID;

------------------------------------------------------
-- Query 4
-- Count Appointments Per Doctor
------------------------------------------------------

SELECT
D.Name,
COUNT(A.AppointmentID) AS TotalAppointments
FROM Doctor D
LEFT JOIN Appointment A
ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorID, D.Name;

------------------------------------------------------
-- Query 5
-- Count Appointments Per Patient
------------------------------------------------------

SELECT
P.Name,
COUNT(A.AppointmentID) AS TotalAppointments
FROM Patient P
LEFT JOIN Appointment A
ON P.PatientID = A.PatientID
GROUP BY P.PatientID, P.Name;

------------------------------------------------------
-- Query 6
-- List Doctors in Cardiology Department
------------------------------------------------------

SELECT
Name,
Specialization
FROM Doctor
WHERE DepartmentID = 1;

------------------------------------------------------
-- Query 7
-- Today's Appointments
------------------------------------------------------

SELECT
P.Name AS Patient,
D.Name AS Doctor,
AppointmentDate,
AppointmentTime
FROM Appointment A
JOIN Patient P
ON A.PatientID = P.PatientID
JOIN Doctor D
ON A.DoctorID = D.DoctorID
WHERE AppointmentDate = CURDATE();

------------------------------------------------------
-- Query 8
-- Total Doctors in Each Department
------------------------------------------------------

SELECT
DP.DepartmentName,
COUNT(D.DoctorID) AS TotalDoctors
FROM Department DP
LEFT JOIN Doctor D
ON DP.DepartmentID = D.DepartmentID
GROUP BY DP.DepartmentID, DP.DepartmentName;

------------------------------------------------------
-- Query 9
-- Patients Seen by Each Doctor
------------------------------------------------------

SELECT
D.Name AS Doctor,
P.Name AS Patient,
A.AppointmentDate
FROM Appointment A
JOIN Doctor D
ON A.DoctorID = D.DoctorID
JOIN Patient P
ON A.PatientID = P.PatientID
ORDER BY D.Name;

------------------------------------------------------
-- Query 10
-- Complete Appointment Report
------------------------------------------------------

SELECT
A.AppointmentID,
P.Name AS PatientName,
P.Gender,
D.Name AS DoctorName,
D.Specialization,
DP.DepartmentName,
A.AppointmentDate,
A.AppointmentTime
FROM Appointment A
JOIN Patient P
ON A.PatientID = P.PatientID
JOIN Doctor D
ON A.DoctorID = D.DoctorID
JOIN Department DP
ON D.DepartmentID = DP.DepartmentID
ORDER BY A.AppointmentDate, A.AppointmentTime;