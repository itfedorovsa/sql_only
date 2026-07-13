-- Пример 1-1. Категории каталога (с защитой от цикла)

WITH RECURSIVE breadcrumb AS (
    -- 1. Базовая часть
    SELECT
        id, name, parent_id,
        ARRAY[name] AS path_array
    FROM categories
    WHERE id = 156

    UNION ALL

    -- 2. Рекурсивная часть
    SELECT
        c.id, c.name, c.parent_id,
        c.name || breadcrumb.path_array
    FROM categories c
    JOIN breadcrumb ON c.id = breadcrumb.parent_id
)
-- 3. ПОДКЛЮЧАЕМ ЗАЩИТУ ОТ ЗАЦИКЛИВАНИЯ
CYCLE id SET is_cycle USING cycle_path

-- 4. Финальный запрос (отсекаем проблемные ветки)
SELECT
    id,
    array_to_string(path_array, ' -> ') AS full_breadcrumb
FROM breadcrumb
WHERE parent_id IS NULL
  AND is_cycle = false; -- Игнорируем ветки, где найден цикл



-- Пример 2-1. Сотрудники и подразделения (с защитой от цикла)

-- Примечание: Если вы хотите не просто отфильтровать зацикленных сотрудников, а, например, пометить их в отчете,
-- вы можете заменить WHERE is_cycle = false на вывод колонки is_cycle, чтобы видеть, кто именно вызывает проблему.

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



-- Пример 3-1. Дерево комментариев (с защитой от цикла)

WITH RECURSIVE comment_thread AS (
    -- 1. Базовая часть
    SELECT
        id, parent_id, author, text, created_at,
        ARRAY[id] AS thread_path
    FROM comments
    WHERE id = 42 AND post_id = 100

    UNION ALL

    -- 2. Рекурсивная часть
    SELECT
        c.id, c.parent_id, c.author, c.text, c.created_at,
        ct.thread_path || c.id
    FROM comments c
    JOIN comment_thread ct ON c.parent_id = ct.id
    WHERE c.post_id = 100
)
-- 3. ПОДКЛЮЧАЕМ ЗАЩИТУ ОТ ЗАЦИКЛИВАНИЯ
CYCLE id SET is_cycle USING cycle_path

-- 4. Финальный запрос
SELECT
    id,
    author,
    text,
    created_at
FROM comment_thread
WHERE is_cycle = false -- Прячем "закольцованные" комментарии из ветки
ORDER BY thread_path;