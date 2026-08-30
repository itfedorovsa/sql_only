-- Уровень 1. Базовая аналитика

-- Задача 1. Продажи по месяцам
SELECT DATE_TRUNC('month', o.created_at)::DATE AS month, COUNT(DISTINCT o.id) AS orders_count, SUM(oi.quantity * oi.price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY month
ORDER BY month ASC;

-- Задача 2. Топ-5 самых продаваемых товаров
SELECT p.name AS product_name, SUM(oi.quantity) AS sold_quantity, SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON p.id = oi.product_id
JOIN orders o ON o.id = oi.order_id
WHERE o.status != 'cancelled'
GROUP BY p.name
ORDER BY sold_quantity DESC, revenue DESC, product_name ASC
LIMIT 5;

-- Задача 3. Средний чек по месяцам
WITH order_items_sum AS (
SELECT DATE_TRUNC('month', o.created_at)::DATE AS month, o.id AS order_id, SUM(oi.quantity * oi.price) AS order_sum
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY month, o.id
)
SELECT ois.month AS month, COUNT(ois.order_id) AS orders_count, ROUND(AVG(ois.order_sum), 2) AS avg_order_total
FROM order_items_sum ois
GROUP BY ois.month
ORDER BY ois.month ASC;


-- Уровень 2. Аналитика связей

-- Задача 4. Активные покупатели
SELECT u.name AS user_name, u.email, COUNT(DISTINCT o.id) AS orders_count, SUM(oi.quantity * oi.price) AS total_spent
FROM users u
JOIN orders o ON o.user_id = u.id
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY u.email, u.name
HAVING COUNT(DISTINCT o.id) >= 3 AND SUM(oi.quantity * oi.price) > 300000
ORDER BY total_spent DESC, orders_count DESC, email ASC;

-- Задача 5. Товары без продаж
-- решение через JOIN
SELECT p.id AS product_id, p.name AS product_name, p.price, p.stock
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.id
LEFT JOIN orders o ON oi.order_id = o.id AND o.status != 'cancelled'
WHERE p.is_active = TRUE
GROUP BY p.id, p.name, p.price, p.stock
HAVING COUNT(o.id) = 0
ORDER BY p.name ASC;

-- решение через NOT EXISTS
SELECT p.id AS product_id, p.name AS product_name, p.price, p.stock
FROM products p
WHERE p.is_active = TRUE AND NOT EXISTS(
SELECT 1
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
WHERE oi.product_id = p.id AND o.status != 'cancelled'
)
ORDER BY p.name ASC;

-- Задача 6. Выручка по категориям
SELECT c.name AS category_name, COUNT(DISTINCT oi.product_id) AS products_sold, SUM(oi.quantity) AS sold_quantity, SUM(oi.quantity * oi.price) AS revenue
FROM categories c
JOIN product_categories pc ON pc.category_id = c.id
JOIN order_items oi ON oi.product_id = pc.product_id
JOIN orders o ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY c.name
HAVING SUM(oi.quantity * oi.price) > 500000
ORDER BY revenue DESC, category_name ASC;


-- Уровень 3. Многоступенчатые запросы

-- Задача 7. Топ-5 городов по продажам
WITH orders_sum AS (
SELECT a.city AS city, u.id AS user_id, o.id AS order_id, SUM(oi.quantity * oi.price) AS sum_order_total
FROM users u
JOIN orders o ON o.user_id = u.id
JOIN addresses a ON a.id = o.address_id
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY a.city, u.id, o.id
)
SELECT os.city, COUNT(DISTINCT os.user_id) AS customers_count, COUNT(os.order_id) AS orders_count, SUM(os.sum_order_total) AS revenue, ROUND(AVG(os.sum_order_total), 2) AS avg_order_total
FROM orders_sum os
GROUP BY os.city
ORDER BY revenue DESC, orders_count DESC, os.city ASC
LIMIT 5;

-- Задача 8. Эффективность способов оплаты
WITH payments_info AS (
SELECT
p.p_type AS payment_method,
p.order_id AS order_id,
p.status
FROM payments p
),
aggregated AS (
SELECT
payment_method,
COUNT(order_id) AS attempts_count,
COUNT(CASE WHEN status = 'paid' THEN 1 END) AS successful_count,
COUNT(CASE WHEN status = 'failed' THEN 1 END) AS failed_count
FROM payments_info
GROUP BY payment_method
)
SELECT
payment_method,
attempts_count,
successful_count,
failed_count,
ROUND((successful_count::NUMERIC / NULLIF(attempts_count, 0)) * 100, 2) AS success_rate
FROM aggregated;

-- Задача 9. Товары для пополнения склада
WITH stock20_products AS (
SELECT id, name AS product_name, stock
FROM products
WHERE is_active = TRUE AND stock < 20
)
SELECT
name AS product_name,
stock,
SUM(oi.quantity) AS sold_quantity,
COUNT(DISTINCT o.id) AS orders_count,
SUM(oi.quantity * oi.price) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id = p.id
JOIN orders o ON oi.order_id = o.id
WHERE stock < 20 AND is_active = TRUE AND o.status != 'cancelled'
GROUP BY product_name, stock
HAVING SUM(oi.quantity) >= 5 AND COUNT(DISTINCT o.id) >= 2
ORDER BY stock ASC, sold_quantity DESC, product_name ASC;


-- Уровень 4. Сложные запросы и оконные функции

-- Задача 10. Самый дорогой заказ каждого пользователя
WITH orders_sum AS (
SELECT
u.email,
o.id AS order_id,
SUM(oi.quantity * oi.price) AS order_total,
o.created_at
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY u.email, o.id, o.created_at
),
aggregate AS (
SELECT
os.email,
os.order_id,
ROW_NUMBER() OVER (PARTITION BY os.email ORDER BY os.order_total DESC, os.created_at DESC, os.order_id DESC) AS rn,
os.order_total AS order_total,
ROUND(AVG(os.order_total) OVER (PARTITION BY os.email), 2) AS user_avg_order_total,
os.created_at
FROM orders_sum os
)
SELECT
a.email,
a.order_id,
a.order_total,
a.user_avg_order_total,
order_total - user_avg_order_total AS difference_from_avg,
a.created_at
FROM aggregate a
WHERE a.rn = 1
ORDER BY a.order_total DESC, a.email ASC;

-- Задача 11. Динамика выручки по месяцам
WITH montly_revenue AS (
SELECT
DATE_TRUNC('month', o.created_at)::DATE AS month,
COUNT(DISTINCT o.id) AS orders_count,
SUM(oi.quantity * oi.price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY month
),
with_lag AS (
SELECT
month,
orders_count,
revenue,
LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue
FROM montly_revenue
)
SELECT
month,
orders_count,
revenue,
previous_month_revenue,
(revenue - previous_month_revenue) AS revenue_difference,
ROUND((revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0) * 100, 2) AS growth_percent
FROM with_lag
ORDER BY month ASC;

-- Задача 12. Нарастающая выручка
WITH daily_revenue AS (
SELECT
DATE(o.created_at) AS date,
COUNT(DISTINCT o.id) AS orders_count,
SUM(oi.quantity * oi.price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.status != 'cancelled'
GROUP BY date
)
SELECT
date,
orders_count,
revenue AS daily_revenue,
SUM(revenue) OVER(ORDER BY date ASC) AS running_revenue,
ROUND(revenue / NULLIF(SUM(revenue) OVER(), 0) * 100, 2) AS revenue_share
FROM daily_revenue
ORDER BY date ASC;

-- Финальное задание

-- Задача 13. Сводный отчет по пользователям
WITH orders_by_users AS (
SELECT
u.name AS user_name,
u.email,
o.id AS order_id,
SUM(oi.quantity * oi.price) AS order_total,
o.created_at,
o.status
FROM users u
LEFT JOIN orders o ON o.user_id = u.id AND o.status != 'cancelled'
LEFT JOIN order_items oi ON oi.order_id = o.id
GROUP BY u.email, u.name, o.created_at, o.status, o.id
),
aggregate_users AS (
SELECT
user_name,
email,
COUNT(DISTINCT order_id) AS orders_count,
COALESCE(SUM(order_total), 0) AS total_spent,
ROUND(AVG(order_total), 2) AS avg_order_value,
MAX(created_at)::DATE AS last_order_date
FROM orders_by_users
GROUP BY email, user_name
),
categories_by_users AS (
SELECT
u.email,
c.name,
SUM(oi.quantity * oi.price) AS order_total
FROM users u
LEFT JOIN orders o ON o.user_id = u.id AND o.status != 'cancelled'
LEFT JOIN order_items oi ON oi.order_id = o.id
JOIN product_categories pc ON pc.product_id = oi.product_id
JOIN categories c ON c.id = pc.category_id
GROUP BY u.email, c.name
ORDER BY email ASC, order_total DESC
),
aggregate_categories AS (
SELECT
email AS agg_email,
name,
RANK() OVER(PARTITION BY email ORDER BY order_total DESC, name ASC) AS rn
FROM categories_by_users
)
SELECT
user_name,
email,
orders_count,
total_spent,
avg_order_value,
last_order_date,
(SELECT name FROM aggregate_categories WHERE agg_email = aggregate_users.email AND rn = 1 LIMIT 1) AS favorite_category,
RANK() OVER(ORDER BY total_spent DESC) AS rank_by_total_spent
FROM aggregate_users
ORDER BY rank_by_total_spent ASC, email ASC;