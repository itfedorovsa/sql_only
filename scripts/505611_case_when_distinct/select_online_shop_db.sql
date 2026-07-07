SELECT
	id,
	name,
	price,
	CASE
		WHEN price < 5000 THEN 'cheap'
		WHEN price BETWEEN 5000 AND 50000 THEN 'regular'
		ELSE 'premium'
	END AS price_label
FROM products;

SELECT
	id,
	name,
	phone,
	CASE
		WHEN phone IS NULL THEN 'not specified'
		ELSE 'specified'
	END AS phone_status
FROM users;

SELECT DISTINCT status
FROM orders;

SELECT DISTINCT user_id
FROM orders;

SELECT DISTINCT ON (user_id) id, user_id, status, created_at
FROM orders
ORDER BY user_id DESC, created_at DESC, id DESC;

SELECT DISTINCT ON (name) id, name, price
FROM products
WHERE name IS NOT NULL
ORDER BY name ASC, price DESC, id DESC;
