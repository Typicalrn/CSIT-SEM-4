-- LibraryDB - Concise Version
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(150),
    Phone_Number VARCHAR(15),
    Date_of_Membership DATE NOT NULL
);

CREATE TABLE Book (
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Publication_Year INT CHECK (Publication_Year > 0),
    Price DECIMAL(10, 2) CHECK (Price >= 0)
);

CREATE TABLE Author (
    Author_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Nationality VARCHAR(50)
);

CREATE TABLE Book_Author (
    Book_ID INT,
    Author_ID INT,
    PRIMARY KEY (Book_ID, Author_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID) ON DELETE CASCADE,
    FOREIGN KEY (Author_ID) REFERENCES Author(Author_ID) ON DELETE CASCADE
);

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

INSERT INTO Book_Author VALUES (101, 201), (102, 201), (103, 202);

INSERT INTO Borrow VALUES
(1, 1, 101, '2026-03-01', '2026-03-15', '2026-03-14'),
(2, 1, 103, '2026-03-10', '2026-03-24', NULL),
(3, 2, 101, '2026-03-12', '2026-03-26', NULL);

-- Query c: Books with Price > 1000
SELECT Title, Publication_Year, Price FROM Book WHERE Price > 1000 ORDER BY Title ASC;

-- Query d: Borrowed Books with Member Details
SELECT Name, Title, Issue_Date, Due_Date FROM Book
JOIN Borrow ON Book.Book_ID = Borrow.Book_ID
JOIN Member ON Member.Member_ID = Borrow.Member_ID;

-- Query e: Books with Authors
SELECT Title, Name FROM Book B
JOIN Book_Author BA ON B.Book_ID = BA.Book_ID
JOIN Author A ON BA.Author_ID = A.Author_ID;

-- Query f: Currently Borrowed Books (Not Returned)
SELECT Member.Name, Book.Title FROM Borrow
JOIN Member ON Borrow.Member_ID = Member.Member_ID
JOIN Book ON Borrow.Book_ID = Book.Book_ID
WHERE Borrow.Return_Date IS NULL;

-- Query g: Members with More Than 1 Borrow
SELECT Member.Name, COUNT(Borrow.Book_ID) FROM Member
JOIN Borrow ON Member.Member_ID = Borrow.Member_ID
GROUP BY Member.Member_ID, Member.Name HAVING COUNT(Borrow.Book_ID) > 1;