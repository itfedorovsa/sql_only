-- вывести статусы заказов, по которым количество заказов не меньше 3
SELECT o.status, COUNT(o.user_id) AS orders_count
FROM orders AS o
GROUP BY o.status
HAVING COUNT(o.user_id) >= 3;

-- для каждого пользователя вывести суммарную стоимость всех его заказов, но оставить только тех пользователей,
-- у которых общая сумма заказов больше 10000
SELECT u.id AS user_id, u.name AS user_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM users AS u
JOIN orders AS o ON o.user_id = u.id
JOIN order_items AS oi ON oi.order_id = o.id
GROUP BY u.id, u.name
HAVING SUM(oi.quantity * oi.unit_price) > 10000;

-- вывести товары, по которым суммарно продано от 5 единиц и больше, но учитывать только те строки заказа, где unit_price >= 1000
SELECT p.id AS product_id, p.name AS product_name, SUM(oi.quantity) AS total_quantity
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
WHERE oi.unit_price >= 1000
GROUP BY p.id, p.name
HAVING SUM(oi.quantity) >= 5;

-- для каждого пользователя и каждого статуса заказа вывести количество заказов, но оставить только те группы, где количество заказов больше 1
SELECT u.id AS user_id, u.name AS user_name, o.status, COUNT(o.user_id) AS orders_count
FROM users AS u
JOIN orders AS o ON o.user_id = u.id
GROUP BY u.id, u.name, o.status
HAVING COUNT(o.user_id) > 1;

-- вывести заказы, в которых суммарно куплено не меньше 4 единиц товара
SELECT o.id AS order_id, SUM(oi.quantity) AS total_quantity
FROM orders AS o
JOIN order_items AS oi ON oi.order_id = o.id
GROUP BY o.id
HAVING SUM(oi.quantity) >= 4;

-- вывести пользователей, у которых есть хотя бы 2 заказа со статусом PAID
SELECT u.id AS user_id, u.name AS user_name, COUNT(o.user_id) AS paid_orders_count
FROM users AS u
JOIN orders AS o ON o.user_id = u.id
WHERE o.status = 'PAID'
GROUP BY u.id, u.name
HAVING COUNT(o.user_id) >= 2;

-- для каждого товара вывести минимальную и максимальную цену продажи из order_items,
-- но оставить только те товары, у которых максимальная цена продажи больше 5000
SELECT p.id AS product_id, p.name AS product_name, MIN(oi.unit_price) AS min_unit_price, MAX(oi.unit_price) AS max_unit_price
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.id, p.name
HAVING MAX(oi.unit_price) > 5000;

-- вывести статусы заказов, для которых средняя сумма строки заказа больше 2000, но учитывать только заказы, созданные начиная с 1 января 2025 года
SELECT o.status, ROUND(AVG(oi.quantity * oi.unit_price), 2) AS avg_line_total
FROM orders AS o
JOIN order_items AS oi ON oi.order_id = o.id
WHERE o.created_at >= '2025-01-01'
GROUP BY o.status
HAVING AVG(oi.quantity * oi.unit_price) > 2000;