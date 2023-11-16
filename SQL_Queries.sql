CREATE DATABASE IF NOT EXISTS Walmart_Sales_Analysis;

CREATE TABLE IF NOT EXISTS sales(
	invoce_id		VARCHAR(30) NOT NULL PRIMARY KEY,
    branch			VARCHAR(5) NOT NULL,
    city 			VARCHAR(30) NOT NULL,
    customer_type	VARCHAR(30) NOT NULL,
    gender 			VARCHAR(30) NOT NULL,
    product_line	VARCHAR(100) NOT NULL,
    unit_price 		DECIMAL(10,2) NOT NULL,
    quantity 		INT NOT NULL,
    tax_pct 		FLOAT(6,4) NOT NULL,
    total 			DECIMAL(12, 4) NOT NULL,
    date 			DATETIME NOT NULL,
    time 			TIME NOT NULL,
    payment 		VARCHAR(15) NOT NULL,
    cogs 			DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income 	DECIMAL(12, 4),
    rating 			FLOAT(2, 1)
);

-- ---------------------------------------------------------------------
-- -------------------------Feature Engineering-------------------------

-- 1. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. 
--    This will help answer the question on which part of the day most sales are made.

-- The Architecture of the Column:

SELECT time, 
	  (CASE  WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			 WHEN time BETWEEN '12:00:01' AND '17:00:00' THEN 'Afternoon'
			 ELSE 'Evening' 
	   END) AS time_of_day
FROM sales;

-- Creating A New Column:
ALTER TABLE sales
ADD COLUMN time_of_day 	VARCHAR(20);

-- For this to work turn off safe mode for update
-- Workbench Preferences > SQL Editor > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server
UPDATE sales
SET time_of_day = 
		  (CASE  WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
				 WHEN time BETWEEN '12:00:01' AND '17:00:00' THEN 'Afternoon'
				 ELSE 'Evening' 
		   END); 
           
-- 2. Add a new column called `day_name` to the data that contains the name of the day 
-- on which the transaction took place. 
-- (Monday, Tuesday, Wednesday, Thursday, or Friday)
-- This will help determine which day of the week each branch is busiest.

ALTER TABLE sales ADD COLUMN day_name VARCHAR(20);

UPDATE sales 
SET day_name = DAYNAME(date);

-- 3. Add a new column named 'month_name' for the transaction's month 
--    and determine the month with the highest sales and profit.

ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

UPDATE sales 
SET month_name = MONTHNAME(date);

-- ---------------------------------------------------------------------------------
-- -------------------------Exploratory Data Analysis (EDA)-------------------------

-- Generic Questions

-- 1. How many unique cities does the data have?

SELECT COUNT( DISTINCT city ) FROM sales;


-- 2. In which city is each branch?

SELECT DISTINCT branch, city FROM sales;

-- Product

-- 1. How many unique product lines does the data have?

SELECT DISTINCT product_line FROM sales;

SELECT COUNT( DISTINCT product_line ) FROM sales;

-- 2. What is the most common payment method?

SELECT payment, COUNT(*) AS payment_method_frequency
FROM sales
GROUP BY payment
ORDER BY payment_method_frequency DESC;

-- 3. What is the most selling product line?

SELECT product_line, SUM(quantity) AS product_line_frequency
FROM sales
GROUP BY product_line
ORDER BY product_line_frequency DESC;

-- 4. What is the total revenue by month?

SELECT  Month_name, SUM(total) AS total_revenue
FROM sales
GROUP BY Month_name
ORDER BY total_revenue DESC;
 
-- 5. What month had the largest COGS (Cost of Goods)?

SELECT  Month_name, SUM(cogs) AS costs
FROM sales
GROUP BY Month_name
ORDER BY costs DESC;

-- 6. What product line had the largest revenue?

SELECT product_line, SUM(total) AS Revenue
FROM sales
GROUP BY product_line
ORDER BY Revenue DESC;

-- 7. What is the city with the largest revenue?

SELECT branch, city, SUM(total) AS Revenue
FROM sales
GROUP BY branch, city
ORDER BY Revenue DESC; 

-- 8. What product line had the largest VAT (Average Tax)?

SELECT product_line, AVG(tax_pct) As VAT
FROM sales
GROUP BY product_line
ORDER BY VAT DESC;

-- 9. Fetch each product line and add a column to those product lines showing "Good", and "Bad".
--    Good if it's greater than the average sales.

SELECT  AVG(quantity) AS average_amount_sold FROM sales;
-- '5.4995'

SELECT product_line, 
CASE WHEN AVG(quantity) >= 5.4995 THEN 'GOOD' ELSE 'BAD' END AS Status
FROM sales
GROUP BY product_line;

SELECT product_line, AVG(quantity),

CASE WHEN AVG(quantity) >= (SELECT AVG(quantity) FROM sales) THEN 'Above_Average' 
ELSE 'Below_Average' END AS Product_Status

FROM sales
GROUP BY product_line;

-- 10. Which branch sold more products than average product sold?

SELECT branch, AVG(quantity) AS Average_Amount_Sold,

CASE WHEN AVG(quantity) >= (SELECT AVG(quantity) FROM sales) THEN 'Above_Average'
ELSE 'Below_Average' END AS Branch_Status

FROM sales
GROUP BY branch;
ORDER BY Average_Amount_Sold DESC;

-- 11.What is the most common product line by gender?

SELECT gender, product_line, SUM(quantity) As amount_sold
FROM sales
GROUP BY gender, product_line
ORDER BY amount_sold DESC;

-- 12. What is the average rating of each product line?

SELECT product_line, ROUND(AVG(rating), 2) AS Average_Rating
FROM sales
GROUP BY product_line
order by rating DESC;



-- --------------------------------------------------------------------
-- -----------------------------Sales----------------------------------

-- 1. Number of sales made at each time of the day per weekday:
 
SELECT day_name, SUM(quantity) number_of_sales
FROM sales
GROUP BY day_name
ORDER BY number_of_sales DESC;

-- 2. Which of the customer types brings the most revenue?

SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- 3. Which city has the largest tax percentage/ VAT (**Value Added Tax**)?

SELECT city, ROUND(AVG(tax_pct), 2) Average_Tax
FROM sales
GROUP BY city
ORDER BY Average_Tax DESC;

-- 4. Which customer type pays the most in VAT?

SELECT customer_type, ROUND(AVG(tax_pct), 2) VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- -----------------------------------------------------------------------
-- -----------------------------Customers----------------------------------

-- 1. How many unique customer types does the data have?

SELECT DISTINCT customer_type 
FROM sales;

-- 2. How many unique payment methods does the data have?

SELECT DISTINCT payment 
FROM sales;

-- 3. What is the most common customer type?

SELECT customer_type, COUNT(*) no_customers 
FROM sales
GROUP BY customer_type
ORDER BY no_customers DESC;

-- 4. Which customer type buys the most?

SELECT customer_type, COUNT(*) no_purchases 
FROM sales
GROUP BY customer_type
ORDER BY no_purchases DESC;

-- 5. What is the gender of most of the customers?

SELECT gender, COUNT(*) no_customers 
FROM sales
GROUP BY gender
ORDER BY no_customers DESC;

-- 6. What is the gender distribution per branch?

SELECT branch, gender, COUNT(*) no_customers
FROM sales
GROUP BY branch, gender;

-- 7. Which time of the day do customers give the most ratings?

SELECT time_of_day, AVG(rating) Average_Rating
FROM sales 
GROUP BY time_of_day
ORDER BY Average_Rating DESC;

-- 8. Which time of the day do customers give the most ratings (given baranch=A)?

SELECT time_of_day, AVG(rating) Average_Rating_branch_A
FROM sales 
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY Average_Rating_branch_A DESC;

-- 9. Which day of the week has the best avg ratings for each branch?

SELECT branch, day_name, AVG(rating) Rating
FROM sales
GROUP BY branch, day_name
ORDER BY Rating DESC;
