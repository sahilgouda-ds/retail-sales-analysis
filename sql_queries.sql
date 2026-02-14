CREATE DATABASE supermarket_db ; 
use supermarket_db;
DESCRIBE superstore ; 
SELECT*FROM SUPERSTORE ; 
Select `order date` from superstore limit 5 ;

#converting order date from text to date 
UPDATE SUPERSTORE 
set `order date` = str_to_date(`order date` , '%d/%m/%Y');

UPDATE SUPERSTORE 
SET `SHIP DATE` = str_to_date( `SHIP DATE` , '%d/%m/%Y');

ALTER table superstore 
modify `order date`  DATE ;

ALTER table superstore 
modify `ship date` DATE ; 

-- =========================
-- 1. Total Sales
-- =========================
SELECT SUM(SALES) AS TOTAL_SALES 
FROM SUPERSTORE ; 

-- =========================
-- 2. Category Wise Sales
-- =========================
SELECT CATEGORY , 
SUM(SALES) AS TOTAL_SALES
FROM SUPERSTORE
GROUP BY CATEGORY 
ORDER BY TOTAL_SALES DESC ; 

-- =========================
-- 3. Region Wise Sales
-- =========================
SELECT REGION ,
SUM(SALES) AS TOTAL_SALES 
FROM SUPERSTORE 
GROUP BY REGION 
ORDER BY TOTAL_SALES DESC ; 


-- =========================
-- 3. MONTHLY SALES TREND 
-- =========================
SELECT YEAR(`Order Date`) AS Year,
       MONTH(`Order Date`) AS Month,
       SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- =========================
-- 3. SHIPPING DELAY 
-- =========================
SELECT (`ship mode`) , 
AVG(DATEDIFF(`Ship Date`, `Order Date`)) AS Avg_Delivery_Days
from superstore 
group by `ship mode` ;

-- =========================
-- 3. TOP 10 PRODUCTS 
-- =========================
SELECT `PRODUCT NAME` , 
SUM(SALES) AS TOTAL_SALES 
FROM SUPERSTORE 
GROUP BY `PRODUCT NAME`
ORDER BY TOTAL_SALES DESC LIMIT 10 ; 

 -- =========================
-- SEGMENT ANALYSIS 
-- =========================
SELECT SEGMENT , 
SUM(SALES) AS TOTAL_SALES 
FROM SUPERSTORE 
GROUP BY SEGMENT 
ORDER BY TOTAL_SALES DESC ;

-- =========================
-- HIGHEST SELLING SUB CATEGORY 
-- =========================
SELECT `Sub-Category`,
	SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC;

CREATE TABLE customers AS
SELECT DISTINCT 
    `Customer ID`,
    `Customer Name`,
    Segment,
    Country,
    City,
    State,
    Region
FROM superstore;

CREATE TABLE orders AS
SELECT 
    `Order ID`,
    `Order Date`,
    `Ship Date`,
    `Ship Mode`,
    `Customer ID`,
    Sales,
    Category,
    `Sub-Category`,
    `Product Name`
FROM superstore;

-- Sales by Customer Segment Using JOIN
SELECT c.Segment,
       SUM(o.Sales) AS Total_Sales
FROM orders o
JOIN customers c
ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

-- Top Customers Using JOIN
SELECT c.`Customer Name`,
       SUM(o.Sales) AS Total_Sales
FROM orders o
JOIN customers c
ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer Name`
ORDER BY Total_Sales DESC
LIMIT 5;

 