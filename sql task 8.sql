 use my_data;
 CREATE TABLE customers0 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customers0 (customer_id, customer_name, email, city)
VALUES
(101, 'julia', 'julia@gmail.com', 'Mangalore'),
(102, 'siana', 'siana@gmail.com', 'Bangalore'),
(103, 'Anushka', 'anushka@gmail.com', 'Kochi'),
(104, 'Alia', 'alia@gmail.com', 'Mysore'),
(105, 'Sia', 'sia@gmail.com', 'Chennai');

SELECT * FROM customers0;

CREATE TABLE transactions0 (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO transactions0
(transaction_id, customer_id, amount, transaction_date)
VALUES
(11, 101, 5500, '2026-08-01'),
(12, 102, 2500, '2026-08-03'),
(13, 101, 7200, '2026-08-05'),
(14, 103, 1500, '2026-08-07'),
(15, 104, 9200, '2026-08-09'),
(16, 102, 4800, '2026-08-10'),
(17, 103, 2000, '2026-08-11'),
(18, 104, 6000, '2026-08-12'),
(19, 105, 3000, '2026-08-13'),
(20, 105, 2500, '2026-08-14'),
(21, 101, 5700, '2026-08-15'),
(22, 102, 2550, '2026-08-02');

SELECT * FROM transactions0;


CREATE TABLE invoices0 (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(10,2),
    invoice_date DATE,
    due_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO invoices0
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(401, 101, 5000, '2026-08-01', '2026-08-10', 'Unpaid'),
(402, 102, 3000, '2026-08-05', '2026-08-15', 'Paid'),
(403, 103, 7000, '2026-08-10', '2026-08-20', 'Unpaid'),
(404, 104, 4000, '2026-08-12', '2026-08-25', 'Paid'),
(405, 105, 6000, '2026-08-15', '2026-08-28', 'Unpaid');

SELECT * FROM invoices0;

select customer_name from customers0 where customer_id in
(select customer_id from invoices0 where payment_status="unpaid");

select customer_name from customers0 where customer_id in(
select customer_id from transactions0 where amount>4500);

select customer_name from customers0 where customer_id in(
select customer_id from transactions0 where amount=(
select max(amount) from transactions0));

select * from transactions0 where amount>(
select avg(amount) from transactions0);

select customer_name from customers0 where customer_id in(
select customer_id from transactions0 where city="Mangalore");

select c.customer_id,
       c.customer_name
from customers0 c 
where exists (
select 1
from invoices0 i where c.customer_id=i.customer_id and i.payment_status='Paid');

select c.customer_id,
       c.customer_name
from customers0 c 
where exists (
select 1
from transactions0 t where c.customer_id=t.customer_id and t.amount>4500);

select t1.transaction_id,
       t1.amount
from transactions0 t1
where t1.amount> (
select avg(t2.amount)
from transactions0 t2 where t2.customer_id=t1.customer_id);

select t1.transaction_id,
       t1.customer_id,
       t1.amount
from transactions0 t1
where t1.amount> (
select avg(t2.amount)
from transactions0 t2 where t2.customer_id=t1.customer_id);

select c.customer_id,
       c.customer_name
from customers0 c 
where exists (
select 1
from transactions0 t where c.customer_id=t.customer_id and c.city='Mangalore');




