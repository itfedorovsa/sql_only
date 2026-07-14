-- Напишите скрипт с использованием оконных функций, который позволяет получить по 1 самому высокооплачиваемому работнику
-- из каждого департамента. Исходя из данных, ответ должен состоять из следующих строк:
-- Борис - hr    - 78
-- Иван  - it    - 120
-- Анна  - sales - 100

WITH ranked AS (
SELECT
	e.name,
	e.department,
	e.salary,
	row_number() OVER w AS rn
FROM employees AS e
WINDOW w AS (PARTITION BY department ORDER BY salary DESC)
)

SELECT
	name,
	department,
	salary
FROM ranked
WHERE rn = 1
ORDER BY department;