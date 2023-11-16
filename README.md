# Walmart Sales Data Analysis

This project analyzes sales transaction data from Walmart stores to gain insights into performance of products, branches and customer segments. The dataset contains over 1000 transactions across 3 stores located in different cities of Myanmar.

## Dataset

The data is from Kaggle's [Walmart Recruiting - Store Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). 

The dataset contains over 1000 sales transactions from 3 Walmart stores located in different cities in Myanmar. It has 16 columns capturing details like invoice, branch, date, product, price, quantity, payment etc.

The data is stored in a MySQL database with relevant structure for analysis. The database and CSV files containing raw data are also included.


## Objectives

The goals are to:

- Understand top selling products and branches
- Identify sales trends over time and how they are impacted  
- Segment customers and analyze their purchasing behavior
- Recommend strategies to optimize performance

## Approach

1. Data preprocessing to clean, standardize and engineer features
2. Exploratory data analysis using SQL to investigate objectives  
3. Calculate key metrics like gross margins
4. Interpret results, draw insights and conclusions

## Analysis Sections

In-depth analysis is conducted around:

- Products 
- Sales
- Customers
- Location performance
- Financial calculations

Over 60 business questions are answered on relationships, anomalies and opportunities.

## Feature Engineering

Several features are engineered to enhance the analysis:

  1. Time of Day: A new column, time_of_day, is added to categorize sales into Morning, Afternoon, and Evening.
  
  2.Day Name: Another column, day_name, is added to capture the day of the week when each transaction occurs.
  
  3. Month Name: A column, month_name, is introduced to identify the month of each transaction.

## Exploratory Data Analysis (EDA)

EDA is conducted to answer generic and product-specific questions, including:

* Unique cities in the dataset.
* Branches and their corresponding cities.
* Most common payment methods.
* Most selling product lines.
* Total revenue and costs by month, product line, and city.
* VAT analysis.
* Product and branch performance relative to average sales.


## Sales Analysis
This section explores sales-related questions, such as:

  1. Number of Sales by Time of Day per Weekday: Identifies the number of sales made at each time of the day per weekday.
  
  2. Revenue by Customer Type: Determines which customer type brings the most revenue.
  
  3. City with the Largest Tax Percentage/VAT: Identifies the city with the highest tax percentage.
  
  4. Customer Type Paying the Most in VAT: Determines which customer type pays the most in Value Added Tax.

## Customer Analysis

This part analyzes customer-related aspects:

  1. Unique Customer Types and Payment Methods: Counts the number of unique customer types and payment methods.
  
  2. Most Common Customer Type and Gender Distribution: Identifies the most common customer type and explores the gender distribution.
  
  3. Purchases by Customer Type and Gender: Analyzes the number of purchases made by each customer type and gender.
  
  4. Ratings Analysis: Investigates the relationship between the time of day and customer ratings.


## Conclusion

The project concludes by providing comprehensive insights into various aspects of Walmart sales, offering valuable information for strategic decision-making.
Key takeaways relate to top products, impacting factors, areas for improvement, optimizing strategies and next steps.

Please note that this is a brief overview, and further details can be found in the SQL queries provided in the project. 
