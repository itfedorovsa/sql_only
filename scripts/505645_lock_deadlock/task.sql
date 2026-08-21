-- КОНСОЛЬ 1
-- шаг 2
CREATE TABLE accounts (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner TEXT NOT NULL,
    balance NUMERIC(12, 2) NOT NULL
);

INSERT INTO accounts (owner, balance)
VALUES
    ('Алексей', 10000.00),
    ('Мария', 15000.00),
    ('Иван', 20000.00);

-- шаг 3
BEGIN;

SELECT id, balance
FROM accounts
WHERE id = 1
FOR UPDATE;

-- убедились, что транзакция 2 ждет после попытки обновления
COMMIT;

-- шаг 5
-- берем блокировку записи 1
BEGIN;

SELECT id, balance
FROM accounts
WHERE id = 1
FOR UPDATE;

-- пытаемся обновить запись 2
UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

-- откатываем последствия deadlock
ROLLBACK;

-- получение блокировок в едином порядке
-- получаем блокировку для 1 и 2
BEGIN;

SELECT id, balance
FROM accounts
WHERE id IN (1, 2)
ORDER BY id
FOR UPDATE;

-- обновляем 1 и 2
UPDATE accounts
SET balance = balance + 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

-- завершаем транзакцию, пока транзакция 2 ожидает
COMMIT;



-- КОНСОЛЬ 2
-- шаг 3
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

COMMIT;

-- шаг 5
-- берем блокировку записи 2
BEGIN;

SELECT id, balance
FROM accounts
WHERE id = 2
FOR UPDATE;

-- пытаемся обновить запись 1
UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;
-- deadlock detected

-- откатываем последствия deadlock
ROLLBACK;

-- получение блокировок в едином порядке
-- получаем блокировку для 1 и 2
BEGIN;

SELECT id, balance
FROM accounts
WHERE id IN (1, 2)
ORDER BY id
FOR UPDATE;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 2;

COMMIT;



-- КОНСОЛЬ 3
-- шаг 4
SELECT
pid,
state,
wait_event_type,
wait_event,
pg_blocking_pids(pid),
query
FROM pg_stat_activity
WHERE datname = current_database();
-- pid 20124 (update) заблокирован (lock, transactionid) и ждет pid 3668 (select for update)

SELECT
pid,
locktype,
relation,
mode,
granted
FROM pg_locks
WHERE pid IS NOT NULL;
-- 3668 взял ExclusiveLock (transactionid), 20124 блокировку по transactionid ещё не взял (ShareLock)