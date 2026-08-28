-- 1. Проверка UNIQUE.
-- Выполнить отдельно. Ожидается ошибка. Создать пользователя с email, который уже существует
INSERT INTO users (name, email) VALUES
('Иван Петров', 'ivan.petrov@example.com');

-- Выполнить отдельно. Ожидается ошибка. Проверить запрет повторной связи товара и категории
INSERT INTO product_categories (product_id, category_id) VALUES
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM categories WHERE name='Смартфоны'));


-- 2. Проверка FOREIGN KEY.

-- Выполнить отдельно. Ожидается ошибка. Создать заказ для пользователя, которого нет в базе
INSERT INTO orders (user_id, address_id)
VALUES (999999, 1);

-- Выполнить отдельно. Ожидается ошибка. Добавить позицию с несуществующим товаром
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 999999, 1, 1000.00);


-- 3. Проверка CHECK.

-- Выполнить отдельно. Ожидается ошибка. Отрицательная цена
INSERT INTO products (brand_id, name, price, stock)
VALUES (1, 'Некорректный товар', -100.00, 10);

-- Выполнить отдельно. Ожидается ошибка. Отрицательный остаток
INSERT INTO products (brand_id, name, price, stock)
VALUES (1, 'Еще один товар', 1000.00, -5);

-- Выполнить отдельно. Ожидается ошибка. Некорректное количество товара в заказе
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 0, 1000.00);

-- Выполнить отдельно. Ожидается ошибка. Некорректный рейтинг
INSERT INTO reviews (user_id, product_id, rating)
VALUES (1, 1, 10);

-- Выполнить отдельно. Ожидается ошибка. Некорректная скидка
INSERT INTO promotions (
    name,
    discount_percent,
    starts_at,
    ends_at
)
VALUES (
    'Некорректная акция',
    150,
    '2026-08-01',
    '2026-08-31'
);


-- 4. Проверка допустимых значений

-- Выполнить отдельно. Ожидается ошибка. Проверка ограничений для статусов
INSERT INTO orders (user_id, address_id, status)
VALUES (1, 1, 'unknown');


-- 5. Проверка отношения один-к-одному

-- Выполнить отдельно. Ожидается ошибка. Для одного заказа допускается максимум одна доставка
INSERT INTO deliveries (order_id, status, delivery_cost, shipped_at, delivered_at) VALUES
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-05 10:00:00'), 'delivered', 500.00, '2026-04-06 10:00:00', '2026-04-08 15:00:00');