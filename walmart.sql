--DROP TABLE walmart;

--show all the data
SELECT * FROM walmart;

--count how many entries from this table
SELECT COUNT(*) FROM walmart;

--*: all rows
--COUNT(*): counts how many trascations use each payment method
SELECT
	payment_method,
	COUNT(*)
FROM walmart
GROUP BY payment_method;

--DISTINCT: only unique values are counted
--count how many unique values in branch -> 100 branches
SELECT
	COUNT(DISTINCT branch)
FROM walmart;

SELECT MIN(quantity) FROM walmart;

--Business Problems
--Q1. Analyze Payment Methods and Sales
-- ● Question: What are the different payment methods, and how many transactions and items were sold with each method?
-- ● Purpose: This helps understand customer preferences for payment methods, aiding in payment optimization strategies.
SELECT 
	payment_method, 
	COUNT(*) AS number_payments, --count how many rows (or transactions) use that payment method.
	SUM(quantity) AS number_qty_sold --adds up the values in the quantity column for (each payment method )
FROM walmart
GROUP BY payment_method --by default the whole dataset is a group
ORDER BY number_payments DESC; --the most popular payment method will appear first

-- Q2. Identify the Highest-Rated Category in Each Branch
-- ● Question: Which category received the highest average rating in each branch?
-- ● Purpose: This allows Walmart to recognize and promote popular categories in specific
-- branches, enhancing customer satisfaction and branch-specific marketing.
SELECT *
FROM
(
	SELECT
		branch,
		category,
		AVG(rating) AS avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
	FROM walmart
	GROUP BY 1, 2
)
WHERE rank = 1



