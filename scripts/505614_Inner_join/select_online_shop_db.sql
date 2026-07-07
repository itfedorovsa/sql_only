SELECT o.id AS order_id, o.status, u.email
FROM orders AS o
JOIN users AS u ON o.user_id = u.id
ORDER BY o.id ASC;

SELECT oi.id AS order_item_id, o.id AS order_id, p.name, oi.quantity
FROM order_items AS oi
JOIN orders AS o ON oi.order_id = o.id
JOIN products AS p ON oi.product_id = p.id
WHERE oi.quantity > 1;

SELECT o.id AS order_id, p.name, oi.quantity, oi.unit_price
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
JOIN orders AS o ON oi.order_id = o.id
JOIN users AS u ON o.user_id = u.id
WHERE u.id = 1;

SELECT o.id AS order_id, o.status, u.name
FROM orders AS o
JOIN users AS u ON u.id = o.user_id
WHERE o.status = 'NEW';

SELECT oi.id AS order_item_id, p.name, oi.quantity, oi.quantity * oi.unit_price AS line_total
FROM order_items AS oi
JOIN products AS p ON p.id = oi.product_id;