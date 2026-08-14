-- Таблица пользователей
CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица подписок
CREATE TABLE IF NOT EXISTS subscriptions (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    plan_name VARCHAR(100) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- Таблица фильмов
CREATE TABLE IF NOT EXISTS movies (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    release_year INTEGER,
    duration_minutes INTEGER
);

-- Таблица истории просмотров
CREATE TABLE IF NOT EXISTS views (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    movie_id BIGINT NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    watched_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    watch_time_minutes INTEGER
);

-- Таблица платежей
CREATE TABLE IF NOT EXISTS payments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    paid_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Таблица отзывов
CREATE TABLE IF NOT EXISTS reviews (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    movie_id BIGINT NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating BETWEEN 1 AND 10),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- представление для упрощения сложных запросов
CREATE VIEW v_movie_views AS
SELECT v.id AS view_id, u.full_name, m.title, v.watched_at, v.watch_time_minutes
FROM movies AS m
JOIN views AS v ON v.movie_id = m.id
JOIN users AS u ON u.id = v.user_id;

SELECT * FROM v_movie_views;

-- представление для ограничения доступа к данным
CREATE VIEW v_support_users AS
SELECT id, full_name, email, created_at
FROM users;

SELECT * FROM v_support_users;

-- представление для маскирования данных
CREATE VIEW v_delivery_users AS
SELECT id, full_name, lpad(right(phone, 4), length(phone), '*') AS masked_phone
FROM users;

SELECT * FROM v_delivery_users;

-- представление с проверкой обновлений
CREATE VIEW v_active_subscriptions AS
SELECT * FROM subscriptions
WHERE is_active = TRUE
WITH CHECK OPTION;

SELECT * FROM v_active_subscriptions;

-- материализованное представление
CREATE MATERIALIZED VIEW mv_movie_statistics AS
SELECT
v.movie_id,
m.title,
COUNT(v.id) AS total_views,
SUM(v.watch_time_minutes) AS total_watch_time
FROM movies m
JOIN views v ON v.movie_id = m.id
GROUP BY v.movie_id, m.title
WITH NO DATA;

REFRESH MATERIALIZED VIEW mv_movie_statistics;

SELECT * FROM mv_movie_statistics;