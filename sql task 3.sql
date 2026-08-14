create database my_sales;
use my_sales;
create table sales(
   Order_ID int,
   Category varchar(20),
   Sub_Category varchar(20),
   Segment varchar(20),
   Sales int,
   Profit int,
   Quantity int
);
select*from Sales;
insert into sales values(1051,"Furniture","Door","Home",154,2365,8),(1052,"Office supplies","Table","Office",265,2547,6),(1053,"Furniture","Chairs","Home",2547,2364,5),(1054,"Office supplies","Computer","Office",785,4587,7),(1055,"Technology","Phones","Corporate",125,2547,9);
select*from Sales;
update Sales 
set Sub_Category="phones"
where Order_id=1046;
select*from Sales;
SET SQL_SAFE_UPDATES=0; 
update sales
set Sales=8500
where Order_ID=1048;
update sales
set Sales=4500
where Order_ID=1030;
update sales
set Profit=547
where Order_ID=1003;
update sales
set Quantity=20
where Order_ID=1011;
select * from Sales;
delete from Sales where Sub_Category="Door";
delete from Sales where Sub_Category="Binders";
delete from Sales where Sub_Category="Table";
delete from Sales where Sub_Category="Door";
delete from Sales where Category="technology";
select * from Sales;
