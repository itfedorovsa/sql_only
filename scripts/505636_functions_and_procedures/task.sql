-- создайте функцию calculate_discount, которая принимает два параметра: цену товара, размер скидки в процентах.
-- Функция должна возвращать стоимость товара после применения скидки.
create or replace function calculate_discount(
price numeric(12, 2),
discount_percent int
)
RETURNS NUMERIC
LANGUAGE SQL
as
$$
	SELECT price / 100 * (100 - discount_percent)
$$;

SELECT calculate_discount(2000, 10);

-- создайте функцию full_name, которая принимает имя и фамилию пользователя и возвращает строку в формате: Имя Фамилия
create or replace function merge_full_name(
first_name TEXT,
last_name TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
as
$$
DECLARE full_name TEXT;
begin
	full_name := first_name || ' ' || last_name;
return full_name;
end;
$$;

select merge_full_name('Ivan', 'Ivanov');

-- создайте процедуру increase_category_prices, которая принимает: название категории товаров, процент увеличения цены.
-- Процедура должна увеличить стоимость всех товаров указанной категории на заданный процент.
create or replace procedure increase_category_prices(
category_name TEXT,
increase_price_percent int
)
LANGUAGE plpgsql
AS
$$
BEGIN
	UPDATE products
	SET price = price + (price / 100 * increase_price_percent)
	WHERE category = category_name;
END;
$$;

CALL increase_category_prices('Laptop', 15);

-- создайте процедуру archive_old_orders. Процедура должна перенести все заказы, созданные более года назад,
-- из таблицы orders в таблицу orders_archive, а затем удалить их из таблицы orders.
CREATE TABLE orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE orders_archive (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

INSERT INTO orders(user_id, created_at) VALUES (1, CURRENT_TIMESTAMP), (2, CURRENT_TIMESTAMP);
INSERT INTO orders(user_id, created_at) VALUES (3, '2024-08-12'), (4, '2023-08-12');

CREATE OR REPLACE PROCEDURE archive_old_orders()
LANGUAGE plpgsql
AS
$$
BEGIN
	WITH deleted_old_orders AS (
	DELETE FROM orders WHERE created_at < CURRENT_DATE - INTERVAL '1 year'
	RETURNING id, user_id, created_at
    )
	INSERT INTO orders_archive(id, user_id, created_at) SELECT id, user_id, created_at FROM deleted_old_orders;
END;
$$;

CALL archive_old_orders();

SELECT * FROM orders;
SELECT * FROM orders_archive;