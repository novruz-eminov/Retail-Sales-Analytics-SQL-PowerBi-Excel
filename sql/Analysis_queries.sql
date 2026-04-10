-- Monthly Revenue Trend
SELECT YEAR(order_date) AS year,
       MONTH(order_date) AS month,
       SUM(total_price) AS revenue
FROM fact_sales
GROUP BY YEAR(order_date),
         MONTH(order_date)
ORDER BY year,month;

-- Top 10 products by revenue
SELECT TOP 10
  p.description,
  SUM(f.total_price) AS revenue
FROM fact_sales f
INNER JOIN dim_products p
ON f.product_id = p.product_id
GROUP BY p.description
ORDER BY revenue DESC;

-- Top customers / CLV
SELECT TOP 10
   customer_id,
   SUM(total_price) AS life_time_value
FROM fact_sales
GROUP BY customer_id
ORDER BY life_time_value DESC

-- Revenue by country
SELECT c.country,
       SUM(f.total_price) AS revenue
FROM fact_sales f
INNER JOIN dim_customers c
      ON f.customer_id = c.customer_id
GROUP BY c.country
ORDER BY revenue DESC

-- Running total
WITH daily_sales AS (
               SELECT CAST(order_date AS DATE) AS sales_dates,
                    SUM(total_price) AS daily_revenue
                FROM fact_sales
                GROUP BY  CAST(order_date AS DATE)
 )
 SELECT sales_dates,
        daily_revenue,
        SUM(daily_revenue) OVER(ORDER BY sales_dates) AS running_total
 FROM daily_sales

 -- Monthy Grows %
 WITH monthly_sales AS(
         SELECT YEAR(order_date) AS year,
                MONTH(order_date) AS month,
                SUM(total_price) AS revenue
         FROM fact_sales
         GROUP BY YEAR(order_date),
                MONTH(order_date)
 )
SELECT year,month,
       LAG(revenue) OVER(ORDER BY year,month) AS previous_month,
       (revenue -  LAG(revenue) OVER(ORDER BY year,month))*100/ LAG(revenue) OVER(ORDER BY year,month) AS growth_pcn
FROM monthly_sales
ORDER BY year,month;
