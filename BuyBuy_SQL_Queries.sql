-- this is shaki's work'

SELECT *
FROM sales_data

ALTER TABLE sales_data
ADD profit NUMERIC(20, 4) 
GENERATED ALWAYS AS (profit) STORED;

---Total profit made by BuyBuy from 1Q11 to 4Q16
SELECT SUM(profit) AS profit
FROM sales_data;

---Total profit made by BuyBuy in Q2 of every year from 2011 to 2016
SELECT 
	CASE
		WHEN sd.sales_date BETWEEN '2011-04-01' And '2011-06-30' THEN '2Q11'
		WHEN sd.sales_date BETWEEN '2012-04-01' And '2012-06-30' THEN '2Q12'
		WHEN sd.sales_date BETWEEN '2013-04-01' And '2013-06-30' THEN '2Q13'
		WHEN sd.sales_date BETWEEN '2014-04-01' And '2014-06-30' THEN '2Q14'
		WHEN sd.sales_date BETWEEN '2015-04-01' And '2015-06-30' THEN '2Q15'
		WHEN sd.sales_date BETWEEN '2016-04-01' And '2016-06-30' THEN '2Q16'
	ELSE 'Others'
	END AS Quarter,
	SUM(profit) Profit
FROM sales_data sd
GROUP BY Quarter
ORDER BY Quarter;

---Annual profit made by BuyBuy from the year 2011 to 2016
SELECT sales_year, SUM(profit) AS Annual_profit
FROM sales_data
GROUP BY sales_year
ORDER BY sales_year;

Region-Profit Analysis
---SELECT *
FROM sales_data;

---Write 2 queries that return the countries where BuyBuy has made the most profit and also the least profit of all-time. Your query must display both results on the same output.
SELECT cus_country, MAX(profit) AS max_profit, MIN(profit) AS min_profit
FROM sales_data
GROUP BY cus_country;

---Top-10 most profitable countries for BuyBuy sales operations from 2011 to 2016
SELECT cus_country AS most_profitable_country, profit, sales_year
FROM sales_data
GROUP BY cus_country, profit, sales_year
ORDER BY profit DESC
LIMIT 10;

---Top-10 least profitable countries for BuyBuy sales operations
SELECT cus_country AS least_profitable_country, profit, sales_year
FROM sales_data
GROUP BY cus_country, profit, sales_year
ORDER BY profit ASC
LIMIT 10;
 
Product-Revenue Analysis
---Rank all product categories sold by Buybuy, from least amount to the most amount of all-time revenue generated
SELECT prod_category, SUM(revenue) AS Revenue
FROM sales_data
GROUP BY prod_category
ORDER BY Revenue ASC;

---Top-2 product categories offered by Buybuy with an all-time high number of units sold
SELECT prod_category, SUM(ord_quantity) AS Units_sold
FROM sales_data
GROUP BY prod_category
ORDER BY Units_sold  DESC
LIMIT 2;

---Top 10 highest-grossing products sold by BuyBuy based on all-time profits
SELECT product, profit 
FROM sales_data
GROUP BY product, profit
ORDER BY profit DESC
LIMIT 10;




