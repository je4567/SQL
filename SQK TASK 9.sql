USE jenevia_db;
CREATE TABLE transactions1 (
    transaction_id INT ,
    transaction_date DATE,
    department varchar(30),
    transaction_type varchar(30),
    amount DECIMAL(10,2)
);
INSERT INTO transactions1
(transaction_id,  transaction_date, department,transaction_type ,amount)
VALUES
(1,'2025-01-10',"Sales","income",50000),
(2,'2025-01-15',"HR","expense",15000),
(3,'2025-02-05',"sales","income",60000),
(4,'2025-02-12',"IT","expense",20000),
(5,'2025-03-03',"sales","income",55000),
(6,'2025-03-20',"HR","expense",10000),
(7,'2025-04-10',"sales","income",70000);


SELECT * FROM transactions1;


with monthly_summary as(
select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions1
group by year(transaction_date),month(transaction_date)
)
select*from monthly_summary; 

select year(transaction_date)as year,month(transaction_date)as month,sum(amount) as total_amount
from transactions1
where transaction_type="income"
group by year(transaction_date),month(transaction_date);


select year(transaction_date)as year,sum(amount) as total_income
from transactions1
where transaction_type="income"
group by year(transaction_date);  

select department,sum(amount) as total_expenses
from transactions1
where transaction_type="expense"
group by department;

select year(transaction_date)as year,department,sum(amount) as total_expenses
from transactions1
where transaction_type="expense"
group by year(transaction_date),department;













