
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
	[Total_Items_Ordered] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date), 30)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date), 5)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date), 20)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date), 15)
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO

select * from items
select * from customers
select * from OrderDetails
select * from [dbo].[order]

--Query 1
create view v1 
as
select orderno as Order_Number, i.price * o.Quantity as Total_price
from OrderDetails o join Items i on o.ItemNo = i.ItemNo


--Query 2
create view v2 
as
select itemNo
from OrderDetails
group by itemNo
having sum(Quantity)>20
select * from v2
select * from v1
select * from v3

--Query 3
create view vTemp
as 
select Order_Number, sum(Total_price) as totalSum
from v1
group by Order_Number


create view v3
as
select CustomerNo
from [dbo].[Order] as ord join vTemp v on ord.OrderNo = v.Order_Number
group by CustomerNo
having sum(totalSum)>2000


--Query 4
create view  v4a as
select CustomerNo
from Customers
where Phone is not null
select * from v4a

create view  v4b as
select CustomerNo
from Customers
where Phone is not null
with check option
select * from v4b




--Stored Procedures

--Question 1

create Procedure processOrder 
@orderNum int, 
@itemNum int, 
@quantity int
as 
begin
	if exists(select * from Items where ItemNo = @itemNum and @quantity>[Quantity in Store])
	begin
		declare @quantityPresent int ;
		
		select @quantityPresent= (select [Quantity in Store] from items where @itemNum = ItemNo);
		print 'Only '+ cast(@quantityPresent as varchar(20))+' '+ ' is present which is less than the required quantity'
	end 
	else
	begin
		insert into OrderDetails values(@orderNum, @itemNum, @quantity);
		update Items 
		set [Quantity in Store] = [Quantity in Store]- @quantity
		where itemNo = @itemNum;
	end
end
drop procedure processOrder
select* from items
select* from OrderDetails
execute processOrder
@orderNum = 4 , @itemNum = 200, @quantity= 10 -- test case1
execute processOrder
@orderNum = 4 , @itemNum = 200, @quantity= 100 -- test case2

--Question 2
create procedure customerSignUp
@CustNum varchar(2),
@CityName varchar(30),
@PhoneNum varchar(11),
@flag int output
as
begin 
	if exists(select * from Customers where CustomerNo = @CustNum)
	begin
		select @flag = 1;
	end
	else if @CityName is null
	begin
		select @flag = 1;
	end
	else if not LEN(@PhoneNum) = 6
	begin
		select @flag = 1;
	end
	else
	begin
		select @flag = 0;
	end
end

--Test case 1
declare @isSuccess int = 0;
execute customerSignUp
@CustNum = 'C9', @CityName = 'Karachi', @PhoneNum = '990009', @flag= @isSuccess output
print @isSuccess

--Test case 2
declare @isSuccess int = 0;
execute customerSignUp
@CustNum = 'C1', @CityName = 'Karachi', @PhoneNum = '990009', @flag= @isSuccess output
print @isSuccess


--Question 3
create procedure cancelOrder
@CustNum varchar(2), 
@OrderNum int
as
begin 
	if exists(select * from [dbo].[order] o where o.OrderNo = @OrderNum and o.CustomerNo = @CustNum)
	begin
	delete from OrderDetails where OrderNo = @OrderNum 
	delete from [dbo].[order] where OrderNo = @OrderNum and CustomerNo =@CustNum

	end
	else 
	begin
	print 'The Order num or the Customer num is invalid'
	end
end

drop procedure cancelOrder
exec cancelOrder 
@custNum = 'C3', @OrderNum = 2

--Question 4
create view OrderPriceTotal
as
select Order_Number, sum(Total_price) as TotalPrice from v1 group by Order_Number 

create procedure getPoints
@name varchar(100),
@points int output
as
begin
	select @points = (	select sum(TotalPrice)/100 as points
						from (customers c join [dbo].[Order] o on c.CustomerNo = o.CustomerNo) join OrderPriceTotal opt on o.OrderNo = opt.Order_Number 
						where Name = @name 
						group by o.CustomerNo)

end
--Test Case
DECLARE @pointCount int;
execute getPoints 
@name='Ahmed Ali', @points = @pointCount output;
print @pointCount






