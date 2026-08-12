-- ФУНКЦИИ:
-- функция, которая рассчитывает стоимость товара после применения скидки:
CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
AS
$$
    SELECT price * (100 - discount_percent) / 100;
$$;

-- вычислить размер скидки, сохранить его в переменной, а затем вернуть окончательную стоимость товара:
CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_percent NUMERIC
)
RETURNS NUMERIC
AS
$$
DECLARE
    discount_amount NUMERIC;
BEGIN
    discount_amount := price * discount_percent / 100;

    RETURN price - discount_amount;
END;
$$
LANGUAGE plpgsql;

-- скидка не может превышать 50% (сначала проверяется размер скидки: если переданное значение больше 50,
-- функция сразу возвращает цену с максимально допустимой скидкой, а во всех остальных случаях используется обычная формула расчета):
CREATE OR REPLACE FUNCTION calculate_discount(
    price NUMERIC,
    discount_percent NUMERIC
)
RETURNS NUMERIC
AS
$$
BEGIN
    IF discount_percent > 50 THEN
        RETURN price * 0.5;
    END IF;

    RETURN price * (100 - discount_percent) / 100;
END;
$$
LANGUAGE plpgsql;

-- ПРОЦЕДУРЫ:
-- процедура, которая ежегодно повышает стоимость товаров определенной категории на заданный процент:
CREATE OR REPLACE PROCEDURE increase_category_prices(
    category_name TEXT,
    percent NUMERIC
)
LANGUAGE SQL
AS
$$
    UPDATE products
    SET price = price * (100 + percent) / 100
    WHERE category = category_name;
$$;