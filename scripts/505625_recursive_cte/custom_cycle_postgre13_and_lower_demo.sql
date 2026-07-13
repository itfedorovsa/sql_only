WITH RECURSIVE org_tree AS (
    SELECT
        id, name, manager_id,
        1 AS level,
        ARRAY[id] AS visited_ids -- Вручную собираем массив ID
    FROM employees WHERE id = 1

    UNION ALL

    SELECT
        e.id, e.name, e.manager_id,
        ot.level + 1,
        ot.visited_ids || e.id -- Добавляем новый ID в массив
    FROM employees e
    JOIN org_tree ot ON e.manager_id = ot.id
    -- РУЧНАЯ ЗАЩИТА: следующий ID не должен уже быть в массиве пройденных
    WHERE e.id <> ALL(ot.visited_ids)
)
SELECT * FROM org_tree ORDER BY visited_ids;