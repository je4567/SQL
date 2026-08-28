create database lobodb;
use lobodb;
CREATE TABLE Customers9 (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders9 (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Order_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers9(Customer_ID)
);

CREATE TABLE Invoices9 (
    Invoice_ID INT PRIMARY KEY,
    Order_ID INT,
    Invoice_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders9(Order_ID)
);

CREATE TABLE Payments9 (
    Payment_ID INT PRIMARY KEY,
    Invoice_ID INT,
    Payment_Date DATE,
    Payment_Amount DECIMAL(10,2),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoices9(Invoice_ID)
);

CREATE TABLE Ledger9 (
    Ledger_ID INT PRIMARY KEY,
    Customer_ID INT,
    Transaction_Date DATE,
    Debit DECIMAL(10,2),
    Credit DECIMAL(10,2),
    Description VARCHAR(100),
    FOREIGN KEY (Customer_ID) REFERENCES Customers9(Customer_ID)
);
select*from Customers9;
select*from Orders9;
select*from Invoices9;
select*from Payments9;
select*from Ledger9;
insert into Customers9 values
(5001,"Sweedal","Mangalore"),
(5002,"jenevia","kundapura"),
(5003,"Andrea","Sullia"),
(5004,"Alriya","Shivamogga"),
(5005,"Joshna","Bangalore");
select*from Customers9;
insert into Orders9 values
(4500,5001,'2025-10-5',8500),
(4501,5002,'2025-10-10',450),
(4502,5003,'2025-11-26',7630),
(4503,5004,'2025-11-27',500),
(4504,5005,'2025-12-8',650);
select*from Orders9;
insert into Invoices9 values
(1,4500,'2025-10-5',8500),
(2,4501,'2025-10-11',450),
(3,4502,'2025-11-26',7630),
(4,4503,'2025-11-28',500),
(5,4504,'2025-12-8',650);
select*from Invoices9;
insert into Payments9 values
(661,1,'2025-11-5',8500),
(662,2,'2025-11-1',450),
(663,3,'2025-12-5',7630),
(664,4,'2025-12-10',500),
(665,5,'2025-12-25',650);
select*from Payments9;
insert into Ledger9 values
(101,5001,'2025-11-5',0,8500,'payment received'),
(102,5002,'2025-11-1',0,450,'payment received'),
(103,5003,'2025-12-5',0,7630,'payment not received'),
(104,5004,'2025-12-10',0,500,'payment received'),
(15,5005,'2025-12-25',0,650,'payment not received');
select*from Ledger9;
select
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
from Customers9 c
inner join Orders9 o 
on c.Customer_ID=o.Customer_ID;
select
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
from Customers9 c
Left join Orders9 o 
on c.Customer_ID=o.Customer_ID;

select
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount
from Customers9 c
right join Orders9 o 
on c.Customer_ID=o.Customer_ID;

select
	c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Order_Amount,
    i.Invoice_ID,
    i.Invoice_Amount,
    p.Payment_ID,
    p.Payment_Amount,
    l.Ledger_ID,
    l.Debit,
    l.Credit
from Customers9 c
left join orders9 o
on  c.Customer_ID=o.Customer_ID
left join Invoices9 i
on o.Order_ID=i.Order_ID
left join Payments9 p
on i.Invoice_ID=p.Invoice_ID
left join Ledger9 l
on c.Customer_ID=l.Customer_ID;

