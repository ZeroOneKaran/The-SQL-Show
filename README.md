# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL - Retail Sales Analysis_utf`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL - Retail Sales Analysis_utf`.
- **Table Creation**: A table named `sales_info` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, cost price, selling price, and total sale amount.

```sql
CREATE DATABASE Retail Sales Analysis Project;

CREATE TABLE sales_info
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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.



### Data Quality Check

### 2A. & 2B. Count total records and unique customers

```sql
SELECT COUNT(*) FROM sales_info;
SELECT COUNT(DISTINCT customer_id) FROM sales_info;
```

### 2C. View distinct categories

```sql
SELECT DISTINCT category FROM sales_info;
```

## Data Cleaning

### 2D. Identify null values

```sql
SELECT * FROM sales_info
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR cost_price IS NULL OR selling_price IS NULL;
```

### 2E. Remove records with null values

```sql
DELETE FROM sales_info
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR cost_price IS NULL OR selling_price IS NULL;
```

### 2F. View cleaned data ordered by sale date

```sql
SELECT *
FROM sales_info
ORDER BY sale_date;
```

### 2G. Additional null value check

```sql
SELECT * 
FROM sales_info
WHERE 
    transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id
    IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL OR quantity
    IS NULL OR selling_price IS NULL OR cost_price IS NULL OR total_sale IS NULL;
```

### 2H. Remove all records with any null values

```sql
DELETE FROM sales_info
WHERE 
    transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id
    IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL OR quantity
    IS NULL OR selling_price IS NULL OR cost_price IS NULL OR total_sale IS NULL;
```

### 3. Data Exploration & Analysis



### 1. Sales in a specific month (March 2022)

```sql
SELECT *
FROM sales_info
WHERE sale_date BETWEEN '2022-03-01' AND '2022-03-31'
ORDER BY sale_date;
```

### 2. Electronics sold in December 2022 to customers under 40

```sql
SELECT *
FROM sales_info
WHERE
    sale_date BETWEEN '2022-12-01' AND '2022-12-31'
    AND category = 'Electronics'
    AND age <= 40
ORDER BY sale_date;
```

### 3. Total sales per category

```sql
SELECT  category,
        COUNT(*) total_orders,
        SUM(total_sale) AS sales_per_category
FROM sales_info
GROUP BY category;
```

### 4. Average age of beauty product customers

```sql
SELECT  ROUND(AVG(age),2) AS average_age
FROM sales_info
WHERE category = 'Beauty';
```

### 5. High-value transactions (≥ \$1000)

```sql
SELECT *
FROM sales_info
WHERE total_sale >= 1000;
```

### 6. Sales analysis by category and gender

```sql
SELECT  category,
        gender,
        COUNT(*) AS number_of_transactions
FROM sales_info
GROUP BY 1,2
ORDER BY 1;
```

### 7. Using CTE to find the best selling month in each year

```sql
WITH t1 AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS sale_year,
        EXTRACT(MONTH FROM sale_date) AS sale_month,
        AVG(total_sale) AS AVG_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
    FROM sales_info
    GROUP BY 1,2
)
SELECT
    sale_year,
    sale_month,
    AVG_sale
FROM t1
WHERE RANK = 1;
```

### 8. Top 5 customers by total sales

```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM sales_info
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

### 9. Sales analysis by time of day

```sql
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
GROUP BY 1;
```

## End of Project

## Summary

This SQL analysis covers:

-   **Data Quality Assessment**: Identifying and handling null values
-   **Data Cleaning**: Removing incomplete records
-   **Business Intelligence**: Category performance, customer demographics, temporal patterns
-   **Advanced Analytics**: Using CTEs and window functions for ranking and segmentation

The queries demonstrate proficiency in data cleaning, exploratory data analysis, and deriving business insights from transactional data.


## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
