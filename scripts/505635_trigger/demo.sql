--  создать триггер, который будет выполняться после изменения записи в таблице products
-- логика триггера описывается в специальной функции:
CREATE OR REPLACE FUNCTION save_price_history()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO product_price_history (
        product_id,
        old_price,
        new_price
    )
    VALUES (
        OLD.id,
        OLD.price,
        NEW.price
    );

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
-- связать функцию с таблицей
CREATE TRIGGER product_price_history_trigger
AFTER UPDATE OF price
ON products
FOR EACH ROW
EXECUTE FUNCTION save_price_history();

-- Триггер на проверку до вставки новой записи и до изменения существующей
-- функция
CREATE OR REPLACE FUNCTION check_product_price()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.price < 0 THEN
        RAISE EXCEPTION 'Цена товара не может быть отрицательной.';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
-- триггер
CREATE TRIGGER check_product_price_trigger
BEFORE INSERT OR UPDATE
ON products
FOR EACH ROW
EXECUTE FUNCTION check_product_price();