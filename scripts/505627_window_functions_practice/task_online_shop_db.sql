WITH daily_sales AS (
SELECT
DATE(o.created_at) AS sale_date,
SUM(oi.unit_price * oi.quantity) AS sales_amount
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY DATE(o.created_at)
)
SELECT
sale_date,
sales_amount,
LAG(sales_amount) OVER(ORDER BY sale_date) AS previous_day_sales,
LEAD(sales_amount) OVER(ORDER BY sale_date) AS next_day_sales,
sales_amount - LAG(sales_amount) OVER(ORDER BY sale_date) AS sales_diff,
SUM(sales_amount) OVER(ORDER BY sale_date) AS running_total,
AVG(sales_amount) OVER(ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_last_three_days
FROM daily_sales
ORDER BY sale_date;