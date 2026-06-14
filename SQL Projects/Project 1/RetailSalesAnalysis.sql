-- STEP 1 SETUP DATABASE

-- DROP TABLE IF EXISTS sales_detail;
-- CREATE TABLE sales_detail;
-- SELECT * FROM sales_detail; -- SHOW TABLE
-- SELECT COUNT(*) FROM sales_detail; --COUNT ALL THE ROWS IN THE TABLE

-- STEP 2 CLEANING DATABASE 

SELECT *                                             -- CHECK FOR NULL VALUES # NO NULL VALUES FOUND
FROM sales_detail 
WHERE (
	   ï»¿transactions_id IS NULL
       OR
       sale_date IS NULL
       OR
       sale_time IS NULL
       OR
       customer_id IS NULL
       OR 
       gender IS NULL 
       OR 
       age IS NULL
       OR
       category IS NULL
       OR 
       quantiy IS NULL
       OR 
       price_per_unit IS NULL
       OR 
       cogs IS NULL
       OR 
       total_sale IS NULL
       );
       
-- DELETE                               --TO DELETE THE NULL ROW VALUES IN THE TABLE
-- FROM sales_detail 
-- WHERE
-- ( 
--     ï»¿transactions_id IS NULL 
--     OR sale_date IS NULL 
--     OR sale_time IS NULL 
--     OR customer_id IS NULL 
--     OR gender IS NULL 
--     OR age IS NULL 
--     OR category IS NULL 
--     OR quantiy IS NULL 
--     OR price_per_unit IS NULL 
--     OR cogs IS NULL 
--     OR total_sale IS NULL);

-- STEP 3 Exploratory Data Analysis (EDA)
-- 1) HOW MANY SALES WE HAVE?
-- 2) HOW MANY UNIQUE SALES WE HAVE?

SELECT COUNT(total_sale) AS TOTAL_SALE FROM sales_detail; -- 1

SELECT COUNT(DISTINCT ï»¿transactions_id) AS UNIQUE_SALES FROM sales_detail;  -- 2
SELECT DISTINCT category FROM sales_detail;

-- STEP 4 Business Analysis (Data Analysis & Business Key Problems & Answers)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is less than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <= 12, Afternoon Between 12 & 17, Evening >17)|

-- Q1)
SELECT * 
FROM sales_detail 
WHERE 
sale_date = '05-11-2022';

-- Q2)
SELECT * 
FROM sales_detail 
WHERE category = 'Clothing' 
  AND quantiy < 4
  AND sale_date BETWEEN '01-11-2022' AND '30-11-2022';

-- Q3)
SELECT SUM(total_sale) AS 'Total Sales',COUNT(total_sale) AS 'Orders', category
FROM sales_detail
GROUP BY category;

-- Q4)
SELECT ROUND(AVG(age)) AS AVG_AGE, category
FROM sales_detail 
WHERE category = 'Beauty';

-- Q5)
SELECT * 
FROM sales_detail
WHERE 
total_sale > 1000;

-- Q6)
SELECT COUNT(ï»¿transactions_id)  AS transactions ,  gender,
    category
FROM sales_detail
GROUP BY gender,category
ORDER BY gender;

-- Q7)
SELECT 
year,
month,
avg_sale
from
(
select 
extract(year from STR_TO_DATE(sale_date, '%d-%m-%y')) as year, 
extract(month from STR_TO_DATE(sale_date, '%d-%m-%y')) as month,
avg(total_sale) as avg_sale,
rank() over(partition by extract(year from STR_TO_DATE(sale_date, '%d-%m-%y')) order by avg(total_sale) desc
) as ranks
from sales_detail
group by 1,2) as t1
where ranks=1; -- changing the date format does not give null values for month and year using rank to rank the highest sales month

-- Q8)
SELECT SUM(total_sale) AS total_sale,customer_id
FROM sales_detail
GROUP BY customer_id
ORDER BY total_sale DESC LIMIT 5;

-- Q9)
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers_count
FROM 
    sales_detail
GROUP BY 
    category
ORDER BY 
    unique_customers_count DESC;

-- Q10)
WITH hourly_sale
as(
SELECT * ,
CASE 
    WHEN  extract(hour from sale_time) < 12 THEN 'MORNING'
    WHEN  extract(hour from sale_time) between 12 AND 17 THEN 'AFTERNOON' 
    ELSE 'EVENING'
END AS TIME
FROM sales_detail
)
SELECT
TIME,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY TIME; 

-- END OF MY PROJECT 1 