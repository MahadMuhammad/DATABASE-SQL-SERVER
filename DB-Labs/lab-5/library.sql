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