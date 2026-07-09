-- вывести товары, цена которых меньше средней цены всех товаров
SELECT p.id AS product_id, p.name AS product_name, p.price
FROM products AS p
WHERE p.price <
(
    SELECT AVG(pr.price)
    FROM products pr
);

-- вывести пользователей, у которых есть хотя бы один заказ со статусом PAID
SELECT u.id AS user_id, u.name AS user_name, u.email
FROM users AS u
WHERE EXISTS
(
    SELECT 1
    FROM orders AS o
    WHERE o.user_id = u.id AND o.status = 'PAID'
);

-- вывести пользователей, у которых нет ни одного заказа
SELECT u.id AS user_id, u.name AS user_name, u.email
FROM users AS u
WHERE NOT EXISTS
(
    SELECT 1
    FROM orders AS o
    WHERE o.user_id = u.id
);

--вывести товары, которые хотя бы раз встречались в order_items
SELECT p.id AS product_id, p.name AS product_name, p.price
FROM products AS p
WHERE p.id IN
(
    SELECT DISTINCT oi.product_id
    FROM order_items AS oi
);

-- вывести заказы, сумма которых больше 10000
SELECT t.ord_id AS order_id, t.ord_total AS order_total
FROM
(
    SELECT os.id AS ord_id, SUM(oi.quantity * oi.unit_price) AS ord_total
    FROM order_items AS oi
    JOIN orders AS os ON os.id = oi.order_id
    GROUP BY os.id
) AS t
WHERE t.ord_total > 10000;

-- вывести пользователей и количество их заказов через коррелированный подзапрос в SELECT
SELECT
u.id AS user_id,
u.name AS user_name,
(
    SELECT COUNT(o.user_id)
    FROM orders AS o
    WHERE o.user_id = u.id
) AS orders_count
FROM users AS u;

-- вывести товары, по которым суммарно продано больше, чем среднее количество продаж на товар
SELECT pr.id AS product_id, SUM(oit.quantity) AS total_quantity
FROM products AS pr
JOIN order_items AS oit ON oit.product_id = pr.id
GROUP BY pr.id
HAVING SUM(oit.quantity) > (
    SELECT AVG(t.product_sum) AS avg_quantity
    FROM (
    	SELECT SUM(oi.quantity) AS product_sum
    	FROM order_items AS oi
    	GROUP BY oi.product_id
    ) AS t
);

-- вывести заказы, у которых сумма выше средней суммы заказа
SELECT r.o_id AS order_id, avg_total AS order_total
FROM
(
    SELECT o.id AS o_id, SUM(oi.quantity * oi.unit_price) AS avg_total
    FROM orders AS o
    JOIN order_items AS oi ON o.id = oi.order_id
    GROUP BY o.id
) AS r
WHERE avg_total >
(
    SELECT AVG(order_sum) AS avg_product_sum
    FROM
    (
        SELECT SUM(oit.quantity * oit.unit_price) AS order_sum
        FROM order_items AS oit
        JOIN orders AS o ON oit.order_id = o.id
        GROUP BY oit.order_id
    )
);