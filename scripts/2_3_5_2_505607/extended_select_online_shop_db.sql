SELECT id, name, price, is_active
FROM products
WHERE is_active = TRUE;

SELECT id, name, price
FROM products
WHERE price BETWEEN 10000 AND 100000;

SELECT id, user_id, status, created_at
FROM orders
WHERE status IN ('NEW', 'PAID');

SELECT id, user_id, status, created_at
FROM orders
WHERE user_id = 1 AND (status <> 'CANCELLED' OR status IS NULL);

SELECT id, name, email, created_at
FROM users
WHERE created_at >= '2026-01-01' AND created_at < '2027-01-01';

SELECT id, name, price
FROM products
WHERE price NOT BETWEEN 20000 AND 80000;

SELECT id, name, price
FROM products
WHERE is_active = TRUE AND NOT BETWEEN 3000 AND 150000;