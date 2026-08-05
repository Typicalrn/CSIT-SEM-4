-- =====================================
-- CREATE DATABASE
-- =====================================

CREATE DATABASE PetCareDB_activity1;

USE PetCareDB_activity1;

-- =====================================
-- CREATE OWNER TABLE
-- =====================================

CREATE TABLE Owner (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    contact VARCHAR(20) NOT NULL
);

-- =====================================
-- CREATE VET TABLE
-- =====================================

CREATE TABLE Vet (
    reg_no INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    address VARCHAR(255) NOT NULL,
    contact_no VARCHAR(20) NOT NULL,
    date_joined DATE NOT NULL,
    qualification_level VARCHAR(50),
    date_qualified DATE,
    vet_type VARCHAR(20) CHECK (vet_type IN ('Practising','Research'))
);

-- =====================================
-- CREATE PET TABLE
-- =====================================

CREATE TABLE Pet (
    chipped_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    colour VARCHAR(50),
    gender CHAR(1),
    age INT CHECK(age >= 0),
    owner_id INT NOT NULL,
    FOREIGN KEY (owner_id)
        REFERENCES Owner(owner_id)
);

-- =====================================
-- CREATE VISIT TABLE
-- =====================================

CREATE TABLE Visit (
    visit_id INT PRIMARY KEY,
    visit_date DATE NOT NULL,
    visit_time TIME NOT NULL,
    visit_type VARCHAR(50) NOT NULL,
    reg_no INT NOT NULL,
    chipped_id INT NOT NULL,
    FOREIGN KEY (reg_no)
        REFERENCES Vet(reg_no),
    FOREIGN KEY (chipped_id)
        REFERENCES Pet(chipped_id)
);

-- =====================================
-- CREATE PRESCRIPTION TABLE
-- =====================================

CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    drugs VARCHAR(100) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    expiry_date DATE,
    visit_id INT NOT NULL,
    FOREIGN KEY (visit_id)
        REFERENCES Visit(visit_id)
);

-- =====================================
-- INSERT OWNER DATA
-- =====================================

INSERT INTO Owner(name,address,contact)
VALUES
('John Smith','123 Main Street','9876543210'),
('Sarah Wilson','45 King Road','9812345678'),
('David Brown','67 Green Lane','9801122334');

-- =====================================
-- INSERT VET DATA
-- =====================================

INSERT INTO Vet
VALUES
(101,'Emma','Johnson','F','15 Clinic Road','9800000001','2020-01-15','Bachelor','2018-06-20','Practising'),
(102,'Michael','Taylor','M','22 Park Avenue','9800000002','2019-08-12','Masters','2017-05-15','Research');

-- =====================================
-- INSERT PET DATA
-- =====================================

INSERT INTO Pet
VALUES
(1001,'Buddy','Dog','Bulldog','Brown','M',5,1),
(1002,'Kitty','Cat','Persian','White','F',3,2),
(1003,'Rocky','Rabbit','Dutch','Grey','M',2,1);

-- =====================================
-- INSERT VISIT DATA
-- =====================================

INSERT INTO Visit
VALUES
(201,'2024-05-10','09:00:00','Check Up',101,1001),
(202,'2024-05-12','11:00:00','Dental',101,1002),
(203,'2024-05-14','02:30:00','Acute',102,1003);

-- =====================================
-- INSERT PRESCRIPTION DATA
-- =====================================

INSERT INTO Prescription
VALUES
(301,'Antibiotic','2 tablets daily',10,'2025-05-10',201),
(302,'Painkiller','1 tablet daily',5,'2025-06-01',203);

-- =====================================
-- DISPLAY ALL TABLES
-- =====================================

SHOW TABLES;

-- =====================================
-- VIEW ALL DATA
-- =====================================

SELECT * FROM Owner;

SELECT * FROM Vet;

SELECT * FROM Pet;

SELECT * FROM Visit;

SELECT * FROM Prescription;

-- =====================================
-- QUERY 1
-- List Pets with Owners
-- =====================================

SELECT p.name AS Pet_Name,
p.type,p.breed,o.name AS Owner_Name,o.contact
FROM Pet p JOIN Owner o ON p.owner_id = o.owner_id;

-- =====================================
-- QUERY 2
-- Visits with Vet Details
-- =====================================

SELECT
v.visit_id,v.visit_date,v.visit_time,v.visit_type,vt.first_name,vt.last_name,
p.name AS Pet_Name FROM Visit v JOIN Vet vt
ON v.reg_no = vt.reg_no JOIN Pet p
ON v.chipped_id = p.chipped_id;

-- =====================================
-- QUERY 3
-- Prescription Details
-- =====================================

SELECT
pr.prescription_id,pr.drugs,pr.dosage,pr.quantity,pr.expiry_date,
p.name AS Pet_Name
FROM Prescription pr JOIN Visit v
ON pr.visit_id = v.visit_id JOIN Pet p
ON v.chipped_id = p.chipped_id;

-- =====================================
-- QUERY 4
-- Number of Visits Per Vet
-- =====================================

SELECT
vt.reg_no,vt.first_name,vt.last_name,
COUNT(v.visit_id) AS Total_Visits
FROM Vet vt LEFT JOIN Visit v
ON vt.reg_no = v.reg_no
GROUP BY vt.reg_no,vt.first_name,vt.last_name;

-- =====================================
-- QUERY 5
-- Pets Owned by John Smith
-- =====================================

SELECT
o.name,p.name,p.type,p.breed
FROM Owner o JOIN Pet p
ON o.owner_id = p.owner_id
WHERE o.name='John Smith';