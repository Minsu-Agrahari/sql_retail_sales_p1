-- sql Retail Sales Analysis - P1
--# CREATING THE DATABASE
CREATE DATABASE PROJECT_P1;

--# Create Tables
DROP TABLE IF EXISTS retail_sales; -- this will remove a table name retail_sales if it is pre-present in the databasae
CREATE TABLE retail_sales(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(6),
		age INT,
		category VARCHAR(25),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	);

--# PRINTING THE DATA SET
SELECT COUNT(*) FROM retail_sales;

--## DATA CLEANING PROCESS
-- CHECKING FOR NULL VALUES
SELECT * FROM RETAIL_SALES
WHERE  transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

-- DELETE VALUES WITH NULL VALUE
DELETE FROM RETAIL_SALES
WHERE  transactions_id IS NULL
		OR sale_date IS NULL
		OR sale_time IS NULL
		OR customer_id IS NULL
		OR gender IS NULL
		OR age IS NULL
		OR category IS NULL
		OR quantiy IS NULL
		OR price_per_unit IS NULL
		OR cogs IS NULL
		OR total_sale IS NULL;

--## Data Exploration 

-- Q1. How many sales we have ?
SELECT COUNT(transactions_id) AS total_sales FROM retail_sales;

-- Q2. How many customer are their ?
SELECT COUNT(DISTINCT customer_id) AS Customer_count FROM retail_sales;

-- Q3. How many counts of category are their ?
SELECT COUNT(DISTINCT category) AS Customer_count FROM retail_sales;

-- Q4. How many distinct category are their ?
SELECT DISTINCT category AS Customer_count FROM retail_sales;

--## Data Analysis & Business key Problems & Answers
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--Solution :- 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT transactions_id FROM retail_sales
WHERE category = 'Clothing' AND
		quantiy > 10 AND
		EXTRACT(MONTH FROM sale_date) = 11 AND
		EXTRACT(YEAR FROM sale_date) = 2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT COUNT(category) FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT transactions_id FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT SUM(transactions_id) AS total_transaction,
		gender 
FROM retail_sales
GROUP BY gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT ROUND(AVG(total_sale :: NUMERIC),2) AS avg_Sale, 
		EXTRACT(MONTH FROM sale_date) AS Mon
FROM retail_sales
GROUP BY EXTRACT(MONTH FROM sale_date)
ORDER BY Mon;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id FROM retail_sales
ORDER BY total_sale
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT customer_iD), category FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT * ,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning' 
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon' 
		WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening' 
	END AS shift
FROM retail_sales



-- END OF THE PROJECTS ...