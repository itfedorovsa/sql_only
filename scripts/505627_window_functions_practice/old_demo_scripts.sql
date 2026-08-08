-- Упорядочить зарплаты по возрастанию и сравнить, насколько большой разрыв в зарплатах в соседних строках.
-- Для усложнения задачи вывести разницу в процентах.
with emp as (
    select
        id, name, department, salary,
        lag(salary, 1) over w as prev
    from employees
        window w as (order by salary, id)
)
select
    name, department, salary,
    round((salary - prev) * 100.0 / prev) as diff
from emp
order by salary, id;

-- упрощенный вариант предыдущего запроса (prev заменен на окнонную функцию)
select
    name, department, salary,
    round((salary - lag(salary, 1) over w) * 100.0 / lag(salary, 1) over w) as diff
from employees
    window w as (order by salary, id)
order by salary, id;

-- сравнение с последующими сроками (lead)
select
    name, department, salary,
    round((salary - lead(salary, 1) over w) * 100.0 / lead(salary, 1) over w) as diff
from employees
    window w as (order by salary, id)
order by salary, id;


--------------------------------------------------------------------------------------------


create table if not exists expenses (
     year  integer,
     month  integer,
     income integer,
     expense integer
);

insert into expenses (year, month, income, expense)
values
    (2025, 1, 94, 82),
    (2025, 2, 94, 75),
    (2025, 3, 94, 104),
    (2025, 4, 100, 94),
    (2025, 5, 100, 99),
    (2025, 6, 100, 105),
    (2025, 7, 100, 95),
    (2025, 8, 100, 110),
    (2025, 9, 104, 104)
;

-- отсортированная таблица по месяцам (задание не окончено)
select
    year, month, income, expense,
    null as t_income, -- доходы нарастающим итогом с начала года
    null as t_expense, -- расходы нарастающим итогом с начала года
    null as t_profit   -- t_income минус t_expense
from expenses
where year = 2025 and month <= 9
order by year, month;