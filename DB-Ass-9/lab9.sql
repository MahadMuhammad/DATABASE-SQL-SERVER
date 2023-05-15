-- In this task, you will create a trigger that prevents a user from inserting a new row into a table if the value of a certain column is not within a specified range. Follow these steps:

-- 1.	Create a new table called products with columns id, name, price, and quantity.
-- 2.	Write a trigger that executes before an INSERT statement is executed on the products table.
-- 3.	In the trigger, check the value of the price column to make sure it is between 0 and 1000. If it is not, raise an error.
-- 4.	Test the trigger by attempting to insert a row with a price outside the specified range. Confirm that the trigger prevents the insertion and raises an error.

CREATE TABLE PRODUCTS
(
	ID INT PRIMARY KEY,
	NAME VARCHAR(50),
	PRICE DECIMAL(10,2),
	QUANTITY INT,
);

CREATE TRIGGER TRG_PRODUCTS_INSERT
ON PRODUCTS
BEFORE INSERT
AS
BEGIN
	IF (SELECT COUNT(*)
	FROM INSERTED
	WHERE PRICE < 0 OR PRICE > 1000) > 0
BEGIN
		RAISERROR('Price must be between 0 and 1000', 16, 1);
		ROLLBACK;
	END
END;

-- Test the trigger
INSERT INTO PRODUCTS
	(ID, NAME, PRICE, QUANTITY)
VALUES
	(1, 'Product 1', 500, 10);

INSERT INTO PRODUCTS
	(ID, NAME, PRICE, QUANTITY)
VALUES
	(2, 'Product 2', -10, 5); -- This should fail

INSERT INTO PRODUCTS
	(ID, NAME, PRICE, QUANTITY)
VALUES
	(3, 'Product 3', 2000, 7); -- This should fail

SELECT *
FROM PRODUCTS;


-- Task 2: 
-- In this task, you will create a trigger that maintains referential integrity between two tables. Follow these steps:

-- 1)	Create two tables called orders and customers.
-- 2)	Add a foreign key constraint to the orders table that references the id column of the customers table.
-- 3)	Write a trigger that executes before a row is deleted from the customers table.
-- 4)	In the trigger, check if there are any orders associated with the customer being deleted. If there are, raise an error and prevent the deletion of the row.
-- 5)	Test the trigger by attempting to delete a customer who has orders associated with them. Confirm that the trigger prevents the deletion and raises an error.
CREATE TABLE CUSTOMERS
(
	ID INT PRIMARY KEY
);

CREATE TABLE ORDERS
(
	ID INT FOREIGN KEY REFERENCES CUSTOMERS(ID)
);

-- Add some sample data
INSERT INTO CUSTOMERS
	(ID)
VALUES
	(1),
	(2),
	(3);
INSERT INTO ORDERS
	(ID)
VALUES
	(1),
	(2);

-- Create the trigger
CREATE TRIGGER TRG_CUSTOMERS_DELETE
ON CUSTOMERS
BEFORE DELETE
AS
BEGIN
	IF EXISTS (SELECT *
	FROM DELETED d INNER JOIN ORDERS o ON d.ID = o.ID)
BEGIN
		RAISERROR('Cannot delete customer with associated orders', 16, 1);
		ROLLBACK;
	END
END;

-- Test the trigger
DELETE FROM CUSTOMERS WHERE ID = 2; -- This should work
DELETE FROM CUSTOMERS WHERE ID = 1; -- This should fail because customer 1 has an associated order

SELECT *
FROM CUSTOMERS;
SELECT *
FROM ORDERS;

-- Task 3: 
-- In this task, you will create a trigger that logs changes made to a table. Follow these steps:

-- 1.	Create a new table called log with columns id, table_name, column_name, old_value, new_value, and timestamp.
-- 2.	Write a trigger that executes after an UPDATE statement is executed on any table in the database.
-- 3.	In the trigger, insert a new row into the log table that records the name of the updated table, the name of the updated column, the old value, the new value, and the current timestamp.
-- 4.	Test the trigger by updating a row in a table and confirming that a new row is inserted into the log table.

CREATE TABLE LOG
(
	ID INT PRIMARY KEY,
	TABLE_NAME VARCHAR(50),
	COLUMN_NAME VARCHAR(50),
	OLD_VALUE VARCHAR(50),
	NEW_VALUE VARCHAR(50),
	TIMESTAMP DATETIME
);

CREATE TRIGGER THREE
ON CUSTOMERS
AFTER UPDATE
AS BEGIN
	INSERT INTO LOG
	VALUES((SELECT ID
			FROM INSERTED), 'CUSTOMERS', 'ID', (SELECT ID
			FROM DELETED), (SELECT ID
			FROM INSERTED), GETDATE());
END;

UPDATE CUSTOMERS
SET ID=4
WHERE ID=1;

SELECT *
FROM LOG; 

-- Task 4:
-- In this task, you will create a trigger that enforces a business rule related to discounts. Follow these steps:

-- 1)	Create a new table called orders with columns id, customer_id, total, and discount.
-- 2)	Write a trigger that executes before an INSERT or UPDATE statement is executed on the orders table.
-- 3)	In the trigger, check if the value of the discount column is greater than 10% of the total column. If it is, raise an error.
-- 4)	Test the trigger by attempting to insert or update a row with a discount

CREATE TABLE ORDERS
(
	ID INT PRIMARY KEY,
	CUSTOMER_ID INT,
	TOTAL DECIMAL(10,2),
	DISCOUNT DECIMAL(10,2)
);

CREATE TRIGGER FOUR ON ORDERS1
FOR INSERT, UPDATE 
AS
BEGIN
	DECLARE @DISCOUNT INT,
		@CALC INT

	SELECT @DISCOUNT= INSERTED.DISCOUNT, @CALC= INSERTED.TOTAL
	FROM INSERTED

	IF(@DISCOUNT < 0.9*@CALC)
	BEGIN
		PRINT('ERROR OCCURED AS DISCOUNT IS GREATER THAN 10%')
		ROLLBACK
	END

END;
INSERT INTO ORDERS
VALUES(1, 1, 100, 10);
INSERT INTO ORDERS
VALUES(2, 1, 100, 11);

SELECT * FROM ORDERS; 


