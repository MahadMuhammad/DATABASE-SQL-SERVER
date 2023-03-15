-- Muhammad Mahad 21L-6195

-- 1.	Create a view that gives order number and total price of that order 
-- where total price is equal to item price multiplied by item quantity of that order.

CREATE VIEW OrderTotalPrice AS
SELECT OrderDetails.OrderNo, SUM(Price * Quantity) AS TotalPrice
FROM OrderDetails 
JOIN Items ON OrderDetails.ItemNo = Items.ItemNo
GROUP BY OrderNo;

SELECT * FROM OrderTotalPrice;

-- 2.	Create a view that gives all the items that are doing well in sales. 
-- The criteria to judge which item is doing good sale is that the item is has sold more than 20 pieces.

CREATE VIEW well_sales AS
SELECT Items.ItemNo , Name ,Quantity
FROM Items JOIN OrderDetails ON OrderDetails.ItemNo = Items.ItemNo
GROUP BY  Items.ItemNo ,Name,Quantity
HAVING Quantity>20;

SELECT * FROM well_sales;

-- 3.	Create a view that returns star customers. 
-- Star customers are the customers that have made a purchase of more than 2000. 
CREATE VIEW star_customers AS
SELECT Customers.CustomerNo, Customers.Name 
FROM Customers
WHERE Customers.CustomerNo IN(
	SELECT [Order].CustomerNo
	FROM ([Order] JOIN OrderDetails ON [Order].OrderNo = OrderDetails.OrderNo)
		JOIN Items ON Items.ItemNo = OrderDetails.ItemNo
	WHERE Items.Price > 2000
);

SELECT * FROM star_customers;

-- 4.	Create a view that returns all the customers that have phone number not null WITHOUT WITH CHECK option. Also, create a view with WITH CHECK option.
--  Now, try to insert, delete and update through the view, and observe the results.
CREATE VIEW customer_nnull_without_check AS
SELECT * FROM Customers
WHERE Customers.Phone IS NOT NULL;

INSERT INTO customer_nnull_without_check
VALUES(
'C7', 'Mahad', 'LHR',12345
);

CREATE VIEW customer_nnull_with_check AS
SELECT * FROM Customers
WHERE Customers.Phone IS NOT NULL
WITH CHECK OPTION;

INSERT INTO customer_nnull_with_check
VALUES(
'C8', 'Ali', 'PWR',54231
);

INSERT INTO customer_nnull_with_check
VALUES(
'C8', 'Ali', 'PWR',54231
);
SELECT * FROM customer_nnull_with_check;

SELECT * FROM customer_nnull_without_check;
SELECT * FROM customer_nnull_with_check;


SELECT * FROM OrderTotalPrice;
SELECT * FROM well_sales;
SELECT * FROM star_customers;
SELECT * FROM customer_nnull_with_check;