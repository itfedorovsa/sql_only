CREATE TABLE IF NOT EXISTS empl_hier (
    id integer PRIMARY KEY,
    name text,
    position text,
    manager_id integer
);

INSERT INTO empl_hier (id, name, position, manager_id) VALUES
    (1, 'Иванов', 'Директор', null),
    (2, 'Петров', 'Руководитель IT', 1),
    (3, 'Сидоров', 'Разработчик', 2),
    (4, 'Иванова', 'Тестировщик', 2),
    (5, 'Петрова', 'Бухгалтер', 1)
;


WITH RECURSIVE org_tree AS (
    -- 1. БАЗОВАЯ ЧАСТЬ: Начинаем с директора
    SELECT
        id,
        name,
        position,
        manager_id,
        -- Для директора уровень = 1
        1 AS level,
        -- Формируем текстовый путь для красивой сортировки
        name::text AS tree_path
    FROM empl_hier
    WHERE id = 1

    UNION ALL

    -- 2. РЕКУРСИВНАЯ ЧАСТЬ: Ищем всех, кто подчиняется людям из предыдущего шага
    SELECT
        e.id,
        e.name,
        e.position,
        e.manager_id,
        -- Увеличиваем уровень на 1
        ot.level + 1 AS level,
        -- Добавляем нового сотрудника в путь
        ot.tree_path || ' -> ' || e.name::text AS tree_path
    FROM empl_hier e
    JOIN org_tree ot ON e.manager_id = ot.id
)
-- 3. ФИНАЛЬНЫЙ ЗАПРОС
SELECT
    repeat('  ', level - 1) || name AS formatted_name, -- отступы для наглядности
    position,
    level
FROM org_tree
ORDER BY tree_path; -- Сортируем по пути, чтобы дерево выводилось правильно



-- CYCLE DEMO

WITH RECURSIVE org_tree AS (
    -- 1. Базовая часть
    SELECT
        id, name, position, manager_id,
        1 AS level,
        name::text AS tree_path
    FROM empl_hier
    WHERE id = 1

    UNION ALL

    -- 2. Рекурсивная часть
    SELECT
        e.id, e.name, e.position, e.manager_id,
        ot.level + 1,
        ot.tree_path || ' -> ' || e.name::text
    FROM empl_hier e
    JOIN org_tree ot ON e.manager_id = ot.id
)
-- 3. ПОДКЛЮЧАЕМ ЗАЩИТУ ОТ ЗАЦИКЛИВАНИЯ
CYCLE id SET is_cycle USING cycle_path

-- 4. Финальный запрос
SELECT
    repeat('  ', level - 1) || name AS formatted_name,
    position,
    level
FROM org_tree
WHERE is_cycle = false -- Выводим только тех, кто не образует петлю
ORDER BY tree_path;