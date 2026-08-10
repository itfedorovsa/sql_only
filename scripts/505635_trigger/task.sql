-- триггер, который автоматически обновляет поле updated_at при изменении записи
CREATE TABLE employees(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
full_name TEXT,
salary NUMERIC(12, 2),
updated_at TIMESTAMP
)

INSERT INTO employees(full_name, salary) VALUES ('name', 30000.00);

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS
$$
BEGIN
	NEW.updated_at = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER update_updated_at_trigger
BEFORE UPDATE OF salary
ON employees
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

UPDATE employees
SET salary = 32000
WHERE id = 1;

SELECT * FROM employees;

-- При каждом изменении статуса заказа необходимо автоматически сохранять:
-- идентификатор заказа, предыдущий статус, новый статус, дату изменения
CREATE TABLE orders(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
status TEXT NOT NULL,
updated_at TIMESTAMP NOT NULL
);

CREATE TABLE order_status_history(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id BIGINT NOT NULL REFERENCES orders(id),
prev_status TEXT NOT NULL,
curr_status TEXT NOT NULL,
updated_at TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION save_status_change()
RETURNS TRIGGER AS
$$
BEGIN
	INSERT INTO order_status_history(order_id, prev_status, curr_status, updated_at) VALUES (NEW.id, OLD.status, NEW.status, CURRENT_TIMESTAMP);
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER save_order_status_change
AFTER UPDATE OF status
ON orders
FOR EACH ROW
EXECUTE FUNCTION save_status_change();

INSERT INTO orders(status, updated_at) VALUES('NEW', CURRENT_TIMESTAMP);

UPDATE orders
SET status = 'IN PROGRESS'
WHERE id = 1;

SELECT * FROM order_status_history;

UPDATE orders
SET status = 'PROCESSED'
WHERE id = 1;

SELECT * FROM order_status_history;

-- триггер, который выдаёт ошибку при попытке выполнить INSERT или UPDATE с некорректным значением
CREATE OR REPLACE FUNCTION check_salary()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.salary < 0 THEN
	RAISE EXCEPTION 'The salary must be positive';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_salary
BEFORE INSERT OR UPDATE OF salary
ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary();

INSERT INTO employees(full_name, salary) VALUES('Ivan', -30000);

UPDATE employees
SET salary = -30000
WHERE id = 1;

-- триггер, который автоматически удаляет пробелы в начале и конце названия товара перед сохранением записи
CREATE TABLE products(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name TEXT NOT NULL,
price NUMERIC(12, 2) NOT NULL
);

CREATE OR REPLACE FUNCTION trim_name()
RETURNS TRIGGER AS
$$
BEGIN
	NEW.name = TRIM(BOTH FROM NEW.name);
	RETURN NEW;

END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trim_name_trigger
BEFORE INSERT OR UPDATE OF name
ON products
FOR EACH ROW
EXECUTE FUNCTION trim_name();

INSERT INTO products(name, price) VALUES('   Iphone SE   ', 10000.00);

SELECT * FROM products;

-- реализовать журнал изменения цены таким образом, чтобы новая запись в журнал добавлялась только тогда,
-- когда цена действительно изменилась. Если обновляются другие поля товара, история цен пополняться не должна.
CREATE TABLE price_history(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
old_price NUMERIC(12, 2) NOT NULL,
new_price NUMERIC(12, 2) NOT NULL,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION save_price()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.PRICE != OLD.PRICE THEN
		INSERT INTO price_history(old_price, new_price) VALUES(OLD.price, NEW.price);
	END IF;

	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER price_history_trigger
BEFORE UPDATE OF price
ON products
FOR EACH ROW
EXECUTE FUNCTION save_price();

UPDATE products
SET name = 'IPHONE SE', price = 10000.00
WHERE id = 1;