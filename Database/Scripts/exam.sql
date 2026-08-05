-- 1. Create Member Table
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(150),
    Phone_Number VARCHAR(15),
    Date_of_Membership DATE NOT NULL
);

-- 2. Create Book Table
CREATE TABLE Book (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publication_Year INT CHECK (Publication_Year > 0),
    Price DECIMAL(10, 2) CHECK (Price >= 0)
);

-- 3. Create Author Table
CREATE TABLE Author (
    Author_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Nationality VARCHAR(50)
);

-- 4. Create Book_Author Junction Table
CREATE TABLE Book_Author (
    Book_ID INT,
    Author_ID INT,
    PRIMARY KEY (Book_ID, Author_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID) ON DELETE CASCADE
);

-- 5. Create Borrow Table
CREATE TABLE Borrow (
    Borrow_ID INT PRIMARY KEY,
    Member_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Issue_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE
);

-- Insert Sample Data
INSERT INTO Member VALUES
(1, 'Aarav Sharma', 'Kathmandu', '9841000001', '2025-01-10'),
(2, 'Sita Thapa', 'Lalitpur', '9841000002', '2025-02-15'),
(3, 'Rohan Shrestha', 'Bhaktapur', '9841000003', '2025-03-01');

INSERT INTO Book VALUES
(101, 'Database System Concepts', '978-0073523323', 2019, 1250.00),
(102, 'Operating System Concepts', '978-1118063330', 2018, 950.00),
(103, 'Introduction to Algorithms', '978-0262033848', 2022, 1800.00);

INSERT INTO Author VALUES
(201, 'Abraham Silberschatz', 'American'),
(202, 'Thomas H. Cormen', 'American');

INSERT INTO Book_Author VALUES
(101, 201),
(102, 201),
(103, 202);

INSERT INTO Borrow VALUES
(1, 1, 101, '2026-03-01', '2026-03-15', '2026-03-14'),
(2, 1, 103, '2026-03-10', '2026-03-24', NULL),
(3, 2, 101, '2026-03-12', '2026-03-26', NULL);

--c
SELECT Title, Publication_Year, Price
FROM Book
WHERE Price > 1000
ORDER BY Title ASC;

--d
SELECT name, title, issue_date, due_date FROM Book
JOIN Borrow ON Book.book_id = Borrow.book_id
JOIN Member ON Member.member_id = Borrow.member_id;

--e
SELECT title, name FROM Book B 
JOIN Book_Author BA ON B.book_id = BA.book_id 
JOIN Author A ON BA.author_id = A.author_id;

--f
SELECT Member.name, Book.title 
FROM Borrow
JOIN Member ON Borrow.member_id = Member.member_id
JOIN Book ON Borrow.book_id = Book.book_id
WHERE Borrow.return_date IS NULL;

--g
SELECT Member.name, COUNT(Borrow.book_id)
FROM Member
JOIN Borrow ON Member.member_id = Borrow.member_id
GROUP BY Member.member_id, Member.name
HAVING COUNT(Borrow.book_id) > 1;