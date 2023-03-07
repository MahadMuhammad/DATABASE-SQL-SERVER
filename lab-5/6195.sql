-- Muhammad Mahad 21L-6195

CREATE TABLE Member (
  member_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  phone VARCHAR(50) NOT NULL
);

CREATE TABLE Book (
  book_id INTEGER PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  author VARCHAR(50) NOT NULL,
  publisher VARCHAR(50) NOT NULL,
  price INTEGER NOT NULL,
  category VARCHAR(50) NOT NULL,
  publication_date DATE
);

CREATE TABLE Borrow (
  id INTEGER PRIMARY KEY,
  book_id INTEGER NOT NULL,
  member_id INTEGER NOT NULL,
  borrow_date DATE NOT NULL,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES Book(book_id),
  FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

---- Insert records for Member table
INSERT INTO Member (member_id, first_name, last_name, email, phone)
VALUES
(101, 'John', 'Doe', 'johndoe@gmail.com', '555-1234'),
(102, 'Jane', 'Doe', 'janedoe@yahoo.com', '555-5678'),
(103, 'Bob', 'Smith', 'bobsmith@hotmail.com', '555-9012'),
(104, 'Alice', 'Johnson', 'alicejohnson@gmail.com', '555-3456'),
(105, 'Tom', 'Wilson', 'tomwilson@yahoo.com', '555-7890');

-- Insert records for Book table
INSERT INTO Book (book_id, title, author, publisher, publication_date, price, category)
VALUES
(101, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', '1925-04-10', 12.99, 'Classic'),
(102, 'To Kill a Mockingbird', 'Harper Lee', 'J. B. Lippincott & Co.', '1960-07-11', 9.99, 'Classic'),
(103, '1984', 'George Orwell', 'Secker & Warburg', '1949-06-08', 10.99, 'Science Fiction'),
(104, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 'Pan Books', '1979-10-12', 8.99, 'Science Fiction'),
(105, 'The Da Vinci Code', 'Dan Brown', 'Doubleday', '2003-03-18', 14.99, 'Mystery'),
(106, 'Gone Girl', 'Gillian Flynn', 'Crown', '2012-06-05', 13.99, 'Mystery'),
(107, 'The Hunger Games', 'Suzanne Collins', 'Scholastic Press', '2008-09-14', 11.99, 'Young Adult'),
(108, 'Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Bloomsbury', '1997-06-26', 9.99, 'Young Adult');

-- Insert records for Borrow table
INSERT INTO Borrow (id, member_id, book_id, borrow_date, return_date)
VALUES
(1,101, 101, '2022-01-01', '2022-01-15'),
(2,101, 102, '2022-01-01', '2022-01-15'),
(3,102, 103, '2022-01-01', '2022-01-15'),
(4,102, 104, '2022-01-01', '2022-01-15'),
(5,103, 105, '2022-01-01', '2022-01-15'),
(6,103, 106, '2022-01-01', '2022-01-15'),
(7,104, 107, '2022-01-01', '2022-01-15'),
(8,104, 108, '2022-01-01', '2022-01-15'),
(9,105, 107, '2022-01-01', '2022-01-15'),
(10,105, 108, '2022-01-01', '2022-01-15');

-- Q1. Write a query to find the names and email addresses of all members who have borrowed at least one book.
--SELECT 
--    DISTINCT Member.first_name, Member.last_name, Member.email
--FROM 
--    Member JOIN Borrow ON Member.member_id = Borrow.member_id;

-- with nested query
SELECT 
   DISTINCT Member.first_name, Member.last_name, Member.email
FROM 
    Member
WHERE
    Member.member_id IN (SELECT Borrow.member_id FROM Borrow);

-- Q2. Write a query to find the titles of all books that have been borrowed by members whose email address contains the word "gmail".
-- with nested query
SELECT 
    Book.title AS book_title
FROM
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
        WHERE (
            Borrow.member_id IN(
                SELECT Member.member_id FROM Member
                WHERE Member.email LIKE '%gmail%'
            )
        )
    );

-- Q3. Find the members who have borrowed books in the category "Mystery" and returned themlate.
-- with nested query
SELECT
    Member.first_name, Member.last_name, Member.email
FROM
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        WHERE (
            Borrow.book_id IN (
                SELECT Book.book_id FROM Book
                WHERE Book.category = 'Mystery'
            ) 
			AND DATEDIFF(day,Borrow.borrow_date,Borrow.return_date ) > 10
        )
    );

-- Q4. Find the titles of books that have been borrowed by members who have borrowed books in the category"Classic".
-- with nested query
SELECT
    Book.title AS BOOK_TITLE
FROM
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
        WHERE (
            Borrow.member_id IN (
                SELECT Borrow.member_id FROM Borrow
                WHERE Borrow.book_id IN (
                    SELECT Book.book_id FROM Book
                    WHERE Book.category = 'Classic'
                )
            )
        )
    );

-- Q5. Write a query to find the titles of all books that have been borrowed more than once.
-- with nested query
SELECT
    Book.title AS BOOK_TITLE
FROM 
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id 
        FROM Borrow 
        GROUP BY Borrow.book_id
        HAVING COUNT(Borrow.book_id) > 1
    );

-- Q6. Write a query to find the names and phone numbers of all members who have borrowed books with a pricegreater than $10.
-- with nested query
SELECT
    Member.first_name, Member.last_name, Member.phone
FROM 
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        WHERE Borrow.book_id IN (
            SELECT Book.book_id FROM Book
            WHERE Book.price > 10
        )
    );

-- Q7. Write a query to find the number of books borrowed by each member.
-- with nested query
-- SELECT
--     Member.member_id , Member.first_name, Member.last_name, COUNT(Borrow.book_id) AS book_count
-- FROM
--     Member, Borrow
-- WHERE
--     Member.member_id IN (
--         SELECT Borrow.member_id 
--         FROM Borrow 
--     )
-- GROUP BY Borrow.member_id;

-- Without nested query
--SELECT
--    Member.member_id , Member.first_name,COUNT(Borrow.book_id) AS book_count
--FROM
--    Member JOIN Borrow ON Member.member_id = Borrow.member_id
--GROUP BY Borrow.member_id;

SELECT 
	Borrow.member_id , COUNT(*) AS no_of_books
FROM 
	Borrow
GROUP BY member_id;


-- Q.8 Write a query to find the titles of all books that have been borrowed by members whose last name startswith "D".
-- with nested query
SELECT 
    Book.title AS book_title
FROM
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
        WHERE (
            Borrow.member_id IN(
                SELECT Member.member_id FROM Member
                WHERE Member.last_name LIKE 'D%'
            )
        )
    );

-- Q9. Write a query to find the names of all members who have borrowed books published before 1990.
-- with nested query
SELECT
    Member.first_name, Member.last_name
FROM
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        WHERE (
            Borrow.book_id IN (
                SELECT Book.book_id FROM Book
                WHERE Book.publication_date < '1990-01-01'
            )
        )
    );

-- Q10. Write a query to find the titles of all books that have been borrowed by members 
--      whose first name startswith "J" and last name ends with "n".
-- with nested query
SELECT 
    Book.title AS book_title
FROM
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
        WHERE (
            Borrow.member_id IN(
                SELECT Member.member_id FROM Member
                WHERE Member.first_name LIKE 'J%' AND Member.last_name LIKE '%n'
            )
        )
    );

-- Q11. Write a query to find the names of all members who have borrowed the same book more than once.
-- with nested query
SELECT
    Member.first_name, Member.last_name
FROM
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        WHERE (
            Borrow.book_id IN (
                SELECT Borrow.book_id FROM Borrow
                GROUP BY Borrow.book_id, Borrow.member_id
                --HAVING COUNT(Borrow.book_id) > 1
				HAVING COUNT(*) > 1
            )
        )
    );

-- Q12. Retrieve the first name and last name of the members who have not borrowed any books.
-- with nested query
SELECT
    Member.first_name, Member.last_name
FROM
    Member
WHERE
    Member.member_id NOT IN (
        SELECT Borrow.member_id FROM Borrow
);

-- Q13. Retrieve the title and author of the books that have been borrowed by members.
-- with nested query
SELECT
    Book.title AS book_title, Book.author
FROM 
    Book
WHERE 
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
 );
    
-- Q14. Retrieve the title of the books that have been borrowed by members whose last name is "Doe".
SELECT
    Book.title AS book_title
FROM
    Book
WHERE
    Book.book_id IN (
        SELECT Borrow.book_id FROM Borrow
        WHERE (
            Borrow.member_id IN(
                SELECT Member.member_id FROM Member
                WHERE Member.last_name = 'Doe'
            )
        )
   );
-- Q15. Find the members who have borrowed at least one book, but not returned any books yet.
-- with nested query
SELECT
    Member.first_name, Member.last_name
FROM
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        WHERE (
            Borrow.return_date IS NULL
        )
);

-- Q16. Find the members who have borrowed all the books
-- with nested query
SELECT
    Member.first_name, Member.last_name
FROM
    Member
WHERE
    Member.member_id IN (
        SELECT Borrow.member_id FROM Borrow
        GROUP BY Borrow.member_id
        HAVING COUNT(DISTINCT Borrow.member_id) = (
            SELECT COUNT(DISTINCT Book.book_id) FROM Book
        )
    );