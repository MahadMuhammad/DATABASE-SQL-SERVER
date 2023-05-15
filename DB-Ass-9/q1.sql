CREATE TABLE products (
    id INT PRIMARY KEY, 
    name VARCHAR(20),
    price DECIMAL,
    quantity FLOAT
);



go
CREATE TRIGGER before_insert_products
ON products 
INSTEAD OF INSERT
FOR EACH ROW 
BEGIN
    IF NEW.price < 0 OR 
    NEW.price > 1000 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price must be between 0 and 1000';
    END IF;
END




INSERT INTO products (id, name, price, quantity) VALUES (1, 'Product 1', 100, 10);
INSERT INTO products (id, name, price, quantity) VALUES (2, 'Product 2', 1000, 10);
INSERT INTO products (id, name, price, quantity) VALUES (3, 'Product 3', 1001, 10);


----------------------------------------
ntity INT
);
create trigger one
on product 
instead of insert 
as begin
declare @p varchar(10)
set @p=(select price from inserted)
if(@p<0 or @p>1000)
begin
print('invalid price '+@p+'');
end
else
begin
insert into product values((select column_id from inserted),(select names from inserted),(select price from inserted),(select quantity from inserted));
end
end;

drop trigger one;
drop table product;
insert into product values(1,'pizza',10000,3);
insert into product values(1,'ahmad',10,3);


select *from product;



--q2
create table orders
(
id INT foreign key references customers(id)
);

create table customers
(
id INT primary key,
);

create trigger two
on customers
instead of delete as
begin
declare @i int
set @i=(select id from deleted)
if not exists(select *from orders where orders.id=@i)
begin
delete from customers
where customers.id=@i
end
else
begin 
print('ERROR AGYA ')
end
end;

insert into customers values(1);
insert into customers values(2);
insert into customers values(3);

select *from customers;
select *from orders;

insert into orders values(3);
delete from customers where id=3;



--q3
create table log
(
coloumn_id INT,
table_name varchar(20),
column_name varchar(20),
old_value int,
new_value int,
timestamps int
);

create trigger three
on log
instead of update
as
begin

end;