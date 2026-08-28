SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM addresses;
SELECT COUNT(*) FROM brands;
SELECT COUNT(*) FROM categories;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM product_categories;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM deliveries;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM promotions;
SELECT COUNT(*) FROM product_promotions;

SELECT
    o.id AS order_id,
    u.name AS user_name,
    p.name AS product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
ORDER BY o.id;