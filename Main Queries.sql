--Database Setup

CREATE DATABASE Retail Sales Analysis Project;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    selling_price FLOAT,	
    cost_price FLOAT,
    total_sale FLOAT
);

-- Query to view the table, ordered by date of sale

SELECT *
FROM sales_info
ORDER BY sale_date


--Checking and Removing Null Values in the dataset

SELECT * 
FROM sales_info
WHERE 
	transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id
	IS NULL OR gender IS NULL OR age IS NULL OR	category IS NULL OR	quantity
	IS NULL OR selling_price IS NULL OR	cost_price IS NULL OR total_sale IS NULL

delete FROM sales_info
WHERE 
	transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id
	IS NULL OR gender IS NULL OR age IS NULL OR	category IS NULL OR	quantity
	IS NULL OR selling_price IS NULL OR	cost_price IS NULL OR total_sale IS NULL


--Data Exploration

-- Sales made in a specific month

SELECT *
FROM sales_info
WHERE sale_date BETWEEN '2022-03-01' AND '2022-03-31'
ORDER BY sale_date


-- All electronics sold in December 2022 to customers aged less than 40

SELECT *
FROM sales_info
WHERE
	sale_date BETWEEN '2022-12-01' AND '2022-12-31'
	AND
	category = 'Electronics'
	AND age <= 40
ORDER BY sale_date


-- Total sale for each category

SELECT 	category,
		COUNT(*) total_orders,
		SUM(total_sale) AS sales_per_category
FROM sales_info
GROUP BY category


-- Average age for customers who purchased beauty products

SELECT 	ROUND(AVG(age),2) AS average_age
FROM sales_info
WHERE category = 'Beauty'


-- Query to view sales more than 1000

SELECT *
FROM sales_info
WHERE total_sale >= 1000


-- Query to view sales in each category by gender

SELECT 	category,
		gender,
		COUNT(*) AS number_of_transactions
	FROM sales_info
GROUP BY 1,2
ORDER BY 1


-- Average sale for each month, and best selling month in each year
-- Using CTE to simplify extracting each year value and ranking the best selling month

WITH t1 AS (
		SELECT 
 			EXTRACT(YEAR FROM sale_date) AS sale_year,
 			EXTRACT(MONTH FROM sale_date) AS sale_month,
 			AVG(total_sale) AS AVG_sale,
 			RANK() OVER(PARTITON BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
		
FROM sales_info
GROUP BY 1,2
)
SELECT
 		sale_year,
		sale_month,
		AVG_sale
 FROM t1
 WHERE RANK = 1
 

-- Top 5 customers based on highest sales

SELECT 
	customer_id,
	SUM(total_sale) AS total_sales
FROM sales_info
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Number of Unique Customers who purchased from each category

WITH hourly_sale AS
(
SELECT *,
 CASE
	 WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM sales_info
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY 1



-- End of Project