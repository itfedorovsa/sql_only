-- =====================================================
-- 1. ПОЛЬЗОВАТЕЛИ (users)
-- =====================================================
INSERT INTO users (name, email, created_at) VALUES
('Иван Петров', 'ivan.petrov@example.com', '2025-03-15 10:00:00'),
('Анна Смирнова', 'anna.smirnova@example.com', '2025-05-20 14:30:00'),
('Петр Сидоров', 'petr.sidorov@example.com', '2025-06-01 09:15:00'),
('Мария Кузнецова', 'maria.kuznetsova@example.com', '2025-07-12 16:45:00'),
('Алексей Иванов', 'alexey.ivanov@example.com', '2025-08-03 11:20:00'),
('Елена Волкова', 'elena.volkova@example.com', '2025-09-18 13:10:00'),
('Дмитрий Козлов', 'dmitry.kozlov@example.com', '2025-10-22 08:50:00'),
('Ольга Новикова', 'olga.novikova@example.com', '2025-11-30 17:30:00'),
('Сергей Морозов', 'sergey.morozov@example.com', '2025-12-05 10:05:00'),
('Татьяна Павлова', 'tatyana.pavlova@example.com', '2026-01-14 12:40:00'),
('Николай Соколов', 'nikolay.sokolov@example.com', '2026-02-02 09:00:00'),
('Юлия Лебедева', 'yulia.lebedeva@example.com', '2026-03-21 15:25:00'),
('Виктор Попов', 'viktor.popov@example.com', '2026-04-08 11:55:00'),
('Наталья Семенова', 'natalya.semenova@example.com', '2026-05-17 14:00:00'),
('Андрей Васильев', 'andrey.vasiliev@example.com', '2026-06-29 10:30:00');

-- =====================================================
-- 2. АДРЕСА (addresses)
-- =====================================================
INSERT INTO addresses (user_id, city, street, is_default) VALUES
-- Иван Петров (3 адреса)
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), 'Москва', 'Тверская 1', true),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), 'Москва', 'Ленина 2', false),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), 'Санкт-Петербург', 'Невский 10', false),
-- Анна Смирнова (2 адреса)
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), 'Санкт-Петербург', 'Пушкина 5', true),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), 'Санкт-Петербург', 'Гагарина 3', false),
-- Петр Сидоров (1 адрес)
((SELECT id FROM users WHERE email='petr.sidorov@example.com'), 'Казань', 'Баумана 3', true),
-- Мария Кузнецова (2 адреса)
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), 'Екатеринбург', 'Ленина 20', true),
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), 'Екатеринбург', 'Мира 15', false),
-- Алексей Иванов (2 адреса)
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), 'Новосибирск', 'Красный проспект 15', true),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), 'Новосибирск', 'Советская 8', false),
-- Елена Волкова (1 адрес)
((SELECT id FROM users WHERE email='elena.volkova@example.com'), 'Москва', 'Арбат 25', true),
-- Дмитрий Козлов (2 адреса)
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), 'Казань', 'Пушкина 12', true),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), 'Казань', 'Чистопольская 5', false),
-- Ольга Новикова (2 адреса)
((SELECT id FROM users WHERE email='olga.novikova@example.com'), 'Екатеринбург', 'Вайнера 30', true),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), 'Екатеринбург', '8 Марта 44', false),
-- Сергей Морозов (1 адрес)
((SELECT id FROM users WHERE email='sergey.morozov@example.com'), 'Москва', 'Красная Пресня 17', true),
-- Татьяна Павлова (1 адрес)
((SELECT id FROM users WHERE email='tatyana.pavlova@example.com'), 'Санкт-Петербург', 'Лиговский 50', true),
-- Николай Соколов (1 адрес)
((SELECT id FROM users WHERE email='nikolay.sokolov@example.com'), 'Новосибирск', 'Вокзальная магистраль 9', true),
-- Юлия Лебедева (2 адреса)
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), 'Москва', 'Профсоюзная 22', true),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), 'Москва', 'Ленинский проспект 55', false),
-- Виктор Попов (1 адрес)
((SELECT id FROM users WHERE email='viktor.popov@example.com'), 'Казань', 'Декабристов 7', true),
-- Наталья Семенова (1 адрес)
((SELECT id FROM users WHERE email='natalya.semenova@example.com'), 'Екатеринбург', 'Татищева 11', true),
-- Андрей Васильев (нет заказов, но адрес есть)
((SELECT id FROM users WHERE email='andrey.vasiliev@example.com'), 'Новосибирск', 'Красный проспект 100', true);

-- =====================================================
-- 3. БРЕНДЫ (brands)
-- =====================================================
INSERT INTO brands (name) VALUES
('Apple'),
('Samsung'),
('Xiaomi'),
('Asus'),
('HP'),
('Adidas'),
('Эксмо'),
('Bosch');

-- =====================================================
-- 4. КАТЕГОРИИ (categories)
-- =====================================================
INSERT INTO categories (name) VALUES
('Электроника'),
('Ноутбуки'),
('Смартфоны'),
('Аксессуары'),
('Бытовая техника'),
('Одежда'),
('Обувь'),
('Книги');

-- =====================================================
-- 5. ТОВАРЫ (products)
-- =====================================================
INSERT INTO products (brand_id, name, price, stock, is_active) VALUES
((SELECT id FROM brands WHERE name='Apple'), 'iPhone 15 Pro', 129990.00, 15, true),
((SELECT id FROM brands WHERE name='Apple'), 'iPhone 14', 89990.00, 0, false),
((SELECT id FROM brands WHERE name='Apple'), 'MacBook Air M3', 119990.00, 10, true),
((SELECT id FROM brands WHERE name='Apple'), 'MacBook Pro 16', 249990.00, 5, true),
((SELECT id FROM brands WHERE name='Apple'), 'iPad Air', 69990.00, 8, true),
((SELECT id FROM brands WHERE name='Apple'), 'AirPods Pro', 24990.00, 25, true),
((SELECT id FROM brands WHERE name='Samsung'), 'Samsung Galaxy S24', 99990.00, 20, true),
((SELECT id FROM brands WHERE name='Samsung'), 'Samsung Galaxy Tab S9', 79990.00, 12, true),
((SELECT id FROM brands WHERE name='Samsung'), 'Samsung Odyssey G7', 69990.00, 7, true),
((SELECT id FROM brands WHERE name='Xiaomi'), 'Xiaomi 14', 69990.00, 18, true),
((SELECT id FROM brands WHERE name='Xiaomi'), 'Xiaomi Mi Band 8', 3990.00, 30, true),
((SELECT id FROM brands WHERE name='Asus'), 'Asus ROG Strix G16', 159990.00, 9, true),
((SELECT id FROM brands WHERE name='Asus'), 'Asus TUF Gaming VG27AQ', 44990.00, 14, true),
((SELECT id FROM brands WHERE name='Asus'), 'Asus Zenbook 14', 89990.00, 11, true),
((SELECT id FROM brands WHERE name='HP'), 'HP Spectre x360', 139990.00, 6, true),
((SELECT id FROM brands WHERE name='HP'), 'HP LaserJet Pro', 18990.00, 20, true),
((SELECT id FROM brands WHERE name='Adidas'), 'Adidas Ultraboost', 15990.00, 22, true),
((SELECT id FROM brands WHERE name='Adidas'), 'Adidas T-shirt', 2990.00, 50, true),
((SELECT id FROM brands WHERE name='Эксмо'), 'Война и мир', 990.00, 40, true),
((SELECT id FROM brands WHERE name='Эксмо'), 'Преступление и наказание', 890.00, 35, true),
((SELECT id FROM brands WHERE name='Bosch'), 'Bosch Serie 4', 59990.00, 8, true),
((SELECT id FROM brands WHERE name='Bosch'), 'Bosch KGN39', 89990.00, 4, true),
((SELECT id FROM brands WHERE name='Bosch'), 'Bosch MUM5', 34990.00, 10, true),
((SELECT id FROM brands WHERE name='Samsung'), 'Samsung 55" QLED', 109990.00, 6, true),
((SELECT id FROM brands WHERE name='Xiaomi'), 'Xiaomi Robot Vacuum', 29990.00, 15, true),
((SELECT id FROM brands WHERE name='HP'), 'HP Pavilion', 79990.00, 5, true),
((SELECT id FROM brands WHERE name='Asus'), 'Asus ROG Phone 8', 89990.00, 13, true);

-- =====================================================
-- 6. СВЯЗИ ТОВАР-КАТЕГОРИЯ (product_categories)
-- =====================================================
INSERT INTO product_categories (product_id, category_id) VALUES
-- iPhone 15 Pro
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM categories WHERE name='Смартфоны')),
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM categories WHERE name='Электроника')),
-- iPhone 14
((SELECT id FROM products WHERE name='iPhone 14'), (SELECT id FROM categories WHERE name='Смартфоны')),
((SELECT id FROM products WHERE name='iPhone 14'), (SELECT id FROM categories WHERE name='Электроника')),
-- MacBook Air M3
((SELECT id FROM products WHERE name='MacBook Air M3'), (SELECT id FROM categories WHERE name='Ноутбуки')),
((SELECT id FROM products WHERE name='MacBook Air M3'), (SELECT id FROM categories WHERE name='Электроника')),
-- MacBook Pro 16
((SELECT id FROM products WHERE name='MacBook Pro 16'), (SELECT id FROM categories WHERE name='Ноутбуки')),
((SELECT id FROM products WHERE name='MacBook Pro 16'), (SELECT id FROM categories WHERE name='Электроника')),
-- iPad Air
((SELECT id FROM products WHERE name='iPad Air'), (SELECT id FROM categories WHERE name='Электроника')),
-- AirPods Pro
((SELECT id FROM products WHERE name='AirPods Pro'), (SELECT id FROM categories WHERE name='Аксессуары')),
((SELECT id FROM products WHERE name='AirPods Pro'), (SELECT id FROM categories WHERE name='Электроника')),
-- Samsung Galaxy S24
((SELECT id FROM products WHERE name='Samsung Galaxy S24'), (SELECT id FROM categories WHERE name='Смартфоны')),
((SELECT id FROM products WHERE name='Samsung Galaxy S24'), (SELECT id FROM categories WHERE name='Электроника')),
-- Samsung Galaxy Tab S9
((SELECT id FROM products WHERE name='Samsung Galaxy Tab S9'), (SELECT id FROM categories WHERE name='Электроника')),
-- Samsung Odyssey G7
((SELECT id FROM products WHERE name='Samsung Odyssey G7'), (SELECT id FROM categories WHERE name='Аксессуары')),
((SELECT id FROM products WHERE name='Samsung Odyssey G7'), (SELECT id FROM categories WHERE name='Электроника')),
-- Xiaomi 14
((SELECT id FROM products WHERE name='Xiaomi 14'), (SELECT id FROM categories WHERE name='Смартфоны')),
((SELECT id FROM products WHERE name='Xiaomi 14'), (SELECT id FROM categories WHERE name='Электроника')),
-- Xiaomi Mi Band 8
((SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), (SELECT id FROM categories WHERE name='Аксессуары')),
-- Asus ROG Strix G16
((SELECT id FROM products WHERE name='Asus ROG Strix G16'), (SELECT id FROM categories WHERE name='Ноутбуки')),
((SELECT id FROM products WHERE name='Asus ROG Strix G16'), (SELECT id FROM categories WHERE name='Электроника')),
-- Asus TUF Gaming VG27AQ
((SELECT id FROM products WHERE name='Asus TUF Gaming VG27AQ'), (SELECT id FROM categories WHERE name='Аксессуары')),
((SELECT id FROM products WHERE name='Asus TUF Gaming VG27AQ'), (SELECT id FROM categories WHERE name='Электроника')),
-- Asus Zenbook 14
((SELECT id FROM products WHERE name='Asus Zenbook 14'), (SELECT id FROM categories WHERE name='Ноутбуки')),
((SELECT id FROM products WHERE name='Asus Zenbook 14'), (SELECT id FROM categories WHERE name='Электроника')),
-- HP Spectre x360
((SELECT id FROM products WHERE name='HP Spectre x360'), (SELECT id FROM categories WHERE name='Ноутбуки')),
((SELECT id FROM products WHERE name='HP Spectre x360'), (SELECT id FROM categories WHERE name='Электроника')),
-- HP LaserJet Pro
((SELECT id FROM products WHERE name='HP LaserJet Pro'), (SELECT id FROM categories WHERE name='Аксессуары')),
((SELECT id FROM products WHERE name='HP LaserJet Pro'), (SELECT id FROM categories WHERE name='Электроника')),
-- Adidas Ultraboost
((SELECT id FROM products WHERE name='Adidas Ultraboost'), (SELECT id FROM categories WHERE name='Обувь')),
-- Adidas T-shirt
((SELECT id FROM products WHERE name='Adidas T-shirt'), (SELECT id FROM categories WHERE name='Одежда')),
-- Война и мир
((SELECT id FROM products WHERE name='Война и мир'), (SELECT id FROM categories WHERE name='Книги')),
-- Преступление и наказание
((SELECT id FROM products WHERE name='Преступление и наказание'), (SELECT id FROM categories WHERE name='Книги')),
-- Bosch Serie 4
((SELECT id FROM products WHERE name='Bosch Serie 4'), (SELECT id FROM categories WHERE name='Бытовая техника')),
-- Bosch KGN39
((SELECT id FROM products WHERE name='Bosch KGN39'), (SELECT id FROM categories WHERE name='Бытовая техника')),
-- Bosch MUM5
((SELECT id FROM products WHERE name='Bosch MUM5'), (SELECT id FROM categories WHERE name='Бытовая техника')),
-- Samsung 55" QLED
((SELECT id FROM products WHERE name='Samsung 55" QLED'), (SELECT id FROM categories WHERE name='Электроника')),
((SELECT id FROM products WHERE name='Samsung 55" QLED'), (SELECT id FROM categories WHERE name='Бытовая техника')),
-- Xiaomi Robot Vacuum
((SELECT id FROM products WHERE name='Xiaomi Robot Vacuum'), (SELECT id FROM categories WHERE name='Бытовая техника')),
((SELECT id FROM products WHERE name='Xiaomi Robot Vacuum'), (SELECT id FROM categories WHERE name='Электроника')),
-- HP Pavilion
((SELECT id FROM products WHERE name='HP Pavilion'), (SELECT id FROM categories WHERE name='Электроника')),
-- Asus ROG Phone 8
((SELECT id FROM products WHERE name='Asus ROG Phone 8'), (SELECT id FROM categories WHERE name='Смартфоны')),
((SELECT id FROM products WHERE name='Asus ROG Phone 8'), (SELECT id FROM categories WHERE name='Электроника'));

-- =====================================================
-- 7. ЗАКАЗЫ (orders)
-- =====================================================
-- Используем подзапросы для получения user_id и address_id
INSERT INTO orders (user_id, address_id, status, created_at) VALUES
-- Иван Петров: 6 заказов
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-05 10:00:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-15 14:30:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-02 09:20:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'processing', '2026-05-20 18:10:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'shipped', '2026-06-10 11:45:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND is_default=true LIMIT 1), 'new', '2026-07-01 08:00:00'),
-- Анна Смирнова: 3 заказа
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-08 12:00:00'),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-15 16:40:00'),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND is_default=true LIMIT 1), 'cancelled', '2026-06-20 10:15:00'),
-- Петр Сидоров: 1 заказ
((SELECT id FROM users WHERE email='petr.sidorov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='petr.sidorov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-20 13:25:00'),
-- Мария Кузнецова: 2 заказа
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-25 10:30:00'),
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-06-05 15:50:00'),
-- Алексей Иванов: 4 заказа
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-12 09:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-08 17:20:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND is_default=true LIMIT 1), 'processing', '2026-06-15 12:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-07-10 14:30:00'),
-- Елена Волкова: 2 заказа
((SELECT id FROM users WHERE email='elena.volkova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-18 11:10:00'),
((SELECT id FROM users WHERE email='elena.volkova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND is_default=true LIMIT 1), 'cancelled', '2026-06-02 09:40:00'),
-- Дмитрий Козлов: 5 заказов
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-10 08:30:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-28 16:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-12 13:45:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND is_default=true LIMIT 1), 'shipped', '2026-06-22 10:20:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-07-08 09:10:00'),
-- Ольга Новикова: 3 заказа
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-14 15:30:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND is_default=true LIMIT 1), 'processing', '2026-05-25 11:00:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-06-28 12:30:00'),
-- Сергей Морозов: 2 заказа
((SELECT id FROM users WHERE email='sergey.morozov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-22 09:50:00'),
((SELECT id FROM users WHERE email='sergey.morozov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND is_default=true LIMIT 1), 'cancelled', '2026-07-05 14:00:00'),
-- Татьяна Павлова: 1 заказ
((SELECT id FROM users WHERE email='tatyana.pavlova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='tatyana.pavlova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-30 10:00:00'),
-- Николай Соколов: 2 заказа
((SELECT id FROM users WHERE email='nikolay.sokolov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-03 16:20:00'),
((SELECT id FROM users WHERE email='nikolay.sokolov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-06-18 11:40:00'),
-- Юлия Лебедева: 3 заказа
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-11 13:10:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-19 10:50:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND is_default=true LIMIT 1), 'new', '2026-07-01 15:00:00'),
-- Виктор Попов: 1 заказ
((SELECT id FROM users WHERE email='viktor.popov@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='viktor.popov@example.com') AND is_default=true LIMIT 1), 'completed', '2026-05-07 12:00:00'),
-- Наталья Семенова: 2 заказа
((SELECT id FROM users WHERE email='natalya.semenova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND is_default=true LIMIT 1), 'completed', '2026-04-16 14:45:00'),
((SELECT id FROM users WHERE email='natalya.semenova@example.com'), (SELECT id FROM addresses WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND is_default=true LIMIT 1), 'processing', '2026-06-30 11:30:00');
-- Андрей Васильев: без заказов

-- =====================================================
-- 8. ПОЗИЦИИ ЗАКАЗОВ (order_items)
-- =====================================================
-- Для каждого заказа добавляем позиции. Используем подзапросы для order_id и product_id.
-- Заказ 1 (Иван, completed, 05.04.2026): iPhone 15 Pro + AirPods Pro
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-05 10:00:00'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 1, 129990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-05 10:00:00'), (SELECT id FROM products WHERE name='AirPods Pro'), 2, 23990.00),
-- Заказ 2 (Иван, completed, 15.04.2026): MacBook Air M3 + Xiaomi Mi Band 8 + книга
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-15 14:30:00'), (SELECT id FROM products WHERE name='MacBook Air M3'), 1, 115000.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-15 14:30:00'), (SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), 3, 3500.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-15 14:30:00'), (SELECT id FROM products WHERE name='Война и мир'), 1, 900.00),
-- Заказ 3 (Иван, completed, 02.05.2026): Samsung Galaxy S24
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-02 09:20:00'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 1, 98990.00),
-- Заказ 4 (Иван, processing, 20.05.2026): HP Spectre x360 + Asus TUF Gaming VG27AQ
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-20 18:10:00'), (SELECT id FROM products WHERE name='HP Spectre x360'), 1, 139990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-20 18:10:00'), (SELECT id FROM products WHERE name='Asus TUF Gaming VG27AQ'), 1, 44990.00),
-- Заказ 5 (Иван, shipped, 10.06.2026): iPhone 15 Pro (еще один)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-06-10 11:45:00'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 1, 127000.00),
-- Заказ 6 (Иван, new, 01.07.2026): пока без позиций? Нет, добавим позицию.
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-07-01 08:00:00'), (SELECT id FROM products WHERE name='Xiaomi Robot Vacuum'), 1, 29990.00),

-- Заказ 7 (Анна, completed, 08.04.2026): Samsung Galaxy Tab S9 + Samsung Odyssey G7
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-04-08 12:00:00'), (SELECT id FROM products WHERE name='Samsung Galaxy Tab S9'), 1, 79990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-04-08 12:00:00'), (SELECT id FROM products WHERE name='Samsung Odyssey G7'), 1, 69990.00),
-- Заказ 8 (Анна, completed, 15.05.2026): Adidas Ultraboost + Adidas T-shirt
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-05-15 16:40:00'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 1, 15990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-05-15 16:40:00'), (SELECT id FROM products WHERE name='Adidas T-shirt'), 2, 2990.00),
-- Заказ 9 (Анна, cancelled, 20.06.2026): iPhone 14
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-06-20 10:15:00'), (SELECT id FROM products WHERE name='iPhone 14'), 1, 85000.00),

-- Заказ 10 (Петр, completed, 20.04.2026): Xiaomi 14
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='petr.sidorov@example.com') AND created_at='2026-04-20 13:25:00'), (SELECT id FROM products WHERE name='Xiaomi 14'), 1, 69990.00),

-- Заказ 11 (Мария, completed, 25.04.2026): Bosch Serie 4
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-04-25 10:30:00'), (SELECT id FROM products WHERE name='Bosch Serie 4'), 1, 59990.00),
-- Заказ 12 (Мария, completed, 05.06.2026): Bosch KGN39 + Bosch MUM5
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-06-05 15:50:00'), (SELECT id FROM products WHERE name='Bosch KGN39'), 1, 89990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-06-05 15:50:00'), (SELECT id FROM products WHERE name='Bosch MUM5'), 1, 34990.00),

-- Заказ 13 (Алексей, completed, 12.04.2026): MacBook Pro 16
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-04-12 09:00:00'), (SELECT id FROM products WHERE name='MacBook Pro 16'), 1, 249990.00),
-- Заказ 14 (Алексей, completed, 08.05.2026): Asus ROG Strix G16
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-05-08 17:20:00'), (SELECT id FROM products WHERE name='Asus ROG Strix G16'), 1, 158000.00),
-- Заказ 15 (Алексей, processing, 15.06.2026): Samsung 55" QLED + AirPods Pro
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-06-15 12:00:00'), (SELECT id FROM products WHERE name='Samsung 55" QLED'), 1, 109990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-06-15 12:00:00'), (SELECT id FROM products WHERE name='AirPods Pro'), 1, 24990.00),
-- Заказ 16 (Алексей, completed, 10.07.2026): iPad Air
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-07-10 14:30:00'), (SELECT id FROM products WHERE name='iPad Air'), 1, 69990.00),

-- Заказ 17 (Елена, completed, 18.04.2026): Преступление и наказание + Война и мир
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-04-18 11:10:00'), (SELECT id FROM products WHERE name='Преступление и наказание'), 1, 850.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-04-18 11:10:00'), (SELECT id FROM products WHERE name='Война и мир'), 2, 950.00),
-- Заказ 18 (Елена, cancelled, 02.06.2026): Adidas Ultraboost
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-06-02 09:40:00'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 1, 15990.00),

-- Заказ 19 (Дмитрий, completed, 10.04.2026): iPhone 15 Pro
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-10 08:30:00'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 1, 128500.00),
-- Заказ 20 (Дмитрий, completed, 28.04.2026): MacBook Air M3
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-28 16:00:00'), (SELECT id FROM products WHERE name='MacBook Air M3'), 1, 117000.00),
-- Заказ 21 (Дмитрий, completed, 12.05.2026): Samsung Galaxy S24 + Xiaomi Mi Band 8
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-05-12 13:45:00'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 1, 99990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-05-12 13:45:00'), (SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), 1, 3990.00),
-- Заказ 22 (Дмитрий, shipped, 22.06.2026): HP LaserJet Pro
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-06-22 10:20:00'), (SELECT id FROM products WHERE name='HP LaserJet Pro'), 2, 18500.00),
-- Заказ 23 (Дмитрий, completed, 08.07.2026): Xiaomi Robot Vacuum
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-07-08 09:10:00'), (SELECT id FROM products WHERE name='Xiaomi Robot Vacuum'), 1, 29000.00),

-- Заказ 24 (Ольга, completed, 14.04.2026): Asus Zenbook 14
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-04-14 15:30:00'), (SELECT id FROM products WHERE name='Asus Zenbook 14'), 1, 89990.00),
-- Заказ 25 (Ольга, processing, 25.05.2026): Samsung Galaxy Tab S9 + AirPods Pro
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-05-25 11:00:00'), (SELECT id FROM products WHERE name='Samsung Galaxy Tab S9'), 1, 79990.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-05-25 11:00:00'), (SELECT id FROM products WHERE name='AirPods Pro'), 1, 24990.00),
-- Заказ 26 (Ольга, completed, 28.06.2026): iPhone 15 Pro + Xiaomi 14
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-06-28 12:30:00'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 1, 129000.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-06-28 12:30:00'), (SELECT id FROM products WHERE name='Xiaomi 14'), 1, 68000.00),

-- Заказ 27 (Сергей, completed, 22.04.2026): Bosch Serie 4
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-04-22 09:50:00'), (SELECT id FROM products WHERE name='Bosch Serie 4'), 1, 59990.00),
-- Заказ 28 (Сергей, cancelled, 05.07.2026): Samsung 55" QLED
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-07-05 14:00:00'), (SELECT id FROM products WHERE name='Samsung 55" QLED'), 1, 105000.00),

-- Заказ 29 (Татьяна, completed, 30.04.2026): Adidas T-shirt
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='tatyana.pavlova@example.com') AND created_at='2026-04-30 10:00:00'), (SELECT id FROM products WHERE name='Adidas T-shirt'), 1, 2990.00),

-- Заказ 30 (Николай, completed, 03.05.2026): HP Spectre x360
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-05-03 16:20:00'), (SELECT id FROM products WHERE name='HP Spectre x360'), 1, 139990.00),
-- Заказ 31 (Николай, completed, 18.06.2026): Asus ROG Phone 8
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-06-18 11:40:00'), (SELECT id FROM products WHERE name='Asus ROG Phone 8'), 1, 89990.00),

-- Заказ 32 (Юлия, completed, 11.04.2026): MacBook Air M3
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-04-11 13:10:00'), (SELECT id FROM products WHERE name='MacBook Air M3'), 1, 119990.00),
-- Заказ 33 (Юлия, completed, 19.05.2026): iPhone 15 Pro + AirPods Pro + Xiaomi Mi Band 8
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-05-19 10:50:00'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 1, 128000.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-05-19 10:50:00'), (SELECT id FROM products WHERE name='AirPods Pro'), 1, 24000.00),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-05-19 10:50:00'), (SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), 2, 3800.00),
-- Заказ 34 (Юлия, new, 01.07.2026): Samsung Galaxy S24
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-07-01 15:00:00'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 1, 99990.00),

-- Заказ 35 (Виктор, completed, 07.05.2026): Xiaomi 14
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='viktor.popov@example.com') AND created_at='2026-05-07 12:00:00'), (SELECT id FROM products WHERE name='Xiaomi 14'), 1, 69990.00),

-- Заказ 36 (Наталья, completed, 16.04.2026): Adidas Ultraboost
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-04-16 14:45:00'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 1, 15990.00),
-- Заказ 37 (Наталья, processing, 30.06.2026): Bosch MUM5
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-06-30 11:30:00'), (SELECT id FROM products WHERE name='Bosch MUM5'), 1, 34990.00);

-- =====================================================
-- 9. ПЛАТЕЖИ (payments)
-- =====================================================
INSERT INTO payments (order_id, amount, p_type, status, created_at) VALUES
-- Заказ 1: успешный платеж
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-05 10:00:00'), 177970.00, 'card', 'paid', '2026-04-05 10:05:00'),
-- Заказ 2: успешный платеж
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-15 14:30:00'), 125000.00, 'sbp', 'paid', '2026-04-15 14:35:00'),
-- Заказ 3: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-02 09:20:00'), 98990.00, 'card', 'paid', '2026-05-02 09:25:00'),
-- Заказ 4: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-20 18:10:00'), 184980.00, 'cash', 'pending', '2026-05-20 18:15:00'),
-- Заказ 5: два платежа (failed потом paid)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-06-10 11:45:00'), 127000.00, 'card', 'failed', '2026-06-10 11:50:00'),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-06-10 11:45:00'), 127000.00, 'card', 'paid', '2026-06-10 12:00:00'),
-- Заказ 6: pending (новый заказ)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-07-01 08:00:00'), 29990.00, 'sbp', 'pending', '2026-07-01 08:05:00'),
-- Заказ 7: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-04-08 12:00:00'), 149980.00, 'card', 'paid', '2026-04-08 12:05:00'),
-- Заказ 8: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-05-15 16:40:00'), 21970.00, 'sbp', 'paid', '2026-05-15 16:45:00'),
-- Заказ 9: refunded (отменен)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-06-20 10:15:00'), 85000.00, 'card', 'refunded', '2026-06-20 11:00:00'),
-- Заказ 10: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='petr.sidorov@example.com') AND created_at='2026-04-20 13:25:00'), 69990.00, 'card', 'paid', '2026-04-20 13:30:00'),
-- Заказ 11: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-04-25 10:30:00'), 59990.00, 'cash', 'paid', '2026-04-25 11:00:00'),
-- Заказ 12: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-06-05 15:50:00'), 124980.00, 'sbp', 'paid', '2026-06-05 15:55:00'),
-- Заказ 13: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-04-12 09:00:00'), 249990.00, 'card', 'paid', '2026-04-12 09:05:00'),
-- Заказ 14: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-05-08 17:20:00'), 158000.00, 'card', 'paid', '2026-05-08 17:25:00'),
-- Заказ 15: два платежа (pending)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-06-15 12:00:00'), 134980.00, 'sbp', 'pending', '2026-06-15 12:05:00'),
-- Заказ 16: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-07-10 14:30:00'), 69990.00, 'card', 'paid', '2026-07-10 14:35:00'),
-- Заказ 17: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-04-18 11:10:00'), 2750.00, 'cash', 'paid', '2026-04-18 11:20:00'),
-- Заказ 18: refunded
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-06-02 09:40:00'), 15990.00, 'card', 'refunded', '2026-06-02 10:00:00'),
-- Заказ 19: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-10 08:30:00'), 128500.00, 'card', 'paid', '2026-04-10 08:35:00'),
-- Заказ 20: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-28 16:00:00'), 117000.00, 'sbp', 'paid', '2026-04-28 16:05:00'),
-- Заказ 21: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-05-12 13:45:00'), 103980.00, 'card', 'paid', '2026-05-12 13:50:00'),
-- Заказ 22: failed + paid
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-06-22 10:20:00'), 37000.00, 'card', 'failed', '2026-06-22 10:25:00'),
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-06-22 10:20:00'), 37000.00, 'sbp', 'paid', '2026-06-22 10:40:00'),
-- Заказ 23: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-07-08 09:10:00'), 29000.00, 'card', 'paid', '2026-07-08 09:15:00'),
-- Заказ 24: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-04-14 15:30:00'), 89990.00, 'card', 'paid', '2026-04-14 15:35:00'),
-- Заказ 25: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-05-25 11:00:00'), 104980.00, 'sbp', 'pending', '2026-05-25 11:05:00'),
-- Заказ 26: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-06-28 12:30:00'), 197000.00, 'card', 'paid', '2026-06-28 12:35:00'),
-- Заказ 27: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-04-22 09:50:00'), 59990.00, 'cash', 'paid', '2026-04-22 10:00:00'),
-- Заказ 28: refunded
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-07-05 14:00:00'), 105000.00, 'card', 'refunded', '2026-07-05 14:30:00'),
-- Заказ 29: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='tatyana.pavlova@example.com') AND created_at='2026-04-30 10:00:00'), 2990.00, 'sbp', 'paid', '2026-04-30 10:05:00'),
-- Заказ 30: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-05-03 16:20:00'), 139990.00, 'card', 'paid', '2026-05-03 16:25:00'),
-- Заказ 31: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-06-18 11:40:00'), 89990.00, 'card', 'paid', '2026-06-18 11:45:00'),
-- Заказ 32: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-04-11 13:10:00'), 119990.00, 'card', 'paid', '2026-04-11 13:15:00'),
-- Заказ 33: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-05-19 10:50:00'), 155600.00, 'sbp', 'paid', '2026-05-19 10:55:00'),
-- Заказ 34: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-07-01 15:00:00'), 99990.00, 'card', 'pending', '2026-07-01 15:05:00'),
-- Заказ 35: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='viktor.popov@example.com') AND created_at='2026-05-07 12:00:00'), 69990.00, 'card', 'paid', '2026-05-07 12:05:00'),
-- Заказ 36: успешный
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-04-16 14:45:00'), 15990.00, 'cash', 'paid', '2026-04-16 15:00:00'),
-- Заказ 37: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-06-30 11:30:00'), 34990.00, 'sbp', 'pending', '2026-06-30 11:35:00');

-- =====================================================
-- 10. ДОСТАВКИ (deliveries)
-- =====================================================
INSERT INTO deliveries (order_id, status, delivery_cost, shipped_at, delivered_at) VALUES
-- Заказ 1: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-05 10:00:00'), 'delivered', 500.00, '2026-04-06 10:00:00', '2026-04-08 15:00:00'),
-- Заказ 2: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-04-15 14:30:00'), 'delivered', 500.00, '2026-04-16 09:00:00', '2026-04-19 12:00:00'),
-- Заказ 3: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-02 09:20:00'), 'delivered', 400.00, '2026-05-03 11:00:00', '2026-05-06 10:00:00'),
-- Заказ 4: pending (processing заказ)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-05-20 18:10:00'), 'pending', 500.00, NULL, NULL),
-- Заказ 5: shipped
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='ivan.petrov@example.com') AND created_at='2026-06-10 11:45:00'), 'shipped', 500.00, '2026-06-11 12:00:00', NULL),
-- Заказ 6: нет доставки (new)
-- Заказ 7: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-04-08 12:00:00'), 'delivered', 700.00, '2026-04-09 10:00:00', '2026-04-12 14:00:00'),
-- Заказ 8: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-05-15 16:40:00'), 'delivered', 300.00, '2026-05-16 09:00:00', '2026-05-18 11:00:00'),
-- Заказ 9: cancelled (заказ отменен)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='anna.smirnova@example.com') AND created_at='2026-06-20 10:15:00'), 'cancelled', 500.00, NULL, NULL),
-- Заказ 10: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='petr.sidorov@example.com') AND created_at='2026-04-20 13:25:00'), 'delivered', 400.00, '2026-04-21 10:00:00', '2026-04-23 15:00:00'),
-- Заказ 11: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-04-25 10:30:00'), 'delivered', 500.00, '2026-04-26 10:00:00', '2026-04-29 12:00:00'),
-- Заказ 12: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='maria.kuznetsova@example.com') AND created_at='2026-06-05 15:50:00'), 'delivered', 700.00, '2026-06-06 10:00:00', '2026-06-09 14:00:00'),
-- Заказ 13: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-04-12 09:00:00'), 'delivered', 800.00, '2026-04-13 09:00:00', '2026-04-16 13:00:00'),
-- Заказ 14: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-05-08 17:20:00'), 'delivered', 600.00, '2026-05-09 10:00:00', '2026-05-12 15:00:00'),
-- Заказ 15: pending (processing)
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-06-15 12:00:00'), 'pending', 700.00, NULL, NULL),
-- Заказ 16: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='alexey.ivanov@example.com') AND created_at='2026-07-10 14:30:00'), 'delivered', 400.00, '2026-07-11 10:00:00', '2026-07-14 12:00:00'),
-- Заказ 17: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-04-18 11:10:00'), 'delivered', 300.00, '2026-04-19 09:00:00', '2026-04-21 10:00:00'),
-- Заказ 18: cancelled
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='elena.volkova@example.com') AND created_at='2026-06-02 09:40:00'), 'cancelled', 300.00, NULL, NULL),
-- Заказ 19: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-10 08:30:00'), 'delivered', 500.00, '2026-04-11 10:00:00', '2026-04-14 15:00:00'),
-- Заказ 20: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-04-28 16:00:00'), 'delivered', 500.00, '2026-04-29 09:00:00', '2026-05-02 11:00:00'),
-- Заказ 21: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-05-12 13:45:00'), 'delivered', 400.00, '2026-05-13 10:00:00', '2026-05-15 12:00:00'),
-- Заказ 22: shipped
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-06-22 10:20:00'), 'shipped', 300.00, '2026-06-23 09:00:00', NULL),
-- Заказ 23: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='dmitry.kozlov@example.com') AND created_at='2026-07-08 09:10:00'), 'delivered', 400.00, '2026-07-09 10:00:00', '2026-07-11 14:00:00'),
-- Заказ 24: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-04-14 15:30:00'), 'delivered', 500.00, '2026-04-15 10:00:00', '2026-04-17 12:00:00'),
-- Заказ 25: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-05-25 11:00:00'), 'pending', 600.00, NULL, NULL),
-- Заказ 26: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='olga.novikova@example.com') AND created_at='2026-06-28 12:30:00'), 'delivered', 600.00, '2026-06-29 10:00:00', '2026-07-02 13:00:00'),
-- Заказ 27: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-04-22 09:50:00'), 'delivered', 500.00, '2026-04-23 10:00:00', '2026-04-26 15:00:00'),
-- Заказ 28: cancelled
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='sergey.morozov@example.com') AND created_at='2026-07-05 14:00:00'), 'cancelled', 500.00, NULL, NULL),
-- Заказ 29: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='tatyana.pavlova@example.com') AND created_at='2026-04-30 10:00:00'), 'delivered', 300.00, '2026-05-01 10:00:00', '2026-05-03 11:00:00'),
-- Заказ 30: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-05-03 16:20:00'), 'delivered', 600.00, '2026-05-04 10:00:00', '2026-05-07 14:00:00'),
-- Заказ 31: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='nikolay.sokolov@example.com') AND created_at='2026-06-18 11:40:00'), 'delivered', 500.00, '2026-06-19 10:00:00', '2026-06-22 12:00:00'),
-- Заказ 32: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-04-11 13:10:00'), 'delivered', 500.00, '2026-04-12 10:00:00', '2026-04-15 15:00:00'),
-- Заказ 33: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='yulia.lebedeva@example.com') AND created_at='2026-05-19 10:50:00'), 'delivered', 500.00, '2026-05-20 10:00:00', '2026-05-23 11:00:00'),
-- Заказ 34: нет доставки (new)
-- Заказ 35: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='viktor.popov@example.com') AND created_at='2026-05-07 12:00:00'), 'delivered', 400.00, '2026-05-08 10:00:00', '2026-05-10 12:00:00'),
-- Заказ 36: delivered
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-04-16 14:45:00'), 'delivered', 300.00, '2026-04-17 10:00:00', '2026-04-19 11:00:00'),
-- Заказ 37: pending
((SELECT id FROM orders WHERE user_id=(SELECT id FROM users WHERE email='natalya.semenova@example.com') AND created_at='2026-06-30 11:30:00'), 'pending', 400.00, NULL, NULL);

-- =====================================================
-- 11. ОТЗЫВЫ (reviews)
-- =====================================================
INSERT INTO reviews (user_id, product_id, rating, review, created_at) VALUES
-- Отзывы на популярные товары
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 5, 'Отличный телефон!', '2026-04-10 12:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 4, 'Хорош, но дороговат.', '2026-04-15 10:00:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 3, 'Камера не оправдала ожиданий.', '2026-05-25 15:00:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM products WHERE name='iPhone 15 Pro'), 5, NULL, '2026-07-01 10:30:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='MacBook Air M3'), 5, 'Очень доволен.', '2026-04-20 09:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM products WHERE name='MacBook Air M3'), 4, 'Легкий и быстрый.', '2026-05-05 11:00:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM products WHERE name='MacBook Air M3'), 5, NULL, '2026-04-15 14:00:00'),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 4, 'Хороший экран.', '2026-05-20 16:00:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 5, 'Отличная производительность.', '2026-05-07 10:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 3, 'Батарея слабовата.', '2026-05-15 12:00:00'),
((SELECT id FROM users WHERE email='petr.sidorov@example.com'), (SELECT id FROM products WHERE name='Xiaomi 14'), 4, 'Цена-качество супер.', '2026-04-25 10:00:00'),
((SELECT id FROM users WHERE email='viktor.popov@example.com'), (SELECT id FROM products WHERE name='Xiaomi 14'), 5, NULL, '2026-05-10 09:30:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM products WHERE name='Xiaomi 14'), 4, 'Хороший, но камера средняя.', '2026-07-03 11:00:00'),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM products WHERE name='AirPods Pro'), 5, 'Звук отличный.', '2026-04-10 15:00:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='AirPods Pro'), 4, 'Удобные, но дорогие.', '2026-04-08 10:00:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM products WHERE name='AirPods Pro'), 3, 'Иногда отваливаются.', '2026-05-30 12:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM products WHERE name='AirPods Pro'), 2, 'Не подошли, вернул.', '2026-06-20 14:00:00'),
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), (SELECT id FROM products WHERE name='Bosch Serie 4'), 5, 'Стирает отлично.', '2026-04-30 10:00:00'),
((SELECT id FROM users WHERE email='sergey.morozov@example.com'), (SELECT id FROM products WHERE name='Bosch Serie 4'), 4, NULL, '2026-04-25 11:00:00'),
((SELECT id FROM users WHERE email='natalya.semenova@example.com'), (SELECT id FROM products WHERE name='Bosch MUM5'), 4, 'Хороший комбайн.', '2026-07-02 10:00:00'),
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), (SELECT id FROM products WHERE name='Bosch KGN39'), 5, 'Большой холодильник.', '2026-06-10 15:00:00'),
((SELECT id FROM users WHERE email='elena.volkova@example.com'), (SELECT id FROM products WHERE name='Война и мир'), 5, 'Классика.', '2026-04-20 12:00:00'),
((SELECT id FROM users WHERE email='elena.volkova@example.com'), (SELECT id FROM products WHERE name='Преступление и наказание'), 4, 'Тяжеловато, но интересно.', '2026-04-21 10:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM products WHERE name='MacBook Pro 16'), 5, 'Мощный!', '2026-04-15 12:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM products WHERE name='Asus ROG Strix G16'), 4, 'Игровой ноут, тянет всё.', '2026-05-10 15:00:00'),
((SELECT id FROM users WHERE email='nikolay.sokolov@example.com'), (SELECT id FROM products WHERE name='HP Spectre x360'), 4, 'Красивый, но шумный.', '2026-05-05 11:00:00'),
((SELECT id FROM users WHERE email='nikolay.sokolov@example.com'), (SELECT id FROM products WHERE name='Asus ROG Phone 8'), 5, 'Игровой смартфон супер.', '2026-06-20 14:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), 4, 'Дешево и сердито.', '2026-04-18 10:00:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), 3, 'Шаги считает неточно.', '2026-05-25 12:00:00'),
((SELECT id FROM users WHERE email='anna.smirnova@example.com'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 5, 'Очень удобные.', '2026-05-18 16:00:00'),
((SELECT id FROM users WHERE email='tatyana.pavlova@example.com'), (SELECT id FROM products WHERE name='Adidas T-shirt'), 4, 'Качественная футболка.', '2026-05-02 11:00:00'),
((SELECT id FROM users WHERE email='olga.novikova@example.com'), (SELECT id FROM products WHERE name='Asus Zenbook 14'), 5, 'Легкий и быстрый.', '2026-04-18 10:00:00'),
((SELECT id FROM users WHERE email='alexey.ivanov@example.com'), (SELECT id FROM products WHERE name='Samsung 55" QLED'), 5, 'Картинка супер.', '2026-06-18 14:00:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='Xiaomi Robot Vacuum'), 4, 'Хорошо убирает, но шумный.', '2026-07-05 10:00:00'),
((SELECT id FROM users WHERE email='dmitry.kozlov@example.com'), (SELECT id FROM products WHERE name='HP LaserJet Pro'), 4, NULL, '2026-06-25 11:00:00'),
((SELECT id FROM users WHERE email='maria.kuznetsova@example.com'), (SELECT id FROM products WHERE name='Bosch MUM5'), 5, NULL, '2026-06-08 12:00:00'),
((SELECT id FROM users WHERE email='yulia.lebedeva@example.com'), (SELECT id FROM products WHERE name='Samsung Galaxy S24'), 4, 'Хороший, но дорогой.', '2026-07-02 15:00:00'),
((SELECT id FROM users WHERE email='ivan.petrov@example.com'), (SELECT id FROM products WHERE name='HP Spectre x360'), 3, 'Греется.', '2026-05-22 10:00:00'),
((SELECT id FROM users WHERE email='elena.volkova@example.com'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 4, NULL, '2026-06-05 12:00:00'),
((SELECT id FROM users WHERE email='natalya.semenova@example.com'), (SELECT id FROM products WHERE name='Adidas Ultraboost'), 5, 'Лучшие кроссовки.', '2026-04-20 10:00:00');

-- =====================================================
-- 12. АКЦИИ (promotions)
-- =====================================================
INSERT INTO promotions (name, percent, starts_at, ends_at) VALUES
('Весенняя распродажа', 10, '2026-03-01 00:00:00', '2026-04-30 23:59:59'),
('Летняя распродажа', 15, '2026-06-01 00:00:00', '2026-08-31 23:59:59'),
('Скидки на электронику', 20, '2026-04-01 00:00:00', '2026-05-15 23:59:59'),
('Черная пятница', 30, '2026-07-01 00:00:00', '2026-07-31 23:59:59'),
('Акция на аксессуары', 12, '2026-05-01 00:00:00', '2026-06-30 23:59:59'),
('Распродажа книг', 25, '2026-04-15 00:00:00', '2026-05-15 23:59:59');

-- =====================================================
-- 13. СВЯЗИ ТОВАР-АКЦИЯ (product_promotions)
-- =====================================================
INSERT INTO product_promotions (product_id, promotion_id) VALUES
-- iPhone 15 Pro участвует в весенней, летней и черной пятнице
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM promotions WHERE name='Весенняя распродажа')),
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM promotions WHERE name='Летняя распродажа')),
((SELECT id FROM products WHERE name='iPhone 15 Pro'), (SELECT id FROM promotions WHERE name='Черная пятница')),
-- MacBook Air M3: весенняя и скидки на электронику
((SELECT id FROM products WHERE name='MacBook Air M3'), (SELECT id FROM promotions WHERE name='Весенняя распродажа')),
((SELECT id FROM products WHERE name='MacBook Air M3'), (SELECT id FROM promotions WHERE name='Скидки на электронику')),
-- AirPods Pro: акция на аксессуары
((SELECT id FROM products WHERE name='AirPods Pro'), (SELECT id FROM promotions WHERE name='Акция на аксессуары')),
-- Samsung Galaxy S24: весенняя и летняя
((SELECT id FROM products WHERE name='Samsung Galaxy S24'), (SELECT id FROM promotions WHERE name='Весенняя распродажа')),
((SELECT id FROM products WHERE name='Samsung Galaxy S24'), (SELECT id FROM promotions WHERE name='Летняя распродажа')),
-- Xiaomi 14: скидки на электронику
((SELECT id FROM products WHERE name='Xiaomi 14'), (SELECT id FROM promotions WHERE name='Скидки на электронику')),
-- Adidas Ultraboost: летняя распродажа
((SELECT id FROM products WHERE name='Adidas Ultraboost'), (SELECT id FROM promotions WHERE name='Летняя распродажа')),
-- Война и мир: распродажа книг
((SELECT id FROM products WHERE name='Война и мир'), (SELECT id FROM promotions WHERE name='Распродажа книг')),
-- Преступление и наказание: распродажа книг
((SELECT id FROM products WHERE name='Преступление и наказание'), (SELECT id FROM promotions WHERE name='Распродажа книг')),
-- Asus ROG Strix G16: скидки на электронику
((SELECT id FROM products WHERE name='Asus ROG Strix G16'), (SELECT id FROM promotions WHERE name='Скидки на электронику')),
-- HP Spectre x360: скидки на электронику
((SELECT id FROM products WHERE name='HP Spectre x360'), (SELECT id FROM promotions WHERE name='Скидки на электронику')),
-- Samsung 55" QLED: летняя распродажа
((SELECT id FROM products WHERE name='Samsung 55" QLED'), (SELECT id FROM promotions WHERE name='Летняя распродажа')),
-- Xiaomi Mi Band 8: акция на аксессуары
((SELECT id FROM products WHERE name='Xiaomi Mi Band 8'), (SELECT id FROM promotions WHERE name='Акция на аксессуары')),
-- Bosch Serie 4: весенняя распродажа
((SELECT id FROM products WHERE name='Bosch Serie 4'), (SELECT id FROM promotions WHERE name='Весенняя распродажа'));