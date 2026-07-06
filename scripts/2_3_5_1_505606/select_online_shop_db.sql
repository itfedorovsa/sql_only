SELECT * FROM users;

SELECT name, email FROM users;

SELECT id as user_id, name as user_name, email as user_email FROM users;

SELECT id, order_id, product_id, quantity, unit_price, quantity * unit_price as line_total FROM order_items;

SELECT id, name, price, price * 0.9 as discounted_price FROM products;