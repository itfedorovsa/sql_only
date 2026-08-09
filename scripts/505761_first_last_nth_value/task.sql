WITH order_total AS (
SELECT
o.id,
o.user_id,
o.created_at,
SUM(oi.quantity * oi.unit_price) AS order_amount
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id, o.user_id, o.created_at
)
SELECT
ot.user_id,
ot.id AS order_id,
ot.created_at,
ot.order_amount,
FIRST_VALUE(order_amount) OVER(w) AS first_order_amount,
LAST_VALUE(order_amount) OVER(w ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_amount,
NTH_VALUE(order_amount, 2) OVER(w ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS second_order_amount
FROM order_total ot
WINDOW w AS (PARTITION BY ot.user_id ORDER BY ot.created_at)
ORDER BY ot.user_id, ot.created_at;