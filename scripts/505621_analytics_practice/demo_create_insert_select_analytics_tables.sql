-- Создание таблиц
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL -- 'completed', 'cancelled'
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL
);

-- Заполнение тестовыми данными
INSERT INTO products (product_name, category, price) VALUES
('Ноутбук Apple MacBook Air', 'Электроника', 90000.00),
('Мышь Logitech MX Master', 'Аксессуары', 8000.00),
('Клавиатура Keychron K2', 'Аксессуары', 7500.00),
('Наушники Sony WH-1000XM5', 'Аудио', 25000.00);

INSERT INTO orders (customer_name, order_date, status) VALUES
('Иван Иванов', '2023-10-01', 'completed'),
('Петр Петров', '2023-10-02', 'completed'),
('Анна Смирнова', '2023-10-03', 'completed'),
('Елена Попова', '2023-10-04', 'cancelled'), -- Отмененный заказ!
('Иван Иванов', '2023-10-05', 'completed');

-- Состав заказов
-- Заказ 1: 1 Ноутбук + 1 Мышь
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), (1, 2, 1);
-- Заказ 2: 2 Клавиатуры
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(2, 3, 2);
-- Заказ 3: 1 Наушники + 1 Мышь
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(3, 4, 1), (3, 2, 1);
-- Заказ 4 (Отменен): 1 Ноутбук
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(4, 1, 1);
-- Заказ 5: 1 Мышь + 1 Клавиатура
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(5, 2, 1), (5, 3, 1);


-- Задача 1: Подсчет общей выручки
-- умножить количество каждого товара на его цену и сложить всё вместе. Не учитываем отмененные заказы
SELECT
    SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed';


-- Задача 2: Расчет среднего чека
-- сначала посчитать сумму каждого отдельного заказа (через CTE или подзапрос), а потом уже усреднить эти суммы
WITH OrderTotals AS (
    -- Считаем выручку для каждого успешного заказа
    SELECT
        oi.order_id,
        SUM(oi.quantity * p.price) AS order_sum
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY oi.order_id
)
-- Усредняем готовые суммы заказов
SELECT
    AVG(order_sum) AS average_check,
    COUNT(order_id) AS total_completed_orders
FROM OrderTotals;


-- Задача 3: Топ покупок (самые продаваемые товары)
-- Узнаем, какие товары приносят больше всего денег и в каком количестве продаются. Сортируем по убыванию (DESC) и ограничиваем тремя (LIMIT 3)
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_items_sold,
    SUM(oi.quantity * p.price) AS total_revenue_by_product
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY total_revenue_by_product DESC
LIMIT 3;


-- Задача 4: Выручка по категориям товаров
-- Группировка (GROUP BY) позволяет смотреть на данные срезами. Посмотрим, какая категория товаров приносит больше денег
-- Здесь COUNT(DISTINCT oi.order_id) используется, чтобы не считать дважды заказы, в которых купили два товара из одной категории
SELECT
    p.category,
    COUNT(DISTINCT oi.order_id) AS orders_in_category,
    SUM(oi.quantity * p.price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY category_revenue DESC;


-- Задача 5: Фильтрация агрегатов (HAVING)
-- Найдем товары, которые в сумме принесли выручки больше, чем на 20 000 рублей
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
HAVING SUM(oi.quantity * p.price) > 20000;


-- Построение отчета по месяцам (Использование DATE_TRUNC)
-- В Postgres очень удобно агрегировать данные по времени с помощью функции DATE_TRUNC
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS month_start,
    COUNT(DISTINCT o.order_id) AS orders_count,
    SUM(oi.quantity * p.price) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month_start;


--ЗАДАНИЕ:
--Задача 1. Лучшие клиенты (TOP) Выведите имена клиентов и суммарную выручку, которую они принесли. Учтите только успешные заказы.
--Отсортируйте результат по убыванию выручки и оставьте только двух самых прибыльных клиентов.
--Колонки в результате: customer_name, total_revenue.

--Задача 2. Фильтрация категорий (HAVING) Посчитайте общее количество проданных товаров и суммарную выручку
--для каждой категории (только успешные заказы). Выведите только те категории, суммарная выручка которых превышает 30 000 рублей.
--Колонки в результате: category, total_items_sold, category_revenue.

--Задача 3. Ловушка среднего (CTE + AVG) Руководство попросило посчитать: «какое среднее количество товарных позиций (штук)
--находится в одном успешном заказе?» Важное условие: если в заказе 2 разных товара (например, 1 ноутбук и 1 мышь),
--это считается как 2 позиции. Не попадитесь в ловушку прямого усреднения строк таблицы order_items!
--Сначала посчитайте количество позиций для каждого заказа, а затем найдите среднее. Колонки в результате: avg_items_per_order.
