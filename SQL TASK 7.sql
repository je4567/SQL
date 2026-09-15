use financialdb;
CREATE TABLE Customer_1(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    phone_number bigint
);

INSERT INTO Customer_1 VALUES
(1, 'ramesh', 2654123698),
(2, 'likitha', 2212357401),
(3,'shiya',1236547980);
SELECT * FROM Customer_1;

CREATE TABLE Invoice_1 (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount int,
    due_date date,
    FOREIGN KEY (customer_id)
      references customer_1(customer_id));
      
INSERT INTO Invoice_1 VALUES
(101, 1, 75000, '2026-05-12'),
(102, 2, 12500, '2026-05-20'),
(103, 3, 40000, '2026-05-22');
SELECT * FROM Invoice_1;

CREATE TABLE Payment_1 (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_amount DECIMAL(10,2),
	FOREIGN KEY (invoice_id)
      references Invoice_1(invoice_id));
INSERT INTO Payment_1 VALUES
(1001, 101, 75000),
(1002, 102, 12500),
(1003, 103, 40000);
SELECT * FROM Payment_1;

create view customer_balances as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance 
from Customer_1 c
join Invoice_1 i on c.customer_id=i.customer_id
join Payment_1 p on i.invoice_id = p.invoice_id;

select * from customer_balances;


create view customer_overdue as 
select c.customer_name,
       i.invoice_amount - p.payment_amount as overdue 
from Customer_1 c
join Invoice_1 i on c.customer_id=i.customer_id
join Payment_1 p on i.invoice_id = p.invoice_id
where invoice_amount> payment_amount;

select * from customer_overdue;

create view customer_overdue_balance as 
select c.customer_name,
	   i.invoice_amount,
       p.payment_amount,
       i.invoice_amount - p.payment_amount as balance ,
       DATEDIFF(CURDATE(),i.due_date) as days_overdue
from Customer_1 c
join Invoice_1 i on c.customer_id=i.customer_id
join Payment_1 p on i.invoice_id = p.invoice_id;
select * from customer_overdue_balance;

select customer_id,customer_name from Customer;

create view customer_restrict as
select c.customer_name,
		i.invoice_amount,
        p.payment_amount,
        i.invoice_amount-p.payment_amount as balance
from Customer_1 c 
join Invoice_1 i on c.customer_id= i.customer_id 
join Payment_1 p on i.invoice_id=p.invoice_id
where i.invoice_amount-p.payment_amount>0;

select * from customer_restrict;