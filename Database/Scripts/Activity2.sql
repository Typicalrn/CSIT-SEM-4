/*====================================================
            ACTIVITY 2 - ECOMMERCE DATABASE
======================================================*/

-- Create Database
CREATE DATABASE ECommerceDB_activity2;

-- Use Database
USE ECommerceDB_activity2;

------------------------------------------------------
-- Create Category Table
------------------------------------------------------

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

------------------------------------------------------
-- Create Product Table
------------------------------------------------------

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    category_id INT NOT NULL,

    CONSTRAINT fk_product_category
        FOREIGN KEY(category_id)
        REFERENCES Category(category_id)
);

------------------------------------------------------
-- Create Customer Table
------------------------------------------------------

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    contact VARCHAR(20)
);

------------------------------------------------------
-- Create Orders Table
------------------------------------------------------

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    customer_id INT NOT NULL,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY(customer_id)
        REFERENCES Customer(customer_id)
);

------------------------------------------------------
-- Create Ordered_Product Table
------------------------------------------------------

CREATE TABLE Ordered_Product (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,

    PRIMARY KEY(order_id, product_id),

    CONSTRAINT fk_order
        FOREIGN KEY(order_id)
        REFERENCES Orders(order_id),

    CONSTRAINT fk_product
        FOREIGN KEY(product_id)
        REFERENCES Product(product_id)
);

------------------------------------------------------
-- Insert Category Data
------------------------------------------------------

INSERT INTO Category(category_name)
VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Sports');

------------------------------------------------------
-- Insert Product Data
------------------------------------------------------

INSERT INTO Product(product_name, price, stock, category_id)
VALUES
('Laptop',1200.00,20,1),
('Smartphone',800.00,40,1),
('Headphones',150.00,35,1),
('T-Shirt',30.00,100,2),
('Jeans',60.00,70,2),
('Novel',20.00,50,3),
('Microwave',250.00,15,4),
('Football',40.00,80,5);

------------------------------------------------------
-- Insert Customer Data
------------------------------------------------------

INSERT INTO Customer(customer_name,address,contact)
VALUES
('Aryan Maharjan','Kathmandu','9801234567'),
('John Smith','Sydney','987654321'),
('Emma Wilson','Melbourne','981234567'),
('David Brown','Brisbane','982345678');

------------------------------------------------------
-- Insert Orders
------------------------------------------------------

INSERT INTO Orders(order_date,total_cost,customer_id)
VALUES
('2025-06-15',2000.00,1),
('2025-06-18',90.00,2),
('2025-06-20',270.00,3),
('2025-06-22',120.00,4);

------------------------------------------------------
-- Insert Ordered Products
------------------------------------------------------

INSERT INTO Ordered_Product(order_id,product_id,quantity)
VALUES
(1,1,1),
(1,2,1),
(2,4,1),
(2,5,1),
(3,7,1),
(3,6,1),
(4,8,3);

------------------------------------------------------
-- Display All Tables
------------------------------------------------------

SHOW TABLES;

------------------------------------------------------
-- View Table Data
------------------------------------------------------

SELECT * FROM Category;

SELECT * FROM Product;

SELECT * FROM Customer;

SELECT * FROM Orders;

SELECT * FROM Ordered_Product;

------------------------------------------------------
-- Query 1
-- Display Products with their Category
------------------------------------------------------

SELECT
P.product_id,
P.product_name,
C.category_name,
P.price,
P.stock
FROM Product P
JOIN Category C
ON P.category_id = C.category_id;

------------------------------------------------------
-- Query 2
-- Display Customer Orders
------------------------------------------------------

SELECT
O.order_id,
C.customer_name,
O.order_date,
O.total_cost
FROM Orders O
JOIN Customer C
ON O.customer_id = C.customer_id;

------------------------------------------------------
-- Query 3
-- Display Ordered Products
------------------------------------------------------

SELECT
O.order_id,
P.product_name,
OP.quantity,
P.price
FROM Ordered_Product OP
JOIN Orders O
ON OP.order_id = O.order_id
JOIN Product P
ON OP.product_id = P.product_id;

------------------------------------------------------
-- Query 4
-- Calculate Total Order Cost
------------------------------------------------------

SELECT
O.order_id,
SUM(OP.quantity * P.price) AS Total_Order_Cost
FROM Orders O
JOIN Ordered_Product OP
ON O.order_id = OP.order_id
JOIN Product P
ON OP.product_id = P.product_id
GROUP BY O.order_id;

------------------------------------------------------
-- Query 5
-- Customer Purchase History
------------------------------------------------------

SELECT
C.customer_name,
O.order_id,
P.product_name,
OP.quantity,
O.order_date
FROM Customer C
JOIN Orders O
ON C.customer_id = O.customer_id
JOIN Ordered_Product OP
ON O.order_id = OP.order_id
JOIN Product P
ON OP.product_id = P.product_id
ORDER BY C.customer_name;

------------------------------------------------------
-- Query 6
-- Total Products in Each Category
------------------------------------------------------

SELECT
C.category_name,
COUNT(P.product_id) AS Number_of_Products
FROM Category C
LEFT JOIN Product P
ON C.category_id = P.category_id
GROUP BY C.category_name;

------------------------------------------------------
-- Query 7
-- Total Orders by Each Customer
------------------------------------------------------

SELECT
C.customer_name,
COUNT(O.order_id) AS Total_Orders
FROM Customer C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id
GROUP BY C.customer_name;

------------------------------------------------------
-- Query 8
-- Products with Low Stock (Less than 30)
------------------------------------------------------

SELECT
product_name,
stock
FROM Product
WHERE stock < 30;

------------------------------------------------------
-- Query 9
-- Most Expensive Product
------------------------------------------------------

SELECT
product_name,
price
FROM Product
ORDER BY price DESC
LIMIT 1;

------------------------------------------------------
-- Query 10
-- Complete Order Summary
------------------------------------------------------

SELECT
O.order_id,
C.customer_name,
P.product_name,
OP.quantity,
(P.price * OP.quantity) AS Total_Price,
O.order_date
FROM Orders O
JOIN Customer C
ON O.customer_id = C.customer_id
JOIN Ordered_Product OP
ON O.order_id = OP.order_id
JOIN Product P
ON OP.product_id = P.product_id
ORDER BY O.order_id;