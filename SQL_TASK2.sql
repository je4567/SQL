use financialdb;
create table Customers_4(
  Customer_ID int primary key,
  Customer_Name varchar(50)not null,
   Email varchar(50) unique,
   Phone int,
   foreign key(Customer_Name)
     references Customers_4(Customer_ID)
);
alter table Customers_4 add Address varchar(30);
alter table Customers_4 modify phone int;
drop table Customers_4;

create table Accounts_5(
  Account_ID int primary key,
  Customer_ID int,
   Account_Type varchar(40) not null,
   Balance decimal(10,2),
   foreign key(Customer_ID)
    references Accounts_5(Account_ID)
);
alter table Customers_4 add Account_Name varchar(50);
alter table Customers_4 modify phone int;
alter table Customers_4 add constraint check(Balance>=58000);
drop table Customers_4;


create table Transactions_6(
   Transaction_ID int primary key, 
   Account_ID int , 
   Transaction_Date int,
   Transaction_Type varchar(20),
   Amount decimal(10,2)not null, 
   foreign key(Account_ID)
    references Accounts_5(Transaction_ID)
);
alter table Customers_4 add Transaction_Name varchar(50);
alter table Customers_4 add constraint check(transactions_type in ('credit', 'debit');
alter table Customers_4 modify Transaction_Date int;
drop table Customers_4;


   