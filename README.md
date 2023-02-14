# DATABASE-SQL-SERVER
My Database repository for storing DBMS courses of university

***To create a Table***
```sql
	create table risk_clos_rank(
		id_num int IDENTITY(1,1) NOT NULL,
	    username nvarchar(100),
	    datetime_of_decision DATETIME
	);
	
	CREATE TABLE TheNameOfYourTable (
	  ID INT NOT NULL IDENTITY(1,1),
	  DateAdded DATETIME DEFAULT(getdate()) NOT NULL,
	  Description VARCHAR(100) NULL,
	  IsGood BIT DEFAULT(0) NOT NULL,
	  TotalPrice MONEY NOT NULL,  
	  CategoryID int NOT NULL REFERENCES Categories(ID),
	  PRIMARY KEY (ID)
	);
```
***To create a copy of table( doesnt create constraints like primary key, not null , indexes ect)***
```sql
	SELECT * INTO NewTable FROM OldTable
    Eg. SELECT * INTO clos_ext_bkup FROM clos_ext;
```
***To create a copy of table with its data (create and insert)***
```sql
	SELECT expressions INTO new_table FROM tables [WHERE conditions];
	SELECT employee_id AS contact_id, last_name, first_name INTO contacts FROM employees WHERE employee_id < 1000;
```

The format of new_table is determined by evaluating the expressions in the select list. The columns in new_table are created in the order specified by the select list. Each column in new_table has the same name, data type, nullability, and value as the corresponding expression in the select list.

***Inserting Data from another table ( only insert)***
```sql
	INSERT INTO Table (col1, col2, col3) SELECT col1, col2, col3  FROM other_table WHERE sql = 'cool'	
	INSERT INTO contacts (contact_id, last_name, first_name) SELECT employee_id, last_name, first_name FROM employees WHERE employee_id <= 100;
```	
***Inserting Multiple values***
```sql
	INSERT INTO table1 (First, Last)
	VALUES
		('Fred', 'Smith'),
		('John', 'Smith'),
		('Michael', 'Smith'),
		('Robert', 'Smith');
```	
***To add a column***
```sql
	ALTER TABLE table_name  ADD column_1 column-definition,column_2 column-definition,column_n column_definition;
	alter table risk_user_approval_tree add lineusr nvarchar(100);
	ALTER TABLE table ADD columnname BIT CONSTRAINT Constraint_name DEFAULT 0 WITH VALUES
```
***To add a auto increment***
```
	ALTER TABLE 'tableName' ADD 'NewColumn' INT IDENTITY(1,1);
```
***To add a column with computed value***
```sql
	ALTER TABLE dbo.Products ADD RetailValue AS (QtyAvailable * UnitPrice * 1.5);
```
***To delete/drop a column***
```sql
	ALTER TABLE table_name DROP COLUMN column_name;
```
***To drop a table***
```sql
	DROP TABLE tablename;
```	
***To modify a column***
```sql
	ALTER TABLE table_name ALTER COLUMN column_name column_type;
```	
***To update a row***
```sql
	UPDATE clos_customer_master SET Prev = 'Reactivation' WHERE Prev = 'Reactivate';
```

***To update a row from select clause***
```sql
	UPDATE table SET Col1 = i.Col1, Col2 = i.Col2 FROM ( SELECT ID, Col1, Col2 FROM other_table) i WHERE i.ID = table.ID;
```
The subquery results are substituted into the outer query. As we need table object in outer query, we need to make an alias of inner query.
	
***To add a primary key***
```sql
	ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column1, column2, ... column_n);
```
***To find the name of constraints***
```sql
	SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'tablename'
```
***To find name of Primary key constraint***
```sql
	SELECT name FROM sys.key_constraints  WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = N'CLOS_ext';  	
```	
***Drop primary key***
```sql
	ALTER TABLE table_name DROP CONSTRAINT constraint_name;
```	
***To rename a column (alter command doesnt work here)***
```sql
	sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';
	sp_rename 'cl_ff_docm.WINAME', 'WI_NAME', 'COLUMN';
```
***To rename a table***
```sql
	sp_rename 'old_table_name', 'new_table_name';
```	
***To top 10% of records***
```sql
	SELECT TOP(10) * FROM CLOS_EXT
```	
***To find when a table was altered***
```sql
	SELECT [name] , create_date, modify_date FROM sys.tables;
```
***To find which table contains a given column***
```sql
	SELECT * FROM INFORMATION_SCHEMA.COLUMNS;
	
	SELECT OBJECT_SCHEMA_NAME (c.object_id) SchemaName,
			o.Name AS Table_Name, 
			c.Name AS Field_Name,
			t.Name AS Data_Type,
			t.max_length AS Length_Size,
			t.precision AS Precision
	FROM sys.columns c 
		 INNER JOIN sys.objects o ON o.object_id = c.object_id
		 LEFT JOIN  sys.types t on t.user_type_id  = c.user_type_id   
	WHERE o.type = 'U'
	-- and o.Name = 'YourTableName'
	ORDER BY o.Name, c.Name
```
***To find which table has which constraint and on which column.***
```sql
	Select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE;
```	
***Selcting based on case*** 
```sql
	SELECT CASE 
    		WHEN <test>      THEN <returnvalue>
            WHEN <othertest> THEN <returnthis>
            ELSE <returndefaultcase>
       END AS <newcolumnname>
	FROM <table>
	
    Eg.
	SELECT   ProductNumber, Name, "Price Range" =   
		  CASE   
			 WHEN ListPrice =  0 THEN 'Mfg item - not for resale'  
			 WHEN ListPrice < 50 THEN 'Under $50'  
			 WHEN ListPrice >= 50 and ListPrice < 250 THEN 'Under $250'  
			 WHEN ListPrice >= 250 and ListPrice < 1000 THEN 'Under $1000'  
			 ELSE 'Over $1000'  
		  END  
	FROM Production.Product  
	ORDER BY ProductNumber ;  
```
***Adding row numbers to the result***   //here we are creating 
```sql
	SELECT ROW_NUMBER() OVER(ORDER BY name ASC) AS Row#, name, 
    		recovery_model_desc
		FROM sys.databases 
		WHERE database_id < 5;
```
***While Loop***
```sql
	DECLARE @MaxCount INTEGER
	DECLARE @Count INTEGER
	DECLARE @Txt VARCHAR(MAX)
	SET @Count = 1
	SET @Txt = ''
	SET @MaxCount = (SELECT MAX(RowID) FROM ConcatenationDemo) 
	WHILE @Count<=@MaxCount
		BEGIN
		IF @Txt!=''
			SET @Txt=@Txt+',' + (SELECT Txt FROM ConcatenationDemo 
            WHERE RowID=@Count)
		ELSE
			SET @Txt=(SELECT Txt FROM ConcatenationDemo WHERE RowID=@Count)
		SET @Count += 1
		END
	SELECT @Txt AS Txt

	DECLARE @i int
	SET @i = 0
	WHILE (@i < 10)
	BEGIN
		SET @i = @i + 1
		PRINT @i
		IF (@i >= 10)
			BREAK
		ELSE
			CONTINUE
	END
```	
***Try / Catch Statements***
```sql
	BEGIN TRY
		-- try / catch requires SQLServer 2005 
		-- run your code here
	END TRY
	BEGIN CATCH
		PRINT 'Error Number: ' + str(error_number()) 
		PRINT 'Line Number: ' + str(error_line())
		PRINT error_message()
		-- handle error condition
	END CATCH
```	
***To get date in DD/MM/YYYY format***
```sql
	SELECT CONVERT(varchar, GETDATE(), 103);
```
***To get all foreign keys refrencing a given table***
```sql
	EXEC sp_fkeys 'TableName'
```
***To get datatype, size of columns of a table***
```sql
	EXEC sp_columns CLOS_EXT;
```	
***To get empty string after concatenation of a string with NULL***	

When ***SET CONCAT_NULL_YIELDS_NULL*** is ON, concatenating a null value with a string yields a NULL result. 

For example, SELECT 'abc' + NULL yields NULL. 

When SET CONCAT_NULL_YIELDS_NULL is OFF, concatenating a null value with a string yields the string itself (the null value is treated as an empty string). 

For example, SELECT 'abc' + NULL yields abc.

***To compile without executing***
```sql
	SET NOEXEC ON;  	
```
When SET NOEXEC is ON, SQL Server compiles each batch of Transact-SQL statements but does not execute them. 
	
***Updating data from another table***
```sql
	UPDATE table  SET Col1 = i.Col1, Col2 = i.Col2 FROM ( SELECT ID, Col1, Col2 FROM other_table) i WHERE i.ID = table.ID
```
***Check if column exists in table***
```sql
	IF EXISTS(SELECT 1 FROM sys.columns 
			  WHERE Name = N'columnName'
			  AND Object_ID = Object_ID(N'schemaName.tableName'))
	BEGIN
		-- Column Exists
	END
```
***Converting Multi row data into a comma separated string***
```sql
	DECLARE @Names VARCHAR(8000) 
	SELECT @Names = COALESCE(@Names + ', ', '') + 
		ISNULL(Name, 'N/A')
	FROM People
```	
***Nvarchar***
allows storing of unicode data

***To remove duplicate rows***
```sql
	select  distinct * into t2 from t1;
	delete from t1;
	insert into t1 select *  from t2;
	drop table t2;
```
***Check if the table exists***
```sql
	IF (EXISTS (
	  SELECT * 
      FROM INFORMATION_SCHEMA.TABLES 
      WHERE TABLE_SCHEMA = 'TheSchema' 
      AND  TABLE_NAME = 'TheTable')
      )
	BEGIN
		--Do Stuff
	END
```
***Find tables with given column name***
```sql
	select * from INFORMATION_SCHEMA.COLUMNS 
	where COLUMN_NAME like '%clientid%' 
	order by TABLE_NAME
```
***Find all user tables***
```sql
	SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'
```
***Allows explicit values to be inserted into the identity column of a table.***
```sql
	SET IDENTITY_INSERT dbo.Tool ON    
```
The ***DBCC CHECKIDENT*** management command is used to reset identity counter. Example:
```sql
	DBCC CHECKIDENT ('[TestTable]', RESEED, 0);
	GO
```

***DECLARE and SET Varibales***
```sql
	DECLARE @Mojo int
	SET @Mojo = 1
	SELECT @Mojo = Column FROM Table WHERE id=1;
```
***Add a Foreign Key***
```sql
	ALTER TABLE Products WITH CHECK ADD CONSTRAINT [FK_Prod_Man] FOREIGN KEY(ManufacturerID) REFERENCES Manufacturers (ID);
```
***Add a NULL Constraint***
```sql
	ALTER TABLE TableName ALTER COLUMN ColumnName int NOT NULL;
```
***Set Default Value for Column***
```sql
	ALTER TABLE TableName ADD CONSTRAINT DF_TableName_ColumnName DEFAULT 0 FOR ColumnName;
```
***Create an Index***
```sql
	CREATE INDEX IX_Index_Name ON Table(Columns)
```
***Check Constraint***
```sql
	ALTER TABLE TableName ADD CONSTRAINT CK_CheckName CHECK (ColumnValue > 1)	
```
***Single Line Comments***
```sql
	SET @mojo = 1 --THIS IS A COMMENT
```
***Multi-Line Comments***
```sql
	/* This is a comment
		that can span
		multiple lines
	*/	
```
***User Defined Function***
```
	CREATE FUNCTION dbo.DoStuff(@ID int)
	RETURNS int
	AS
	BEGIN
	  DECLARE @result int
	  IF @ID = 0
		BEGIN
			RETURN 0
		END
	  SELECT @result = COUNT(*) 
	  FROM table WHERE ID = @ID
	  RETURN @result
	END
	GO
	SELECT dbo.DoStuff(0);	
```	
***Pivot - To convert rows into columns***
```sql
	SELECT Wi_name, Often, Sometimes, Never, NA
	FROM
    (
        SELECT  Wi_name, Past_due, 'Selected' T, '' F
        FROM NG_CA_MISCELLANEOUS_DETAILS
    ) P1
    PIVOT
    ( 
         MAX(T) for Past_due IN ([Often], [Sometimes], [Never],[NA])
    )
    P2 ORDER BY WI_NAME;
```    

***WITH (NOLOCK)***

is the equivalent of using READ UNCOMMITED as a transaction isolation level. While it can prevent reads being deadlocked by other. 

### ***Finding the last identity inserted into a table***

- ***@@IDENTITY*** returns the last identity value generated for any table in the current session, across all scopes. You need to be careful here, since it's across scopes. You could get a value from a trigger, instead of your current statement.

- ***SCOPE_IDENTITY()*** returns the last identity value generated for any table in the current session and the current scope. Generally what you want to use.

- ***IDENT_CURRENT('tableName')*** returns the last identity value generated for a specific table in any session and any scope. This lets you specify which table you want the value from, in case the two above aren't quite what you need (very rare). You could use this if you want to get the current IDENTITY value for a table that you have not inserted a record into.

@@IDENTITY and SCOPE_IDENTITY will return the last identity value generated in any table in the current session. 

However, SCOPE_IDENTITY returns the value only within the current scope; @@IDENTITY is not limited to a specific scope. That is, if there was a second IDENTITY inserted based on a trigger after your insert, it would not be reflected in SCOPE_IDENTITY, only the insert you performed.


IDENT_CURRENT is not limited by scope and session; it is limited to a specified table. IDENT_CURRENT returns the identity value generated for a specific table in any session and any scope. For more information, see IDENT_CURRENT.

Identity doesn’t guarantee uniqueness. If you want that, make a PK or add a unique index.
