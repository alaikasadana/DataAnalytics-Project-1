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
CHANGE COLUMN `ï»¿sku_id` `sku_id` INT;


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
   OR quantity IS NULL;


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
WHERE mrp = 0;


-- Disable Safe Update Mode
SET SQL_SAFE_UPDATES = 0;


-- Delete Products with MRP Equal to 0
DELETE FROM zepto
WHERE mrp = 0;


-- Convert MRP from Paise to Rupees
UPDATE zepto
SET mrp = mrp / 100.0;


-- Verify Updated MRP Values
SELECT mrp
FROM zepto;