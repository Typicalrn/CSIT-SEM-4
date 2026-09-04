-- ECommerceDB Activity 2 - Concise Version
CREATE DATABASE ECommerceDB_activity2;
USE ECommerceDB_activity2;

-- DDL
CREATE TABLE Category (
 id INT PRIMARY KEY,
 name VARCHAR(50) NOT NULL
);

CREATE TABLE Product (
 id INT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 stock INT NOT NULL CHECK(stock >= 0),
 price DECIMAL(10,2) NOT NULL CHECK(price >= 0),
 category_id INT NOT NULL,
 FOREIGN KEY(category_id) REFERENCES Category(id)
);

CREATE TABLE Customer (
 id INT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 address VARCHAR(255) NOT NULL,
 contact VARCHAR(20) NOT NULL
);

CREATE TABLE Customer_Order (
 id INT PRIMARY KEY,
 date DATE NOT NULL,
 total_cost DECIMAL(10,2) NOT NULL,
 customer_id INT NOT NULL,
 FOREIGN KEY(customer_id) REFERENCES Customer(id)
);

-- Required because Product and Customer_Order are M:N
CREATE TABLE Order_Product (
 order_id INT,
 product_id INT,
 quantity INT NOT NULL CHECK(quantity > 0),
 PRIMARY KEY(order_id,product_id),
 FOREIGN KEY(order_id) REFERENCES Customer_Order(id),
 FOREIGN KEY(product_id) REFERENCES Product(id)
);

-- DML: INSERT DATA
INSERT INTO Category VALUES
(1,'Electronics'),
(2,'Books');

INSERT INTO Product VALUES
(101,'Wireless Mouse',50,25.00,1),
(102,'Keyboard',30,45.00,1),
(103,'Database Book',20,35.00,2);

INSERT INTO Customer VALUES
(1,'Ram Sharma','Kathmandu','9876543210');

INSERT INTO Customer_Order VALUES
(5001,'2026-08-20',105.00,1);

INSERT INTO Order_Product VALUES
(5001,101,1),(5001,102,1),(5001,103,1);

-- DML: UPDATE CART QUANTITY
UPDATE Order_Product
SET quantity=2
WHERE order_id=5001 AND product_id=101;

-- DML: UPDATE TOTAL ORDER COST
UPDATE Customer_Order co
SET total_cost=(
 SELECT SUM(op.quantity*p.price)
 FROM Order_Product op
 JOIN Product p ON op.product_id=p.id
 WHERE op.order_id=co.id
)
WHERE co.id=5001;

-- DQL: VIEW ALL TABLES
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Customer;
SELECT * FROM Customer_Order;
SELECT * FROM Order_Product;

-- DQL: PRODUCTS WITH CATEGORY
SELECT c.name AS category,p.id,p.name,p.stock,p.price
FROM Category c
JOIN Product p ON c.id=p.category_id;

-- DQL: PRODUCTS FROM SELECTED CATEGORY
SELECT p.id,p.name,p.stock,p.price
FROM Product p
JOIN Category c ON p.category_id=c.id
WHERE c.name='Electronics';






/*
RELATIONAL ALGEBRA

1. Products in Electronics category:
π Product.id,Product.name,Product.stock,Product.price
(σ Category.name='Electronics'
(Category ⨝Category.id=Product.category_id Product))

2. Cart contents:
π Customer_Order.id,Product.name,Order_Product.quantity,Product.price
((Customer_Order ⨝Customer_Order.id=Order_Product.order_id Order_Product)
⨝Order_Product.product_id=Product.id Product)
*/