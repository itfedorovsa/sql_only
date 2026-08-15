-- Стоимость фильма не может быть отрицательной (BEFORE-триггер).
CREATE OR REPLACE FUNCTION negative_price_check()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.price < 0 THEN
	RAISE EXCEPTION 'Стоимость фильма не может быть отрицательной.';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER price_check_trigger
BEFORE INSERT OR UPDATE
ON movies
FOR EACH ROW
EXECUTE FUNCTION negative_price_check();

-- триггер, который автоматически сохраняет информацию при изменении стоимости фильма
ALTER TABLE movies ADD COLUMN price NUMERIC(12, 2);

CREATE TABLE movie_price_history(
	id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	movie_id BIGINT,
	old_price NUMERIC(12, 2),
	new_price NUMERIC(12, 2),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION add_price_change()
RETURNS TRIGGER AS
$$
BEGIN
	IF OLD.price IS DISTINCT FROM NEW.price THEN
	INSERT INTO movie_price_history(movie_id, old_price, new_price) VALUES(NEW.id, OLD.price, NEW.price);
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER save_price_change_trigger
AFTER UPDATE
ON movies
FOR EACH ROW
EXECUTE FUNCTION add_price_change();