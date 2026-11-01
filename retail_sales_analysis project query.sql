-- =====================================================
-- Data Analysis & Business Key Problems & Answers[cite: 2]
-- =====================================================


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'[cite: 2]
select * 
from retail_sales_tb
where sale_date = '2022-11-05'
;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'[cite: 2]
--     and the quantity sold is more than 10 in the month of Nov-2022[cite: 2, 4]

select * from retail_sales_tb
where category = 'Clothing'
and quantity >=4
and to_char(sale_date,'Mon-yyyy') = 'Nov-2022';


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.[cite: 2]
select category  , 
sum(total_sale) as net_sales,
count(*) as total_orders from retail_sales_tb
group by 1 ;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.[cite: 2]
select round(avg(age)) as average_age
from retail_sales_tb
where category = 'Beauty' ;



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.[cite: 2]

select * 
  from retail_sales_tb
where total_sale >1000
;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.[cite: 2]

select category
, gender ,
count(transactions_id)
from retail_sales_tb
group by category,
gender ;




-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year[cite: 2]

select 
year ,
month , 
avg_sale
from 
(select
extract(year from sale_date)as year ,
extract(month from sale_date) as month ,
avg(total_sale) as avg_sale ,
rank () over (partition by  extract(year from sale_date) order by avg (total_sale) desc ) as rank 
from retail_sales_tb
group by 1,2 ) as t1
where rank =1 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales[cite: 2]

select customer_id ,
sum(total_sale) as highest_total_sales
from retail_sales_tb
group by 1
order by 2 desc 
limit 5 


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.[cite: 2]
select category ,
count(distinct customer_id)
from retail_sales_tb
group by
category 




-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)[cite: 2]
with hourly_sale
as 
(
select * ,
case when extract (hour from sale_time) < 12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'evening'
end as shift 
from retail_sales_tb )
select shift ,
count (*) as total_orders
from hourly_sale
group by shift 

-- End of project 













