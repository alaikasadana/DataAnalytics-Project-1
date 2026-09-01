-- Create Database
CREATE DATABASE zepto_sql_project;

-- Select Database
USE zepto_sql_project;


-- Create Table
CREATE TABLE zepto (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp DECIMAL(8, 2),
    discountPercent DECIMAL(5, 2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(8, 2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);


-- Rename Column If Required
ALTER TABLE zepto
CHANGE COLUMN `ï»¿sku1_id` `sku_id` INT;



-- Describe Table Structure
DESC zepto;


-- Count Number of Rows
SELECT COUNT(*)
FROM zepto;


-- Display All Data
SELECT *
FROM zepto;


-- Display First 10 Records
SELECT *
FROM zepto
LIMIT 10;


-- Check for NULL Values
SELECT *
FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL
   OR discountedSellingPrice IS NULL;


-- Find Different Product Categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;


-- Count Products In Stock vs Out of Stock
SELECT
    outOfStock,
    COUNT(sku_id) AS product_count
FROM zepto
GROUP BY outOfStock;


-- Find Product Names Present Multiple Times
SELECT
    name,
    COUNT(sku_id) AS number_of_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;


-- Data Cleaning
-- Find Products with MRP Equal to 0
SELECT *
FROM zepto
WHERE mrp = 0 OR discountedSellingPrice=0;


-- Disable Safe Update Mode
SET SQL_SAFE_UPDATES = 0;


-- Delete Products with MRP Equal to 0
DELETE FROM zepto
WHERE mrp = 0 OR discountedSellingPrice=0 ;


-- Convert MRP from Paise to Rupees
UPDATE zepto
SET mrp = mrp / 100.0 ,
discountedSellingPrice = discountedSellingPrice  /100.0;


-- Verify Updated MRP Values
SELECT mrp , discountedSellingPrice 
FROM zepto;

-- QUESTIONSS --


-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT name , mrp , discountPercent 
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;


-- Q2. What are the products with high MRP but out of stock?

SELECT DISTINCT name,mrp 
FROM zepto 
WHERE outOfStock  = "TRUE" and mrp > 300
ORDER BY mrp DESC;

-- Q3. Calculate estimated revenue for each category.

SELECT category , 
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category 
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name , mrp , discountPercent 
FROM zepto
WHERE mrp > 500 AND discountPercent < 10 
ORDER BY mrp DESC , discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category , 
AVG(discountPercent) AS avg_discount
FROM zepto 
GROUP BY category 
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name , weightInGms, discountedSellingPrice ,
ROUND(discountedSellingPrice / weightInGms , 2) AS price_per_gram
FROM zepto 
WHERE weightInGms >=100
ORDER BY price_per_gram;

-- Q7. Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT name , weightInGms ,
CASE WHEN weightInGms < 1000 THEN "low" 
     WHEN weightInGms < 5000 THEN "medium" 
     ELSE "bulk"
     END AS weight_category
FROM zepto;

-- Q8. What is the total inventory weight per category?

SELECT category ,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto 
GROUP BY category
ORDER BY total_weight;
 