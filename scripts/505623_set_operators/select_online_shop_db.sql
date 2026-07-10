-- получить общий список идентификаторов пользователей, которые:
-- либо делали заказы со статусом PAID
-- либо делали заказы со статусом NEW
SELECT u.id AS user_id
FROM users AS u
JOIN orders AS o ON o.user_id = u.id
WHERE o.status = 'PAID'
UNION
SELECT u.id AS user_id
FROM users AS u
JOIN orders AS o ON o.user_id = u.id
WHERE o.status = 'NEW';

-- получить общий список событий из таблиц users, products, orders
(
SELECT 'user' AS entity_type, u.id AS entity_id, u.created_at
FROM users AS u
UNION ALL
SELECT 'product' AS entity_type, p.id AS entity_id, p.created_at
FROM products AS p
UNION ALL
SELECT 'order' AS entity_type, o.id AS entity_id, o.created_at
FROM orders AS o
)
ORDER BY created_at DESC;

-- найти товары, которые активны и хотя бы раз встречались в заказах
SELECT p.id AS product_id, p.name AS product_name
FROM products AS p
WHERE p.is_active = TRUE
INTERSECT
SELECT p.id AS product_id, p.name AS product_name
FROM products AS p
WHERE EXISTS (
    SELECT 1
    FROM order_items AS oi
    WHERE oi.product_id = p.id
);

-- найти активные товары, которые ни разу не встречались в заказах
SELECT p.id AS product_id, p.name AS product_name
FROM products AS p
WHERE p.is_active = TRUE
EXCEPT
SELECT p.id AS product_id, p.name AS product_name
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id;

-- получить общий список пользователей, которые: либо вообще делали заказы, либо были созданы после 2025-01-01
SELECT u.id AS user_id, u.name AS user_name
FROM users AS u
WHERE EXISTS (SELECT 1 FROM orders AS o WHERE o.user_id = u.id)
UNION
SELECT u.id AS user_id, u.name AS user_name
FROM users AS u
WHERE u.created_at > '2025-01-01';

-- получить список товаров, которые: дороже средней цены товаров и при этом встречались в заказах
SELECT p.id AS product_id, p.name AS product_name, p.price
FROM products AS p
WHERE p.price >
(
    SELECT AVG(pr.price) AS avg_price
    FROM products pr
)
INTERSECT
SELECT p.id AS product_id, p.name AS product_name, p.price
FROM products AS p
WHERE EXISTS (
    SELECT 1
    FROM order_items AS oi
    WHERE oi.product_id = p.id
);

-- получить список пользователей, которые делали заказы, но не делали заказов со статусом CANCELLED
SELECT u.id AS user_id, u.name AS user_name
FROM users AS u
WHERE EXISTS (SELECT 1 FROM orders AS o WHERE o.user_id = u.id)
EXCEPT
SELECT u.id AS user_id, u.name AS user_name
FROM users AS u
WHERE EXISTS (SELECT 1 FROM orders AS o WHERE o.user_id = u.id AND o.status = 'CANCELLED');

-- получить общий список объектов для поиска по названию/имени из таблиц users и products
SELECT 'user' AS entity_type, u.id AS entity_id, u.name AS display_name
FROM users AS u
UNION ALL
SELECT 'product' AS entity_type, p.id AS entity_id, p.name AS display_name
FROM products AS p;