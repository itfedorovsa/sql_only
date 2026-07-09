-- для каждого статуса заказа вывести количество заказов
SELECT o.status, count(*) AS orders_count
FROM orders AS o
GROUP BY o.status;

-- для каждого пользователя вывести общую сумму всех его заказов
SELECT u.id AS user_id, u.name AS user_name, sum(oi.quantity * oi.unit_price) AS total_spent
FROM users AS u
JOIN orders AS o on u.id = o.user_id
JOIN order_items AS oi on oi.order_id = o.id
GROUP BY u.id, u.name;

-- для каждого товара вывести:
-- сколько раз этот товар встретился в строках заказа
-- сколько единиц товара было продано суммарно
SELECT p.id AS product_id, p.name AS p_name, count(oi.product_id) AS order_items_count, sum(oi.quantity) AS total_quantity
FROM products AS p
JOIN order_items AS oi on oi.product_id = p.id
GROUP BY p.id, p.name;

-- для каждого заказа вывести: order_id, количество строк в заказе, итоговую сумму заказа
SELECT o.id AS order_id, COUNT(oi.order_id) AS items_count, SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders AS o
JOIN order_items AS oi ON oi.order_id = o.id
GROUP BY o.id;

-- для каждого пользователя и для каждого статуса его заказов вывести количество таких заказов
SELECT u.id AS user_id, u.name AS user_name, o.status, COUNT(o.user_id) AS orders_count
FROM users AS u
JOIN orders AS o ON u.id = o.user_id
GROUP BY u.id, u.name, o.status;

-- вывести минимальную, максимальную и среднюю цену продажи по каждому товару на основании order_items
SELECT
    p.id AS product_id,
    p.name AS product_name,
    MIN(oi.unit_price) AS min_unit_price,
    MAX(oi.unit_price) AS max_unit_price,
    AVG(oi.unit_price) AS avg_unit_price
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.id, p.name;

-- вывести пользователей и количество их заказов, включая пользователей, у которых заказов нет
SELECT u.id AS user_id, u.name AS user_name, COUNT(o.user_id) AS orders_count
FROM users AS u
LEFT JOIN orders AS o ON u.id = o.user_id
GROUP BY u.id, u.name;


