-- NEW PROJECT

USE My_Database;

SELECT * FROM dbo.pizza_sales;

-- Find the total revenue from all the sales

SELECT SUM(total_price) AS 'Total Revenue'
FROM pizza_sales;

-- Find the Average order value --> Total Price/ Order ID

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS 'Average Order Value'
FROM pizza_sales;

-- Find the total pizzas sold

SELECT SUM(quantity) AS 'Total Pizzas Sold'
FROM pizza_sales;

-- Print the total Orders

SELECT COUNT(DISTINCT order_id) AS 'Total Orders Placed'
FROM pizza_sales;

-- Print Average pizzas per order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(8, 2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(8, 2)) AS DECIMAL(8, 2)) AS 'Average Pizzas per Order'
FROM pizza_sales;

-- Print the Daily Trend for total orders --> Show how many orders are being placed on daily basis

SELECT DATENAME(DW, order_date) AS 'Day of Week', COUNT(DISTINCT order_id) AS 'Total Daily Orders'
FROM pizza_sales 
GROUP BY DATENAME(DW, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Print the monthly trend for total orders --> Illustrating hourly trend of total orders throughout the day

SELECT DATENAME(MONTH, order_date) AS 'Month', COUNT(DISTINCT order_id) AS 'Total Monthly Orders'
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Print the percentage of sales by pizza category

SELECT pizza_category, CAST(((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales)) AS DECIMAL(8, 2)) AS '% of Sales'
FROM pizza_sales
GROUP BY pizza_category;

-- Print the percentage of sales by pizza size

SELECT pizza_size, CAST(((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales)) AS DECIMAL(8, 2)) AS '% of Sales'
FROM pizza_sales
GROUP BY pizza_size;

-- Print the total pizzas sold by pizza category

SELECT pizza_category, SUM(quantity) AS 'Total Pizzas Sold'
FROM pizza_sales
GROUP BY pizza_category;

-- Print top 5 best sellers by Revenue, total quantity, total orders

SELECT TOP 5 pizza_name, SUM(total_price) AS 'Top 5 in Revenue', SUM(quantity) AS 'Top 5 in quantity', 
COUNT(DISTINCT order_id) AS 'Top 5 Orders'
FROM pizza_sales
GROUP BY pizza_name ORDER BY SUM(total_price) DESC, SUM(quantity) DESC, COUNT(DISTINCT order_id) DESC; 

-- Print bottom 5 sellers by Revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS 'Bottom 5 in Revenue'
FROM pizza_sales
GROUP BY pizza_name ORDER BY SUM(total_price) ASC;



-- Print bottom 5 sellers by total quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS 'Bottom 5 in quantity' 
FROM pizza_sales
GROUP BY pizza_name ORDER BY SUM(quantity) ASC;




-- Print bottom 5 sellers by total orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS 'Bottom 5 Orders'
FROM pizza_sales
GROUP BY pizza_name ORDER BY COUNT(DISTINCT order_id) ASC; 