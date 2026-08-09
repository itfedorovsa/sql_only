-- для каждого заказа вычислим его полную стоимость
SELECT
o.id,
o.user_id,
o.created_at,
SUM(oi.quantity * oi.unit_price) AS order_amount
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
GROUP BY o.id, o.user_id, o.created_at
ORDER BY o.user_id, o.created_at;

-- показать стоимость самого первого заказа пользователя
WITH order_totals AS (
    SELECT
        o.id,
        o.user_id,
        o.created_at,
        SUM(oi.quantity * oi.unit_price) AS order_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY
        o.id,
        o.user_id,
        o.created_at
)
SELECT
    id,
    user_id,
    created_at,
    order_amount,
    FIRST_VALUE(order_amount) OVER (
        PARTITION BY user_id
        ORDER BY created_at
    ) AS first_order_amount
FROM order_totals
ORDER BY
    user_id,
    created_at;

-- показать стоимость самого последнего заказа пользователя
WITH order_totals AS (
    SELECT
        o.id,
        o.user_id,
        o.created_at,
        SUM(oi.quantity * oi.unit_price) AS order_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY
        o.id,
        o.user_id,
        o.created_at
)
SELECT
    id,
    user_id,
    created_at,
    order_amount,
    LAST_VALUE(order_amount) OVER (
    PARTITION BY user_id
    ORDER BY created_at
    ROWS BETWEEN UNBOUNDED PRECEDING
             AND UNBOUNDED FOLLOWING
) AS last_order_amount
FROM order_totals
ORDER BY
    user_id,
    created_at;

-- показать стоимость третьего заказа пользователя
WITH order_totals AS (
    SELECT
        o.id,
        o.user_id,
        o.created_at,
        SUM(oi.quantity * oi.unit_price) AS order_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY
        o.id,
        o.user_id,
        o.created_at
)
SELECT
    id,
    user_id,
    created_at,
    order_amount,
    NTH_VALUE(order_amount, 3) OVER (
        PARTITION BY user_id
        ORDER BY created_at
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND UNBOUNDED FOLLOWING
    ) AS third_order_amount
FROM order_totals
ORDER BY
    user_id,
    created_at;