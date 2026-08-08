-- общий объем продаж по дням
SELECT
    DATE(o.created_at) AS sale_date,
    SUM(oi.quantity * oi.unit_price) AS sales_amount
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.id
GROUP BY DATE(o.created_at)
ORDER BY sale_date;

-- Рядом с суммой продаж каждого дня вывести сумму продаж предыдущего дня
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    LAG(sales_amount) OVER (
        ORDER BY sale_date
    ) AS previous_day_sales
FROM daily_sales
ORDER BY sale_date;

-- насколько изменилась сумма продаж по сравнению с предыдущим днем
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    sales_amount - LAG(sales_amount) OVER (
        ORDER BY sale_date
    ) AS sales_diff
FROM daily_sales
ORDER BY sale_date;

-- насколько изменилась сумма продаж по сравнению с предыдущим днем (в %)
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    ROUND(
        (
            sales_amount -
            LAG(sales_amount) OVER (ORDER BY sale_date)
        ) * 100.0
        /
        LAG(sales_amount) OVER (ORDER BY sale_date),
        2
    ) AS sales_diff_pct
FROM daily_sales
ORDER BY sale_date;

-- насколько изменилась сумма продаж по сравнению с предыдущим днем (в % + вынос расчета значения пред дня)
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
),
sales_with_prev AS (
    SELECT
        sale_date,
        sales_amount,
        LAG(sales_amount) OVER (
            ORDER BY sale_date
        ) AS previous_day_sales
    FROM daily_sales
)
SELECT
    sale_date,
    sales_amount,
    previous_day_sales,
    ROUND(
        (sales_amount - previous_day_sales) * 100.0
        / previous_day_sales,
        2
    ) AS sales_diff_pct
FROM sales_with_prev
ORDER BY sale_date;

-- продажи, которые были два дня назад
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    LAG(sales_amount, 2) OVER (
        ORDER BY sale_date
    ) AS sales_two_days_ago
FROM daily_sales
ORDER BY sale_date;

-- продажи, которые были два дня назад + default
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    LAG(sales_amount, 1, 0) OVER (
        ORDER BY sale_date
    ) AS previous_day_sales
FROM daily_sales
ORDER BY sale_date;

-- вычислить ожидаемое изменение продаж относительно следующего дня
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    LEAD(sales_amount) OVER (
        ORDER BY sale_date
    ) - sales_amount AS next_day_diff
FROM daily_sales
ORDER BY sale_date;

-- сколько всего товаров было продано с начала периода к каждому дню (running total с рамкой окна)
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    SUM(sales_amount) OVER (
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS running_total
FROM daily_sales
ORDER BY sale_date;

-- вычислить среднюю сумму продаж за последние три дня
WITH daily_sales AS (
    SELECT
        DATE(o.created_at) AS sale_date,
        SUM(oi.quantity * oi.unit_price) AS sales_amount
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.id
    GROUP BY DATE(o.created_at)
)
SELECT
    sale_date,
    sales_amount,
    ROUND(
        AVG(sales_amount) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 2 PRECEDING
                     AND CURRENT ROW
        ),
        2
    ) AS avg_last_three_days
FROM daily_sales
ORDER BY sale_date;