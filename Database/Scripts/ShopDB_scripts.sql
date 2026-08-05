CREATE DATABASE Shopdb;
USE Shopdb;

CREATE TABLE Salespersons(
        id INT PRIMARY KEY,
        name VARCHAR(50),
        city VARCHAR(50),
        commission DECIMAL(4,2));


CREATE TABLE Customers (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        city VARCHAR(50),
        points INT);


CREATE TABLE Orders(
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesperson_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(id),
    FOREIGN KEY (salesperson_id) REFERENCES Salespersons(id));

INSERT INTO Salespersons VALUES
(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5007,'Paul Adam','Rome',0.13),
(5003,'Lauson Hen','San Jose',0.12);

INSERT INTO Customers VALUES
(3002,'Nick Rimando','New York',100),
(3007,'Brad Davis','New York',200),
(3005,'Graham Zusi','California',200),
(3008,'Julian Green','London',300),
(3004,'Fabian Johnson','Paris',300),
(3009,'Geoff Cameron','Berlin',100),
(3003,'Jozy Altidor','Moscow',200),
(3001,'Brad Guzan','London',300);

INSERT INTO Orders VALUES
(70001,150.50,'2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.50,'2012-08-17',3009,5003),
(70007,948.50,'2012-09-10',3005,5002),
(70005,2400.60,'2012-07-27',3007,5001),
(70008,5760.00,'2012-09-10',3002,5001),
(70010,1983.43,'2012-10-10',3004,5006),
(70003,2480.40,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002),
(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.60,'2012-04-25',3002,5001);

SELECT * FROM Salespersons;

SELECT name, commission
FROM Salespersons;

SELECT name, city
FROM Salespersons
WHERE city='Paris';

SELECT id, name, city, points
FROM Customers
WHERE points=200;

SELECT ord_no, ord_date, purch_amt
FROM Orders
WHERE salesperson_id=5001;

SELECT o.ord_no,
       c.name AS customer_name,
       s.name AS salesperson_name,
       c.city AS customer_city,
       o.purch_amt
FROM Orders o
JOIN Customers c
ON o.customer_id=c.id
JOIN Salespersons s
ON o.salesperson_id=s.id
WHERE o.purch_amt > 2000;

SELECT SUM(o.purch_amt * s.commission) AS total_commission
FROM Orders o
JOIN Salespersons s
ON o.salesperson_id=s.id
WHERE s.id=5001;

SELECT s.name AS salesperson_name,
       c.name AS customer_name,
       s.city
FROM Salespersons s
JOIN Customers c
ON s.city = c.city;