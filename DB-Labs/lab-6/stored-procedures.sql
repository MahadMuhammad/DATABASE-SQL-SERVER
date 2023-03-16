-- Muhammad Mahad 21L-6195


-- 1.	Create a stored procedure that takes order number, item number and quantity as input.
-- If quantity of that item present in store is less than ordered quantity. Print a message ‘Only <quantity in store> is present, which is less than your required quantity.’
-- If enough quantity is present in store insert the order detail in order details table and subtract the ordered quantity from quantity in store, for that ordered item. Write it’s execute statement as well.

CREATE PROCEDURE [dbo].[sp_OrderDetails]
    @OrderNo  INT,
    @ItemNo  INT,
    @Quantity  INT
AS
BEGIN
    DECLARE @QuantityInStore  INT
    SELECT @QuantityInStore = [Quantity in Store] FROM Items WHERE ItemNo = @ItemNo
    IF @QuantityInStore < @Quantity
        PRINT 'Only ' + CAST(@QuantityInStore AS VARCHAR) + ' is present, which is less than your required quantity.'
    ELSE
    BEGIN
        INSERT  INTO OrderDetails VALUES (@OrderNo, @ItemNo, @Quantity)
        UPDATE Items SET [Quantity in Store] = @QuantityInStore - @Quantity WHERE ItemNo = @ItemNo
    END
END

EXEC sp_OrderDetails 1, 200, 20 -- PK violation
EXEC sp_OrderDetails 3, 200, 60 -- Only 5 is present, which is less than your required quantity.
EXEC sp_OrderDetails 2, 200, 5  -- Only 0 is present, which is less than your required quantity.
EXEC sp_OrderDetails 4, 400, 2; -- (1 row affected) (1 row affected)
SELECT * FROM OrderDetails;
DELETE FROM OrderDetails WHERE OrderNo = 4;
SELECT * FROM OrderDetails;

-- deleting stored procedure
DROP PROCEDURE sp_OrderDetails;

-- 2.	You have to create a customer signup stored procedure. It will take all the information of Customer (No, Name City, Phone).
-- At the end of procedure it should return a flag (as output parameter) that should tell the violation of following rules: 
-- a.	Rule1: It should check that the customer No should be unique, so if any existing user has same user number it should return the Flag as 1. 
-- b.	Rule 2: City cannot be null, if city is null it should return flag as 2.
-- c.	Rule 3: Phone number should be of 6 numbers, if it’s less or more it should flag as 3. 
-- d.	If all the above rules are satisfied then customer should be inserted, and flag should be returned as 0.
-- Write it’s execute statement as well.

CREATE PROCEDURE [dbo].[sp_CustomerSignup]
    @CustomerNo  VARCHAR(2),
    @Name  VARCHAR(50),
    @City  VARCHAR(50),
    @Phone  VARCHAR(50),
    @Flag  INT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM Customers WHERE CustomerNo = @CustomerNo)
        SET @Flag = 1
    ELSE IF @City IS NULL
        SET @Flag = 2
    ELSE IF LEN(@Phone) <> 6
        SET @Flag = 3
    ELSE
    BEGIN
        INSERT INTO Customers VALUES (@CustomerNo, @Name, @City, @Phone)
        SET @Flag = 0
    END
END

DECLARE @Flag INT
EXEC sp_CustomerSignup 'C1', 'Customer 1', 'City 1', '123456', @Flag OUTPUT
PRINT @Flag -- 1

DECLARE @Flag INT
EXEC sp_CustomerSignup 'Unique', 'Customer 5', NULL, '123456', @Flag OUTPUT
PRINT @Flag -- 2;

DECLARE @Flag INT
EXEC sp_CustomerSignup 'Unique', 'Customer 5', 'LHR', '1234567', @Flag OUTPUT
PRINT @Flag -- 3

DECLARE @Flag INT 
EXEC sp_CustomerSignup 'C16', 'Laraib', 'LHR', '123456', @Flag OUTPUT
PRINT @Flag -- 3

SELECT * FROM Customers;

DELETE FROM Customers WHERE CustomerNo = 'C16';

-- deleting stored procedure
DROP PROCEDURE sp_CustomerSignup

-- 3.	You have to create a store procedure to cancel an order. It should take customer number and order no as an input, 
--     if that customer has placed that order, the order should be deleted and along with that all of its details should also be deleted. 
--     If that order number was not placed by that customer, it should print a message
--      ‘Order no <as taken from input> is not of <customerNo><customerName>’.
--       Write it’s execute statement as well.

CREATE PROCEDURE [dbo].[sp_CancelOrder]
    @CustomerNo  VARCHAR(2),
    @OrderNo  INT
AS
BEGIN
    IF EXISTS (SELECT * FROM [Order] WHERE CustomerNo = @CustomerNo AND OrderNo = @OrderNo)
    BEGIN
        DELETE FROM OrderDetails WHERE OrderNo = @OrderNo
        DELETE FROM [Order] WHERE OrderNo = @OrderNo
    END
    ELSE
    BEGIN
        DECLARE @CustomerName VARCHAR(50)
        SELECT @CustomerName = Name FROM CustomerNo.Customers WHERE CustomerNo = @CustomerNo
        PRINT 'Order no ' + CAST(@OrderNo AS VARCHAR) + ' is not of ' + @CustomerNo + ' ' + @CustomerName
    END
END

EXEC sp_CancelOrder 'C1', 1
SELECT * FROM OrderDetails;
SELECT * FROM [Order];

EXEC sp_CancelOrder 'C1', 1
SELECT * FROM OrderDetails;
SELECT * FROM [Order];


-- deleting stored procedure
DROP PROCEDURE sp_CancelOrder

-- 4.	Every customer gets 1 point on purchase of Rs100. Create a procedure that takes customer name as input and return his total points.
--      Write it’s execute statement as well.

CREATE PROCEDURE [dbo].[CalculateCustomerPoints]
    @CustomerName varchar(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @PointsEarned int = 0;
    
    SELECT @PointsEarned = SUM(Price / 100)
    FROM [dbo].[Items] AS i JOIN [dbo].[OrderDetails] od ON i.ItemNo = od.ItemNo
     JOIN [dbo].[Order] AS o ON od.OrderNo = o.OrderNo
     JOIN [dbo].[Customers] AS c ON o.CustomerNo = c.CustomerNo
    WHERE c.Name = @CustomerName;       -- 1 point on purchase of Rs100
    
    SELECT @PointsEarned as 'TotalPointsEarned';
END


EXEC CalculateCustomerPoints 'AHMED ALI';
EXEC sp_TotalPoints 'C2'
EXEC sp_TotalPoints 'C3'
EXEC sp_TotalPoints 'C4'
EXEC sp_TotalPoints 'C5'

EXEC CalculateCustomerPoints 'AHMED ALI';
EXEC CalculateCustomerPoints 'Mahad';
SELECT * FROM Customers;

-- deleting stored procedure
DROP PROCEDURE sp_TotalPoints;
