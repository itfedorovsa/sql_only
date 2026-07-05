INSERT INTO inactive_products_archive(product_id, product_name, price)
SELECT id, name, price
FROM products
WHERE is_active = false;