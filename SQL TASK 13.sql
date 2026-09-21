create database jen18;
use jen18;
create table customers18(
   customer_id int primary key,
   customer_Name varchar(30),
   email varchar(30)
);
create table transactions18(
   transaction_id int primary key,
   customer_id int,
   amount decimal(10,2),
   transaction_date date,
   foreign key(customer_id) references customers18(customer_id)
);
create table salaries18(
   employee_id int primary key,
   employee_Name varchar(30),
   salary decimal(10,2)
);
create user 'manager'@'localhost' identified by 'manager@123';
create user 'accounttant'@'localhost' identified by 'account@123';
create user 'clerk'@'localhost' identified by 'clerk@123';
   
grant select on jen18.*
to  'manager'@'localhost';

grant select,insert,update
on jen18.transactions18
to 'accounttant'@'localhost';

grant select 
on jen18.customers18
to 'accounttant'@'localhost';

grant select 
on jen18.customers18
to 'clerk'@'localhost';

grant delete
on jen18.transactions18
to 'accounttant'@'localhost';

revoke delete 
on jen18.transactions18
from 'accounttant'@'localhost';

show grants for 'manager'@'localhost';
show grants for 'accounttant'@'localhost';
show grants for 'clerk'@'localhost';

