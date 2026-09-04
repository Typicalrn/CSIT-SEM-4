-- HospitalDB Activity 3 - Concise Version
CREATE DATABASE HospitalDB_activity3;
USE HospitalDB_activity3;

-- DDL
CREATE TABLE Patient(
 Patient_ID INT PRIMARY KEY, Name VARCHAR(25) NOT NULL,
 DoB DATE NOT NULL, Gender CHAR(1) NOT NULL,
 ContactNo VARCHAR(15) NOT NULL, Address TEXT NOT NULL
);

CREATE TABLE Department(
 Department_ID INT PRIMARY KEY, Name VARCHAR(25) NOT NULL,
 Description VARCHAR(60) NOT NULL
);

CREATE TABLE Doctor(
 Doctor_ID INT PRIMARY KEY, Name VARCHAR(25) NOT NULL,
 Specialization VARCHAR(40) NOT NULL, ContactNo VARCHAR(15) NOT NULL,
 Email VARCHAR(30) NOT NULL, Department_ID INT NOT NULL,
 FOREIGN KEY(Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Appointment(
 Appointment_ID INT PRIMARY KEY, Date DATE NOT NULL, Time TIME NOT NULL,
 Patient_ID INT NOT NULL, Doctor_ID INT NOT NULL,
 FOREIGN KEY(Patient_ID) REFERENCES Patient(Patient_ID),
 FOREIGN KEY(Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- DML
INSERT INTO Patient VALUES
(1,'Ram Sharma','2000-05-10','M','9876543201','Kathmandu'),
(2,'Sita Thapa','1998-08-20','F','9876543202','Lalitpur');

INSERT INTO Department VALUES
(101,'Cardiology','Heart-related treatment'),
(102,'Neurology','Nervous-system treatment');

INSERT INTO Doctor VALUES
(201,'Dr. Arun','Cardiologist','9811111111','arun@gmail.com',101),
(202,'Dr. Mina','Neurologist','9822222222','mina@gmail.com',102);

INSERT INTO Appointment VALUES
(301,'2026-08-20','10:00:00',1,201),
(302,'2026-08-21','11:30:00',2,202);

-- DQL: DISPLAY ALL DATA
SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Department;
SELECT * FROM Appointment;

-- APPOINTMENTS WITH PATIENT AND DOCTOR DETAILS
SELECT a.Appointment_ID,a.Date,a.Time,p.Name AS Patient,
       d.Name AS Doctor,d.Specialization
FROM Appointment a
JOIN Patient p ON a.Patient_ID=p.Patient_ID
JOIN Doctor d ON a.Doctor_ID=d.Doctor_ID;

-- DOCTORS WITH DEPARTMENTS
SELECT d.Name AS Doctor,d.Specialization,dp.Name AS Department
FROM Doctor d JOIN Department dp
ON d.Department_ID=dp.Department_ID;



/*
RELATIONAL ALGEBRA

1. Appointments with patient and doctor:
π Appointment_ID,Date,Time,Patient.Name,Doctor.Name,Specialization
((Appointment ⨝Appointment.Patient_ID=Patient.Patient_ID Patient)
 ⨝Appointment.Doctor_ID=Doctor.Doctor_ID Doctor)

2. Doctors with departments:
π Doctor.Name,Specialization,Department.Name
(Doctor ⨝Doctor.Department_ID=Department.Department_ID Department)

*/