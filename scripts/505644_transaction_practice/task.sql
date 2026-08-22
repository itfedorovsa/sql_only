CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE cars (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    model TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'AVAILABLE',
    version INTEGER NOT NULL DEFAULT 1,
    CHECK (status IN ('AVAILABLE', 'BOOKED'))
);

CREATE TABLE bookings (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    request_id UUID NOT NULL UNIQUE,
    user_id BIGINT NOT NULL REFERENCES users(id),
    car_id BIGINT NOT NULL REFERENCES cars(id),
    status TEXT NOT NULL DEFAULT 'NEW',
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE payments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id BIGINT NOT NULL REFERENCES bookings(id),
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE booking_options (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id BIGINT NOT NULL REFERENCES bookings(id),
    option_name TEXT NOT NULL,
    price NUMERIC(12, 2) NOT NULL CHECK (price > 0)
);

INSERT INTO users (name)
VALUES
    ('Иван Петров'),
    ('Анна Смирнова');

INSERT INTO cars (model)
VALUES
    ('Toyota Camry'),
    ('Kia Sportage'),
    ('Volkswagen Polo');


-- Задание 1
BEGIN;

INSERT INTO bookings(request_id, user_id, car_id) VALUES('11111111-1111-1111-1111-111111111111', 1, 1)
RETURNING id;

UPDATE cars SET status = 'BOOKED'
WHERE id = 1;

INSERT INTO payments(booking_id, amount) VALUES(1, 5000.00);

COMMIT;

SELECT *
FROM cars;

SELECT *
FROM bookings;

SELECT *
FROM payments;


-- Задание 2
BEGIN;

INSERT INTO bookings(request_id, user_id, car_id) VALUES('22222222-2222-2222-2222-222222222222', 2, 2);

UPDATE cars SET status = 'BOOKED'
WHERE id = 2;

INSERT INTO payments(booking_id, amount) VALUES(2, -3000.00);

SELECT *
FROM cars; -- error

ROLLBACK;

SELECT *
FROM cars;

SELECT *
FROM bookings;

SELECT *
FROM payments;
-- всё откатилось


-- Задание 3
BEGIN;

INSERT INTO bookings(request_id, user_id, car_id) VALUES('33333333-3333-3333-3333-333333333333', 2, 2);

SAVEPOINT booking_added;

INSERT INTO booking_options(booking_id, option_name, price) VALUES(2, 'Детское кресло', 1000.00), (2, 'Дополнительный водитель', 2000.00);

SAVEPOINT options_added;

INSERT INTO booking_options(booking_id, option_name, price) VALUES(2, 'Страховка', -1500.00);

ROLLBACK TO options_added;

INSERT INTO booking_options(booking_id, option_name, price) VALUES(2, 'Страховка', 1500.00);

ROLLBACK TO booking_added;

INSERT INTO booking_options(booking_id, option_name, price) VALUES(2, 'Дополнительный водитель', 2000.00);

COMMIT;

SELECT *
FROM bookings;

SELECT *
FROM booking_options;


-- Задание 4
-- Транзакция 1
BEGIN;

SELECT *
FROM cars
WHERE id = 3
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 3;

COMMIT;

-- Транзакция 2
BEGIN;

SELECT *
FROM cars
WHERE id = 3
FOR UPDATE;

ROLLBACK; -- второе бронирование невозможно, так как авто уже забронировано


-- Задание 5
UPDATE cars SET status = 'AVAILABLE'
WHERE id = 3;

-- Транзакция 1
BEGIN;

SELECT *
FROM cars
WHERE id = 3
FOR UPDATE;

ROLLBACK;

-- Транзакция 2
BEGIN;

SELECT *
FROM cars
WHERE id = 3
FOR UPDATE;

ROLLBACK;

-- Консоль 3
SELECT
pid,
state,
wait_event_type,
wait_event,
pg_blocking_pids(pid),
query
FROM pg_stat_activity
WHERE datname = current_database();
-- pid ожидающего процесса 20294 (Lock по transactionid), блокируется pid 20592 (SELECT ... FOR UPDATE)


-- Задание 6
UPDATE cars SET status = 'AVAILABLE', version = 1 WHERE id = 3;

-- Транзакция 1
BEGIN;

SELECT id, status, VERSION
FROM cars
WHERE id = 3;

UPDATE cars SET status = 'BOOKED', version = version + 1
WHERE id = 3 AND version = 1;

COMMIT;

-- Транзакция 2
BEGIN;

SELECT id, status, version
FROM cars
WHERE id = 3;

UPDATE cars SET status = 'BOOKED', version = version + 1
WHERE id = 3 AND version = 1; -- Updated Rows 0
-- обновление не произошло по причине изменения изначально считанной версии другой транзакцией.

--текущую транзакцию нужно завершить, так как произошел конфликт
ROLLBACK;


-- Задание 7
UPDATE cars SET status = 'AVAILABLE'
WHERE id IN (1, 3);

-- Транзакция 1
BEGIN;

SELECT *
FROM cars
WHERE id = 1
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 1;

SELECT *
FROM cars
WHERE id = 2
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 2;

ROLLBACK;

-- исправление deadlock
BEGIN;

SELECT *
FROM cars
WHERE id = 1
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 1;

SELECT *
FROM cars
WHERE id = 2
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 2;

COMMIT;

-- Транзакция 2
BEGIN;

SELECT *
FROM cars
WHERE id = 2
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 2;

SELECT *
FROM cars
WHERE id = 1
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 1;  -- deadlock detected

ROLLBACK;

-- исправление deadlock
BEGIN;

SELECT *
FROM cars
WHERE id = 1
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 1;

SELECT *
FROM cars
WHERE id = 2
FOR UPDATE;

UPDATE cars SET status = 'BOOKED'
WHERE id = 2;

ROLLBACK;


-- Задание 8
UPDATE cars SET status = 'AVAILABLE'
WHERE id IN (1, 3);

BEGIN;

INSERT INTO bookings(request_id, user_id, car_id) VALUES('44444444-4444-4444-4444-444444444444', 1, 1)
ON CONFLICT (request_id) DO NOTHING;

INSERT INTO bookings(request_id, user_id, car_id) VALUES('44444444-4444-4444-4444-444444444444', 1, 1)
 ON CONFLICT (request_id) DO NOTHING; -- Updated Rows 0

COMMIT;
