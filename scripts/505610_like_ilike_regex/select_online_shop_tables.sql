SELECT id, name, email
FROM users
WHERE email ILIKE '%mail%';

SELECT id, name, email
FROM users
WHERE email ~* 'mail';

SELECT id, name, price
FROM products
WHERE name ILIKE '%air%';

SELECT id, name, price
FROM products
WHERE name ~* 'air';

SELECT id, name, price
FROM products
WHERE name ILIKE 'i%';

SELECT id, name, price
FROM products
WHERE name ~* '^i';

SELECT id, name, price
FROM products
WHERE name ILIKE '%pro';

SELECT id, name, price
FROM products
WHERE name ~* 'pro$';

SELECT id, name, email
FROM users
WHERE name LIKE 'A%' OR name ILIKE 'I%';

SELECT id, name, email
FROM users
WHERE name ~ '^A' OR name ~* '^I';

SELECT id, name, price
FROM products
WHERE name ~* '^iPhone [0-9]+$';