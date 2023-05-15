-- Task 1: 
-- In this task, you will create a trigger that prevents a user from inserting a new row into a table if the value of a certain column is not within a specified range. Follow these steps:

-- Create a new table called products with columns id, name, price, and quantity.
-- Write a trigger that executes before an INSERT statement is executed on the products table.
-- In the trigger, check the value of the price column to make sure it is between 0 and 1000. If it is not, raise an error.
-- Test the trigger by attempting to insert a row with a price outside the specified range. Confirm that the trigger prevents the insertion and raises an error.
-- Solution:
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT
);

DELIMITER $$
CREATE TRIGGER before_insert_products
BEFORE INSERT ON products
FOR EACH ROW 
BEGIN
    IF NEW.price < 0 OR NEW.price > 1000 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be between 0 and 1000';
    END IF;
END$$
DELIMITER ;

INSERT INTO products (id, name, price, quantity) VALUES (1, 'Product 1', 100, 10);
INSERT INTO products (id, name, price, quantity) VALUES (2, 'Product 2', 1000, 10);
INSERT INTO products (id, name, price, quantity) VALUES (3, 'Product 3', 1001, 10);

-- Task 2:
-- In this task, you will create a trigger that maintains referential integrity between two tables. Follow these steps:

-- Create two tables called orders and customers.
-- Add a foreign key constraint to the orders table that references the id column of the customers table.
-- Write a trigger that executes before a row is deleted from the customers table.
-- In the trigger, check if there are any orders associated with the customer being deleted. If there are, raise an error and prevent the deletion of the row.
-- Test the trigger by attempting to delete a customer who has orders associated with them. Confirm that the trigger prevents the deletion and raises an error.
-- Solution:
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

DELIMITER $$
CREATE TRIGGER before_delete_customers
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM orders WHERE customer_id = OLD.id) > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot delete customer with orders';
    END IF;
END$$
DELIMITER ;

INSERT INTO customers (id, name) VALUES (1, 'Customer 1');
INSERT INTO customers (id, name) VALUES (2, 'Customer 2');
INSERT INTO customers (id, name) VALUES (3, 'Customer 3');

INSERT INTO orders (id, customer_id) VALUES (1, 1);
INSERT INTO orders (id, customer_id) VALUES (2, 1);
INSERT INTO orders (id, customer_id) VALUES (3, 2);
INSERT INTO orders (id, customer_id) VALUES (4, 3);

DELETE FROM customers WHERE id = 1;
DELETE FROM customers WHERE id = 2;
DELETE FROM customers WHERE id = 3;


-- Task 3:
-- In this task, you will create a trigger that logs changes made to a table. Follow these steps:

-- Create a new table called log with columns id, table_name, column_name, old_value, new_value, and timestamp.
-- Write a trigger that executes after an UPDATE statement is executed on any table in the database.
-- In the trigger, insert a new row into the log table that records the name of the updated table, the name of the updated column, the old value, the new value, and the current timestamp.
-- Test the trigger by updating a row in a table and confirming that a new row is inserted into the log table.
-- Solution:
CREATE TABLE log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(50),
    column_name VARCHAR(50),
    old_value VARCHAR(50),
    new_value VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER after_update
AFTER UPDATE ON *
FOR EACH ROW
BEGIN
    INSERT INTO log (table_name, column_name, old_value, new_value)
    VALUES (TRIGGER_TABLE(), TRIGGER_COLUMN(), OLD.name, NEW.name);
END$$
DELIMITER ;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT
);

INSERT INTO products (id, name, price, quantity) VALUES (1, 'Product 1', 100, 10);
UPDATE products SET name = 'Product 2' WHERE id = 1;

-- Task 4:
-- In this task, you will create a trigger that enforces a business rule related to discounts. Follow these steps:

-- Create a new table called orders with columns id, customer_id, total, and discount.
-- Write a trigger that executes before an INSERT or UPDATE statement is executed on the orders table.
-- In the trigger, check if the value of the discount column is greater than 10% of the total column. If it is, raise an error.
-- Test the trigger by attempting to insert or update a row with a discount
-- Solution:
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    total DECIMAL(10,2),
    discount DECIMAL(10,2)
);

DELIMITER $$
CREATE TRIGGER before_insert_orders
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.discount > NEW.total * 0.1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Discount cannot be greater than 10% of total';
    END IF;
END$$
DELIMITER ;

INSERT INTO orders (id, customer_id, total, discount) VALUES (1, 1, 100, 10);
INSERT INTO orders (id, customer_id, total, discount) VALUES (2, 1, 100, 11);

UPDATE orders SET discount = 10.5 WHERE id = 1;
UPDATE orders SET discount = 11 WHERE id = 1;



