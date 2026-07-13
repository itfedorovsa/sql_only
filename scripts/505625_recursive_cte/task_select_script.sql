-- ЗАДАЧА 1
-- Обход сверху вниз (Построение дерева): Напишите запрос с использованием WITH RECURSIVE,
-- который начинается от корневой папки Projects (id=1), выведет дерево всех её подпапок.

-- Выведите название папки с отступами (через repeat(' ', уровень - 1)).
-- Выведите уровень вложенности (level).
-- Обязательно используйте конструкцию CYCLE ... SET ... USING ... (считаем, что у вас PostgreSQL 14+) для защиты от зацикливания.
-- В итоговом результате не должно быть строк, образующих цикл (отфильтруйте их).
-- Отсортируйте результат так, чтобы дерево выводилось корректно (используйте текстовый путь или массив).

WITH RECURSIVE f_cte AS (
    SELECT f.id, f.name, f.parent_id, 1 AS LEVEL, f.name::text AS tree_path
    FROM folders AS f
    WHERE id = 1
    UNION ALL
    SELECT fl.id, fl.name, fl.parent_id, cte.level + 1 AS LEVEL, cte.tree_path || ' -> ' || fl.name AS tree_path
    FROM folders AS fl
    JOIN f_cte AS cte ON cte.id = fl.parent_id
)
CYCLE id SET is_cycle USING path
SELECT id, name, level, repeat('  ', level - 1) || name AS formatted_name
FROM f_cte
ORDER BY tree_path;


-- ЗАДАЧА 2
-- Обход снизу вверх (Хлебные крошки): Напишите запрос, который для папки utils (id=10) построит полный путь от корня: Projects -> Frontend -> React -> components -> utils.

-- Используйте массивы для сбора пути.
-- Превратите массив в строку через разделитель ' -> ' с помощью array_to_string.
-- Также примените защиту от циклов CYCLE.

WITH RECURSIVE f_cte AS (
    SELECT f.id, f.name, f.parent_id, ARRAY[f.name] AS tree_path
    FROM folders AS f
    WHERE f.id = 10
    UNION ALL
    SELECT fl.id, fl.name, fl.parent_id, fl.name || c.tree_path
    FROM folders fl
    JOIN f_cte AS c ON c.parent_id = fl.id
)
CYCLE id SET is_cycle USING path
SELECT id, name, parent_id, array_to_string(tree_path, ' -> ')
FROM f_cte
WHERE parent_id IS NULL;