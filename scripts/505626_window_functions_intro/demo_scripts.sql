create table if not exists employees (
    id     integer primary key,
    name  text,
    city text,
    department text,
    salary  integer
);

insert into employees (id, name, city, department, salary)
values
    (11, 'Дарья', 'Самара', 'hr', 70),
    (12, 'Борис', 'Самара', 'hr', 78),
    (21, 'Елена', 'Самара', 'it', 84),
    (22, 'Ксения', 'Москва', 'it', 90),
    (23, 'Леонид', 'Самара', 'it', 104),
    (24, 'Марина', 'Москва', 'it', 104),
    (25, 'Иван', 'Москва', 'it', 120),
    (31, 'Вероника', 'Москва', 'sales', 96),
    (32, 'Григорий', 'Самара', 'sales', 96),
    (33, 'Анна', 'Москва', 'sales', 100)
;

-- рейтинг сотрудников по размеру их заработной платы
select
    dense_rank() over w as "rank",
    name, department, salary
from employees
window w as (order by salary desc)
order by salary desc, id;

-- ранжирование сотрудников по размеру заработной платы внутри каждого департамента
select
    dense_rank() over w as "rank",
    name, department, salary
from employees
window w as (
    partition by department
    order by salary desc
    )
order by department, salary desc, id;

-- разбить сотрудников на 3 примерно равные по количеству участников группы
-- в зависимости от размера зарплаты - с более высокой, средней и низкой зарплатой
select
    ntile(3) over w as "tile",
    name, department, salary
from employees
    window w as (order by salary desc)
order by salary desc, id;

-- добавить к строке ее порядковый номер в "окне"
select
    row_number() over w as "rn",
    name, department, salary
from employees
    window w as (order by salary desc)
order by salary desc, id;

-- Одинаковые значения получают одинаковый ранг	Есть пропуски (после 1,1,1 идет 4)
select
    rank() over w as "rank",
    name, department, salary
from employees
    window w as (order by salary desc)
order by salary desc, id;