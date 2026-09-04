CREATE DATABASE PetCareDB_activity1;
USE PetCareDB_activity1;

-- DDL
CREATE TABLE Owner(
 owner_id INT AUTO_INCREMENT PRIMARY KEY,
 contact VARCHAR(20) NOT NULL,
 name VARCHAR(100) NOT NULL,
 address VARCHAR(255) NOT NULL
);

CREATE TABLE Vet(
 reg_no INT PRIMARY KEY, first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL, gender CHAR(1) NOT NULL,
 address VARCHAR(255) NOT NULL, contact_no VARCHAR(20) NOT NULL,
 date_joined DATE NOT NULL
);

CREATE TABLE Pet(
 chipped_id INT PRIMARY KEY, name VARCHAR(100) NOT NULL,
 type VARCHAR(50) NOT NULL, breed VARCHAR(100),
 owner_id INT NOT NULL,
 FOREIGN KEY(owner_id) REFERENCES Owner(owner_id)
);

CREATE TABLE Visit(
 visit_id INT PRIMARY KEY, type VARCHAR(50) NOT NULL, date DATE NOT NULL,
 reg_no INT NOT NULL, chipped_id INT NOT NULL,
 FOREIGN KEY(reg_no) REFERENCES Vet(reg_no),
 FOREIGN KEY(chipped_id) REFERENCES Pet(chipped_id)
);

CREATE TABLE Prescription(
 id INT PRIMARY KEY, drugs VARCHAR(150) NOT NULL, dosage VARCHAR(100) NOT NULL,
 quantity INT NOT NULL, expiry_date DATE, visit_id INT NOT NULL,
 FOREIGN KEY(visit_id) REFERENCES Visit(visit_id)
);

-- DML
INSERT INTO Owner(contact,name,address) VALUES
('9876543210','John Smith','123 Main Street'),
('9812345678','Sarah Wilson','45 King Road'),
('9801122334','David Brown','67 Green Lane');

INSERT INTO Vet VALUES
(101,'Emma','Johnson','F','15 Clinic Road','9800000001','2020-01-15'),
(102,'Michael','Taylor','M','22 Park Avenue','9800000002','2019-08-12');

INSERT INTO Pet VALUES
(1001,'Buddy','Dog','Bulldog',1),
(1002,'Kitty','Cat','Persian',2),
(1003,'Rocky','Rabbit','Dutch',1);

INSERT INTO Visit VALUES
(201,'Check Up','2024-05-10',101,1001),
(202,'Dental','2024-05-12',101,1002),
(203,'Acute','2024-05-14',102,1003);

INSERT INTO Prescription VALUES
(301,'Antibiotic','2 tablets daily',10,'2025-05-10',201),
(302,'Painkiller','1 tablet daily',5,'2025-06-01',203);

-- DQL
SELECT * FROM Owner;
SELECT * FROM Vet;
SELECT * FROM Pet;
SELECT * FROM Visit;
SELECT * FROM Prescription;

SELECT p.name AS Pet_Name,p.type,p.breed,o.name AS Owner_Name,o.contact
FROM Pet p JOIN Owner o ON p.owner_id=o.owner_id;

SELECT v.visit_id,v.type,v.date,vt.first_name,vt.last_name,p.name AS Pet_Name
FROM Visit v JOIN Vet vt ON v.reg_no=vt.reg_no
JOIN Pet p ON v.chipped_id=p.chipped_id;

SELECT pr.id,pr.drugs,pr.dosage,pr.quantity,pr.expiry_date,p.name AS Pet_Name
FROM Prescription pr JOIN Visit v ON pr.visit_id=v.visit_id
JOIN Pet p ON v.chipped_id=p.chipped_id;

SELECT vt.reg_no,vt.first_name,vt.last_name,COUNT(v.visit_id) AS Total_Visits
FROM Vet vt LEFT JOIN Visit v ON vt.reg_no=v.reg_no
GROUP BY vt.reg_no,vt.first_name,vt.last_name;

SELECT o.name AS Owner_Name,p.name AS Pet_Name,p.type,p.breed
FROM Owner o JOIN Pet p ON o.owner_id=p.owner_id
WHERE o.name='John Smith';

/*
RELATIONAL ALGEBRA

1. Pets with owners:
π Pet.name,Pet.type,Pet.breed,Owner.name,Owner.contact
(Pet ⨝Pet.owner_id=Owner.owner_id Owner)

2. Visits with vet and pet:
π Visit.visit_id,Visit.type,Visit.date,Vet.first_name,Vet.last_name,Pet.name
((Visit ⨝Visit.reg_no=Vet.reg_no Vet) ⨝Visit.chipped_id=Pet.chipped_id Pet)

3. Prescriptions with pets:
π Prescription.id,Prescription.drugs,Prescription.dosage,Prescription.quantity,
Prescription.expiry_date,Pet.name
((Prescription ⨝Prescription.visit_id=Visit.visit_id Visit)
⨝Visit.chipped_id=Pet.chipped_id Pet)

4. Visits per vet:
γ Vet.reg_no,Vet.first_name,Vet.last_name;COUNT(Visit.visit_id)→Total_Visits
(Vet ⟕Vet.reg_no=Visit.reg_no Visit)

5. John Smith's pets:
π Owner.name,Pet.name,Pet.type,Pet.breed
(σ Owner.name='John Smith'(Owner ⨝Owner.owner_id=Pet.owner_id Pet))
*/