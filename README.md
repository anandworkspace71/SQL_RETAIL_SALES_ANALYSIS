Markdown
# Retail Sales Analysis SQL Project
**Author**: Anand Singh  

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`  
**RDBMS**: PostgreSQL  

This project demonstrates the core SQL techniques used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail database, performing exploratory data analysis (EDA), and writing structured queries to answer specific business questions. The insights generated mimic real-world operational reporting and MIS workflows, establishing a solid foundation for data-driven decision-making.

## Objectives

1. **Database Setup**: Create and populate a retail sales database with transactional data.
2. **Data Integrity & Cleaning**: Identify and remove records with missing or null values to ensure reporting accuracy.
3. **Exploratory Data Analysis (EDA)**: Perform foundational analysis to understand dataset distributions and boundaries.
4. **Business Intelligence**: Use advanced SQL functions (CTEs, Window Functions, Aggregations) to derive actionable insights regarding customer behavior, sales trends, and product performance.

## Project Structure

### 1. Database Setup

- **Database Creation**: Initializes `p1_retail_db`.
- **Table Creation**: Constructs the `retail_sales` table with appropriate data types for transaction IDs, dates, times, customer demographics, pricing, cost of goods sold (COGS), and total revenue.

```sql
CREATE DATABASE p1_retail_db;

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
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
2. Data Exploration & Cleaning
Record Count: Determine the total volume of transactional data.

Customer Count: Identify the number of unique customers.

Category Count: Extract all unique product categories.

Null Value Check: Identify and eliminate incomplete records to maintain data quality.

SQL
-- Total Records
SELECT COUNT(*) FROM retail_sales;

-- Unique Customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Unique Categories
SELECT DISTINCT category FROM retail_sales;

-- Check for Null Values
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Remove Null Records
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
3. Data Analysis & Business Queries   
The following queries address specific operational and business reporting requirements:

1. Retrieve all columns for sales made on '2022-11-05':

SQL
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
2. Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SQL
SELECT *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND quantity >= 4;
3. Calculate the total sales and total orders for each category:

SQL
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;
4. Find the average age of customers who purchased items from the 'Beauty' category:

SQL
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
5. Find all transactions where the total sale is greater than 1000:

SQL
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;
6. Find the total number of transactions made by each gender in each category:

SQL
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
7. Calculate the average sale for each month and isolate the best-selling month in each year:

SQL
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
    FROM retail_sales
    GROUP BY 1, 2
) as t1
WHERE rank = 1;
8. Identify the top 5 customers based on the highest total sales:

SQL
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
9. Find the number of unique customers who purchased items from each category:

SQL
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;
10. Group sales into shifts and calculate the number of orders per shift (Morning <12, Afternoon 12-17, Evening >17):

SQL
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END as shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
Findings   
Customer Demographics: The dataset captures diverse age groups, highlighting distinct purchasing behaviors across categories like Clothing and Beauty.

High-Value Transactions: A segment of transactions exceeds 1000 in total sales, pointing to premium purchases or bulk order volume.

Sales Trends: Monthly and shift-based analysis reveals operational peaks, helping to identify seasonal demand and optimal staffing times.

Customer Insights: Identifying top-spending customers and unique category counts provides a foundation for targeted marketing and inventory planning.

Conclusion
This project mirrors the daily reporting tasks of an MIS Executive or Data Analyst. By setting up the database, cleaning the raw data, and executing complex SQL queries (including CTEs and Window Functions), this analysis provides actionable business intelligence. The resulting insights can directly inform inventory management, sales strategies, and operational planning.


<ElicitationsGroup message="Next steps for your repository:">
  <Elicitation label="How to upload the actual SQL files" query="How do I upload my actual .sql code files to this GitHub repository?"/>
  <Elicitation label="Review my GitHub profile bio" query="Help me write a professional GitHub bio tailored for Data Analyst and MIS roles."/>
</ElicitationsGroup>
