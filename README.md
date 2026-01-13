# 🍕 Pizza Sales Performance Analysis (SQL & Power BI)

Analyzed transactional pizza sales data to identify revenue drivers, demand patterns, and product performance insights that support pricing, inventory, and operational decision-making.

---

## Business Objective

The objective of this project is to analyze historical pizza sales data in order to:

- Monitor revenue and order-level KPIs
- Identify daily and monthly demand trends
- Understand customer preferences by pizza category and size
- Identify top-performing and underperforming products
- Support data-driven operational and commercial decisions

---

## Dataset Overview

- Source: Public Pizza Sales Dataset
- Size: ~48,000+ transaction records
- Granularity: Order-item level
- Time Coverage: Daily transactional sales data

Key fields include:
- order_id
- order_date, order_time
- pizza_name, pizza_category, pizza_size
- quantity, unit_price, total_price

---

## Key KPIs

- Total Revenue
  - In SQL
  ```sql
  SELECT SUM(total_price) AS 'Total Revenue'
  FROM pizza_sales;
  ```
  - In Power Bi DAX
    ```powerbi
    Total Revenue = SUM(pizza_sales[total_price])
  
- Total Orders
  - In SQL
   ```sql
   SELECT COUNT(DISTINCT order_id) AS 'Total Orders Placed'
  FROM pizza_sales;
  ```
  - In Power Bi DAX
    ```powerbi
    Total Orders = DISTINCTCOUNT(pizza_sales[order_id])    
- Total Pizzas Sold
  - In SQL
    ```sql
    SELECT SUM(quantity) AS 'Total Pizzas Sold'
    FROM pizza_sales;
    ```
  - In Power Bi DAX
    ```powerbi
    Total Pizzas Sold = SUM(pizza_sales[quantity])

- Average Order Value (AOV)
  - In SQL
    ```sql
    SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS 'Average Order Value'
    FROM pizza_sales;
    ```
  - In Power Bi DAX
    ```powerbi
    Average Order Value = [Total Revenue] / [Total Orders]

- Average Pizzas per Order
   - In SQL
     ```sql
     SELECT CAST(CAST(SUM(quantity) AS DECIMAL(8, 2)) / 
       CAST(COUNT(DISTINCT order_id) AS DECIMAL(8, 2)) AS DECIMAL(8, 2)) AS 'Average Pizzas per Order'
     FROM pizza_sales;
     ```
   - In Power Bi DAX
     ```powerbi
     Average Pizzas Per Order = [Total Pizzas Sold] / [Total Orders]

---

## Methodology

1. **Data cleaning and transformation using Power Query (M Language)**
2. **Date feature engineering (day, month, quarter) executed both in SQL & Power Query Editor in Power Bi for analysis**
4. **Metric calculation using DAX in Power BI**
5. **SQL validation and aggregation using Microsoft SQL Server**
   - Daily Trend for total orders to show how many orders are being placed on daily basis
    ```sql
    SELECT DATENAME(DW, order_date) AS 'Day of Week', 
           COUNT(DISTINCT order_id) AS 'Total Daily Orders'
    FROM pizza_sales 
           GROUP BY DATENAME(DW, order_date)
           ORDER BY COUNT(DISTINCT order_id) DESC;
    ```
   - Monthly trend for total orders illustrating hourly trend of total orders throughout the day
    ```sql
     SELECT DATENAME(MONTH, order_date) AS 'Month', 
            COUNT(DISTINCT order_id) AS 'Total Monthly Orders'
     FROM pizza_sales
            GROUP BY DATENAME(MONTH, order_date)
            ORDER BY COUNT(DISTINCT order_id) DESC;
    ```
   - The percentage of sales by pizza category
    ```sql
     SELECT pizza_category, 
            CAST(((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales)) AS DECIMAL(8, 2)) AS '% of Sales'
     FROM pizza_sales
            GROUP BY pizza_category
            ORDER BY '% of Sales' DESC;
    ```
   - The percentage of sales by pizza size
   ```sql
     SELECT pizza_size, CAST(((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales)) AS DECIMAL(8, 2)) AS '% of Sales'
     FROM pizza_sales
          GROUP BY pizza_size
          ORDER BY '% of Sales' DESC;
   ```
   - The total pizzas sold per pizza category
    ```sql
     SELECT pizza_category, 
            SUM(quantity) AS 'Total Pizzas Sold'
     FROM pizza_sales
            GROUP BY pizza_category
            ORDER BY 'Total Pizzas Sold' DESC;
    ```
   - Top 5 best sellers by Revenue, total quantity, total orders
    ```sql
     SELECT TOP 5 pizza_name, 
           SUM(total_price) AS 'Top 5 in Revenue', 
           SUM(quantity) AS 'Top 5 in quantity', 
           COUNT(DISTINCT order_id) AS 'Top 5 Orders'
     FROM pizza_sales
           GROUP BY pizza_name 
           ORDER BY SUM(total_price) DESC, SUM(quantity) DESC, COUNT(DISTINCT order_id) DESC;
    ```
   - Bottom 5 sellers by Revenue
    ```sql
     SELECT TOP 5 pizza_name, 
           SUM(total_price) AS 'Bottom 5 in Revenue'
     FROM pizza_sales
           GROUP BY pizza_name 
           ORDER BY SUM(total_price) ASC;
    ```
   - Bottom 5 sellers by total quantity
    ```sql
     SELECT TOP 5 pizza_name, 
          SUM(quantity) AS 'Bottom 5 in quantity' 
     FROM pizza_sales
          GROUP BY pizza_name 
          ORDER BY SUM(quantity) ASC;

7. **Visualization and insight generation in Power BI**
   <img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/acfaf4e2-9e77-4e06-ba79-cfea3885de65" />
   <img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/04d26c31-627d-4add-bc92-4e45e245ca84" />



---

## Key Insights

- Sales show clear daily and monthly seasonality patterns
- A small group of pizzas contributes a disproportionate share of revenue
- Classic and Supreme categories dominate total sales
- Medium and Large pizzas generate the highest revenue share
- Several menu items consistently underperform across all metrics

---

## Business Recommendations

- Optimize staffing and inventory around peak demand periods
- Focus promotions on top-performing categories and sizes
- Re-evaluate or redesign underperforming pizzas
- Introduce bundled offers to increase average pizzas per order

---

## Tools & Skills

- Power BI (DAX, Data Modeling, Dashboards)
- MS SQL Server (Aggregations, Ranking, Validation)
- Power Query (M Language)
- Business KPI Design
- Data Visualization & Insight Communication

---

## Limitations & Next Steps

Limitations:
- No customer demographic data
- No cost or profitability data

Next Steps:
- Sales forecasting and demand prediction
- Profitability analysis with cost inputs
- Customer segmentation analysis

---
