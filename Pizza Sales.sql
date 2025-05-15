create database pizza;
use pizza;
# A. KPI’s
# total revenue
SELECT SUM(total_price) AS Total_Revenue FROM `pizza delevari`;

# Average Order Value
SELECT 
    SUM(total_price) / COUNT(*) AS Average_Order_Value
FROM 
    `pizza delevari`;

# Total Pizzas Sold

SELECT 
    SUM(quantity) AS Total_Pizzas_Sold
FROM 
    `pizza delevari`;

#Total Orders
DESCRIBE `pizza delevari`;
SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
    `pizza delevari`;

# Average Pizzas Per Order
SELECT 
    SUM(quantity) / COUNT(DISTINCT order_id) AS Avg_Pizzas_Per_Order
FROM 
    `pizza delevari`;
    
# Daily Trend for Total Orders

SELECT 
    order_day,
    total_orders
FROM (
    SELECT 
        DAYNAME(order_date) AS order_day,
        COUNT(DISTINCT order_id) AS total_orders
    FROM 
        `pizza delevari`
    GROUP BY 
        DAYNAME(order_date)
) AS daily_summary
ORDER BY 
    FIELD(order_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
LIMIT 0, 500;

# Hourly Trend for Orders
SELECT 
    HOUR(order_date) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    `pizza delevari`
GROUP BY 
    order_hour
ORDER BY 
    order_hour;
# % of Sales by Pizza Category

SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM `pizza delevari`) AS DECIMAL(10,2)) AS pct_of_sales
FROM 
    `pizza delevari`
GROUP BY 
    pizza_category;

# % % of Sales by Pizza Size
SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM `pizza delevari`) AS DECIMAL(10,2)) AS pct_of_sales
FROM 
    `pizza delevari`
GROUP BY 
    pizza_size
ORDER BY 
    total_revenue DESC;
    
# Total Pizzas Sold by Pizza Category

SELECT 
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM 
    `pizza delevari`
GROUP BY 
    pizza_category
ORDER BY 
    total_pizzas_sold DESC;
# Top 5 Best Sellers by Total Pizzas Sold
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM 
    `pizza delevari`
GROUP BY 
    pizza_name
ORDER BY 
    total_pizzas_sold DESC
LIMIT 5;

# Bottom 5 Best Sellers by Total Pizzas Sold
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM 
    `pizza delevari`
GROUP BY 
    pizza_name
ORDER BY 
    total_pizzas_sold ASC
LIMIT 5;

# 
SELECT 
    order_day,
    total_orders
FROM (
    SELECT 
        DAYNAME(order_date) AS order_day,
        COUNT(DISTINCT order_id) AS total_orders
    FROM 
        `pizza delevari`
    WHERE 
        MONTH(order_date) = 1
    GROUP BY 
        DAYNAME(order_date)
) AS sub
ORDER BY 
    FIELD(order_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')
LIMIT 0, 500;










 
