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
- Total Orders
- Total Pizzas Sold
- Average Order Value (AOV)
- Average Pizzas per Order

---

## Methodology

1. Data cleaning and transformation using Power Query (M Language)
2. Date feature engineering (day, month, quarter)
3. Metric calculation using DAX in Power BI
4. SQL validation and aggregation using Microsoft SQL Server
5. Visualization and insight generation in Power BI

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
- SQL Server (Aggregations, Ranking, Validation)
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

========================================
FILE: .gitignore
========================================

# OS files
.DS_Store
Thumbs.db

# Power BI temp files
*.pbix~
*.pbit~

# Python (if extended later)
__pycache__/
*.pyc

# Excel temp files
~$*.xlsx

========================================
FILE: sql/pizza_sales_analysis.sql
========================================

-- Total Revenue
SELECT 
    SUM(total_price) AS total_revenue
FROM pizza_sales;

-- Total Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- Total Pizzas Sold
SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- Average Order Value
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT 
    SUM(quantity) / COUNT(DISTINCT order_id) AS avg_pizzas_per_order
FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT 
    CAST(order_date AS DATE) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day;

-- Monthly Trend for Total Orders
SELECT 
    DATENAME(MONTH, order_date) AS month_name,
    MONTH(order_date) AS month_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date), MONTH(order_date)
ORDER BY month_number;

-- Sales by Pizza Category
SELECT 
    pizza_category,
    SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY revenue DESC;

-- Sales by Pizza Size
SELECT 
    pizza_size,
    SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue DESC;

-- Top 5 Best Sellers by Revenue
SELECT TOP 5
    pizza_name,
    SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC;

-- Bottom 5 Worst Sellers by Revenue
SELECT TOP 5
    pizza_name,
    SUM(total_price) AS revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue ASC;

========================================
FILE: powerbi/dax_measures.md
========================================

# Power BI DAX Measures

Total Revenue =
SUM(pizza_sales[total_price])

Total Orders =
DISTINCTCOUNT(pizza_sales[order_id])

Total Pizzas Sold =
SUM(pizza_sales[quantity])

Average Order Value =
[Total Revenue] / [Total Orders]

Average Pizzas Per Order =
[Total Pizzas Sold] / [Total Orders]

========================================
FILE: powerbi/power_query_m_language.txt
========================================

let
    Source = Csv.Document(
        File.Contents("pizza_sales.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"order_date", type date},
            {"order_time", type time},
            {"quantity", Int64.Type},
            {"unit_price", type number},
            {"total_price", type number}
        }
    ),
    AddedDayNumber = Table.AddColumn(
        ChangedTypes,
        "Day Number",
        each Date.Day([order_date]),
        Int64.Type
    ),
    AddedMonthName = Table.AddColumn(
        AddedDayNumber,
        "Month Name",
        each Date.MonthName([order_date]),
        type text
    ),
    AddedMonthNumber = Table.AddColumn(
        AddedMonthName,
        "Month Number",
        each Date.Month([order_date]),
        Int64.Type
    ),
    AddedYearQuarter = Table.AddColumn(
        AddedMonthNumber,
        "Year Quarter",
        each "Q" & Text.From(Date.QuarterOfYear([order_date])) & "-" & Text.From(Date.Year([order_date])),
        type text
    )
in
    AddedYearQuarter

========================================
FILE: data/data_notes.md
========================================

- Dataset is transactional at order-item level
- Multiple rows may exist per order_id
- Revenue calculated as quantity * unit_price
- No missing values observed in critical fields
- Dataset suitable for aggregation-based analysis and BI reporting

========================================
END OF PROJECT
========================================
