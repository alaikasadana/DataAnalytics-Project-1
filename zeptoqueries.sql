create database zepto_sql_project;
use zepto_sql_project;

CREATE TABLE zepto (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp DECIMAL(8,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(8,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

ALTER TABLE zepto
CHANGE COLUMN `ï»¿sku_id` `sku_id` INT;

desc zepto;


-- count of rows 
select count(*) from zepto;

-- sample data
select * from zepto;

select * from zepto
limit 10;

-- null values
select * from zepto
where name is NULL
or 
category is NULL
or 
mrp is NULL
or 
discountPercent is NULL
or 

weightInGms is NULL
or 
availableQuantity is NULL
or 
outOfStock is NULL
or 
quantity is NULL;


-- diffrent product categroies
select distinct category 
from zepto
order by category;

-- products in stock vs outofstock
select outofstock , count(sku_id)
from zepto 
group by outofstock;


-- product names present multiple times
select name , count(sku_id) as " Number of SKUs"
from zepto 
group by name 
having count(sku_id) >1
order by count(sku_id) desc;

-- data cleaning 

-- products with price = 0
select * from zepto where mrp = 0 ;

SET SQL_SAFE_UPDATES = 0;

delete from zepto where mrp = 0 ;


