-- для каждого заказа вывести:
-- идентификатор заказа, идентификатор пользователя, сумму заказа, общую сумму всех заказов этого пользователя.
WITH order_totals AS (
SELECT oi.order_id, SUM(oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
ot.order_id,
o.user_id,
ot.total_amount,
SUM(ot.total_amount) OVER(PARTITION BY o.user_id) AS user_total
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id;

-- для каждого заказа необходимо вывести:
-- идентификатор заказа, идентификатор пользователя, сумму заказа, среднюю стоимость заказа данного пользователя.
WITH order_totals AS (
SELECT oi.order_id, SUM(oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
ot.order_id,
o.user_id,
ot.total_amount,
AVG(ot.total_amount) OVER(PARTITION BY o.user_id) AS average_order_amount
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id;

-- для каждого заказа необходимо определить его порядковый номер среди заказов этого пользователя по дате оформления.
SELECT
o.id AS order_id,
o.user_id,
o.created_at,
ROW_NUMBER() OVER(PARTITION BY o.user_id ORDER BY o.created_at)
FROM orders o;

-- постройте рейтинг заказов по их стоимости в порядке убывания.
WITH order_totals AS (
SELECT oi.order_id, SUM (oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
o.id AS order_id,
ot.total_amount,
RANK() OVER(ORDER BY ot.total_amount DESC) AS order_rank
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id;

-- выполните ту же задачу, что и в предыдущем задании, но используйте функцию DENSE_RANK().
WITH order_totals AS (
SELECT oi.order_id, SUM (oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
o.id AS order_id,
ot.total_amount,
DENSE_RANK() OVER(ORDER BY ot.total_amount DESC) AS order_rank
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id;

-- разделите все заказы на четыре примерно равные группы по стоимости заказа в порядке убывания.
WITH order_totals AS (
SELECT oi.order_id, SUM (oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
ot.order_id,
ot.total_amount,
NTILE(4) OVER(ORDER BY ot.total_amount DESC) AS group_number
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id;

-- для каждого пользователя одновременно выведите:
-- общую сумму его заказов, среднюю стоимость заказа, количество заказов.
WITH order_totals AS (
SELECT oi.order_id, SUM (oi.quantity * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)
SELECT
ot.order_id,
o.user_id,
ot.total_amount,
SUM(ot.total_amount) OVER w AS user_total,
AVG(ot.total_amount) OVER w AS average_order_amount,
COUNT(ot.total_amount) OVER w AS orders_count
FROM orders o
JOIN order_totals ot ON ot.order_id = o.id
WINDOW w AS (
PARTITION BY o.user_id
);