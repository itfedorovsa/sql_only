CREATE TABLE IF NOT EXISTS categories (
    id    integer PRIMARY KEY,
    name  text,
    parent_id integer
);

INSERT INTO categories (id, name, parent_id) VALUES
    (1, 'электроника', null),
    (2, 'телефоны', 1),
    (3, 'телевизоры', 1),
    (4, 'smart_телевизоры', 3),
    (5, 'led_телевизоры', 3),
    (6, 'кноп_телефоны', 2),
    (7, 'смартфоны', 2),
    (8, 'смартфоны Nokia', 7),
    (9, 'смартфоны Apple', 7)
;


WITH RECURSIVE breadcrumb AS (
    -- 1. БАЗОВАЯ ЧАСТЬ: Находим нашу стартовую категорию
    SELECT
        id,
        name,
        parent_id,
        -- Создаем массив и сразу кладем в него текущее имя
        ARRAY[name] AS path_array
    FROM categories
    WHERE id = 9 -- ID смартфонов Apple

    UNION ALL

    -- 2. РЕКУРСИВНАЯ ЧАСТЬ: Идем UP по дереву к родителям
    SELECT
        c.id,
        c.name,
        c.parent_id,
        -- Добавляем имя родителя В НАЧАЛО массива (индекс 0)
        c.name || breadcrumb.path_array
    FROM categories c
    -- Присоединяем таблицу к результатам предыдущего шага
    JOIN breadcrumb ON c.id = breadcrumb.parent_id
)
-- 3. ФИНАЛЬНЫЙ ЗАПРОС: Берем самую верхнюю строку (где parent_id IS NULL)
SELECT
    id,
    array_to_string(path_array, ' -> ') AS full_breadcrumb
FROM breadcrumb
WHERE parent_id IS NULL;