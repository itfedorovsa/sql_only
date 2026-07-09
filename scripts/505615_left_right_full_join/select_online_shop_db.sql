-- вывести всех пользователей и количество их заказов, включая пользователей без заказов
SELECT u.id AS user_id, u.name AS user_name, count(o.id) AS orders_overall
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
GROUP BY u.id, u.name;

-- найти заказы, по которым еще не было платежа
SELECT o.id AS order_id, o.status, o.created_at
FROM orders AS o
LEFT JOIN payments AS p ON p.order_id = o.id
WHERE p.order_id IS NULL;

-- вывести товары, которые встречались хотя бы в одном заказе, и рядом показать, сколько раз они встречались в order_items
SELECT p.id AS product_id, p.name AS product_name, count(oi.id)
FROM products AS p
JOIN order_items AS oi ON oi.product_id = p.id
GROUP BY p.id, p.name;

-- вывести все роли и количество пользователей, которым назначена каждая роль
SELECT r.code, count(ur.user_id)
FROM roles AS r
LEFT JOIN user_roles AS ur ON ur.role_id = r.id
GROUP BY r.code
ORDER BY r.code ASC;

-- найти пользователей, которым не назначена ни одна роль
SELECT u.id AS user_id, u.name AS user_name
FROM users AS u
LEFT JOIN user_roles AS ur ON ur.user_id = u.id
WHERE ur.role_id IS NULL;

-- сделать сверочный запрос по ролям и назначениям ролей
SELECT r.code, u.id AS user_id
FROM roles AS r
FULL JOIN user_roles AS ur ON ur.role_id = r.id
LEFT JOIN users AS u ON ur.user_id = u.id;

-- построить все комбинации role × environment
SELECT r.code AS role_code, e.code AS env_code
FROM roles AS r
CROSS JOIN environments AS e;

-- вывести все категории вместе с именем их родительской категории
SELECT c.name AS category, ct.name AS parent
FROM categories AS c
LEFT JOIN categories AS ct ON c.parent_id = ct.id;