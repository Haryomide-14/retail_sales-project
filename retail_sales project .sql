create table  Retail_Sales_Analysis_utf (transactions_id int,	sale_date date,	sale_time time,	customer_id int,	gender text,	age int,	category text,	quantiy int,	price_per_unit numeric(10,2), cogs numeric(10,2),	total_sale numeric(10,2)
)
select *
from Retail_Sales_Analysis_utf

ALTER TABLE Retail_Sales_Analysis_utf
RENAME COLUMN quantiy TO quantity;


--Business Key Problems questions to solve
--My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from Retail_Sales_Analysis_utf
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'
--and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM Retail_Sales_Analysis_utf
WHERE category = 'Clothing'
  AND quantity > 10
  AND DATE_TRUNC('month', sale_date) = '2022-11-01';
  
-- There is no detail of the category clothing that sold more than 10 in november 2022

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select sum(total_sale),
       category
from Retail_Sales_Analysis_utf
group by category 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as average_age
from Retail_Sales_Analysis_utf
where category = 'Beauty'
group by category

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from Retail_Sales_Analysis_utf
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) 
-- made by each gender in each category.
select 
    gender,
    category,
    count(transactions_id) as total_transactions
from Retail_Sales_Analysis_utf
group by gender, category
order by gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. 
--Find out best selling month in each year
select 
    extract(year from sale_date) as year,
    extract(month from sale_date)  as month,
    ROUND(avg(total_sale), 2) as average_monthly_sale
from Retail_Sales_Analysis_utf
group by year, month
order by year, month;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM Retail_Sales_Analysis_utf
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select distinct count(customer_id),
       category
from Retail_Sales_Analysis_utf
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, 
--Afternoon Between 12 & 17, Evening >17)6:20 PM

SELECT 
    CASE 
        WHEN sale_time <= TIME '12:00:00' THEN 'Morning'
        WHEN sale_time > TIME '12:00:00' 
             AND sale_time <= TIME '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM Retail_Sales_Analysis_utf
GROUP BY shift
ORDER BY shift;