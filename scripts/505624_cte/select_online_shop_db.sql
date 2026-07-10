-- Структура БД для ДЗ:
-- categories (id, name, parent_id) — иерархия категорий (parent_id может быть NULL для корневых).
-- products (id, name, category_id, price) — товары.
-- order_items (order_id, product_id, quantity) — состав заказов (для простоты опускаем таблицу заказов и считаем,
-- что каждый order_id — это отдельный завершенный заказ).


--Задача 1. Декомпозиция и множественные CTE Выведите названия категорий товаров и общую сумму выручки по каждой из них.
-- В результат должны попасть только те категории, чья выручка строго больше средней выручки по всем категориям.
-- Требование: Использовать минимум два CTE. Первое CTE должно считать выручку по каждому товару (сумма цены * количество),
-- второе — агрегировать её по категориям и считать общую среднюю. Запрос должен быть легко читаемым.

WITH sum_ctg_revenue AS (
	SELECT c.id AS ctg_id, c.name AS ctg_name, SUM(oi.quantity * p.price) AS sum_ctg
	FROM categories AS c
	JOIN products AS p ON p.category_id = c.id
	JOIN order_items AS oi ON oi.product_id = p.id
	GROUP BY c.id, c.name
),

avg_ctg_revenue AS (
	SELECT AVG(sum_ctg) AS avg_ctg FROM sum_ctg_revenue
)

SELECT ctg_name, sum_ctg
FROM sum_ctg_revenue
CROSS JOIN avg_ctg_revenue
WHERE sum_ctg > avg_ctg;



-- Задача 2. Рекурсивное CTE (Иерархия) Напишите запрос, который выведет полный путь (иерархию) подкатегорий
-- для категории «Компьютеры» (предположим, её id = 1). Требование: Использовать WITH RECURSIVE.
-- Вывести id, name категории и level (уровень вложенности, где корневая категория «Компьютеры» — это уровень 1).
-- Результат отсортировать по уровню вложенности.

WITH RECURSIVE ctg_hierarchy AS (
	SELECT c.id AS ctg_id, c.name AS ctg_name, c.parent_id, 1 AS level
	FROM categories AS c
	WHERE c.id = 1

UNION ALL

SELECT ct.id AS ctg_id, ct.name AS ctg_name, ct.parent_id, ch.level + 1
FROM categories AS ct
JOIN ctg_hierarchy AS ch ON ch.ctg_id = ct.parent_id
)

SELECT chr.ctg_id, chr.ctg_name, chr.level
FROM ctg_hierarchy chr
ORDER BY level ASC;