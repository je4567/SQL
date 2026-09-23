use accountingdb_jenevia;
CREATE TABLE monthly_finance (
    id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    month_name VARCHAR(20),
    sales DECIMAL(10,2),
    expenses DECIMAL(10,2),
    tax_rate DECIMAL(5,2)
    );
    
INSERT INTO monthly_finance
VALUES
(1, 'Rahul', 'January', 50000, 30000, 10),
(2, 'Priya', 'January', 60000, 35000, 10),
(3, 'Anu', 'January', 45000, 25000, 10),
(4, 'Rahul', 'February', 55000, 32000, 10),
(5, 'Priya', 'February', 65000, 38000, 10),
(6, 'Anu', 'February', 50000, 27000, 10),
(7, 'Rahul', 'March', 60000, 34000, 10),
(8, 'Priya', 'March', 70000, 40000, 10),
(9, 'Anu', 'March', 55000, 30000, 10);

select * from monthly_finance;

DELIMITER //
CREATE procedure CalculateTax(
	in p_sales decimal(10,2),
    in p_tax_rate decimal(10,2)
)

BEGIN 
     SELECT p_sales as sales,
     p_tax_rate as tax_rate,
     p_sales*p_tax_rate/100 as tax_amount;
     
end //
DELIMITER ;
call CalculateTax(50000,3);
call CalculateTax(60000,5);

create table month_end_closing(
month varchar(30),
total_sales decimal(10,2),
total_expenses decimal(10,2),
profit_lose decimal(10,2)
);
DELIMITER  //


create procedure month_end_closing(
in p_month varchar(20))
BEGIN
insert into month_end_closing (month,total_sales,total_expenses,profit_lose)
select month_name,sum(sales),sum(expenses),sum(sales)-sum(expenses)
from monthly_finance
where month_name=p_month
group by month_name;

END //
DELIMITER ;

call month_end_closing('March');
call month_end_closing('February');
select*from month_end_closing;

DELIMITER //
create procedure CustomerSummary(
	in p_customer varchar(50)
)
BEGIN
	SELECT
		customer_name,
		sum(sales) as total_sales,
		sum(expenses) as total_expenses,
		sum(sales)-sum(expenses) as total_profit
	from monthly_finance
    where customer_name-P_customer
    group by customer_name;
END //
DELIMITER ;
 
 call CustomerSummary("Rahul");
 call CustomerSummary("Anu");
 
 CREATE TABLE YearEndProfit(
       total_sales decimal(10,2),
       total_expenses decimal(10,2),
       total_profit decimal(10,2)
       );
 
 DELIMITER //
create procedure YearEndProfit()
BEGIN
	insert into year_end_profit
    (total_sales,total_expenses,total_profit)
	select SUM(sales),
           SUM(expenses),
           SUM(sales) - SUM(expenses)
FROM monthly_finance;

END //
DELIMITER ;

CALL YearEndProfit();
select*from YearEndProfit;