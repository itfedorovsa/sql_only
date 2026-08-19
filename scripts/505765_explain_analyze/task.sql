CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE payments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    amount NUMERIC(12, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

INSERT INTO users (name)
SELECT 'User ' || n
FROM generate_series(1, 10000) AS n;

INSERT INTO payments (user_id, amount, status, created_at)
SELECT
    (random() * 9999 + 1)::BIGINT,
    round((random() * 10000)::NUMERIC, 2),
    CASE
        WHEN random() < 0.8 THEN 'COMPLETED'
        ELSE 'CANCELLED'
    END,
    TIMESTAMP '2025-01-01'
        + random() * (TIMESTAMP '2027-01-01' - TIMESTAMP '2025-01-01')
FROM generate_series(1, 1000000);

CREATE INDEX idx_payments_user_id
ON payments(user_id);

ANALYZE users;
ANALYZE payments;

SELECT u.id,
       u.name,
       SUM(p.amount) AS total_amount
FROM users u
JOIN payments p ON p.user_id = u.id
WHERE p.status = 'COMPLETED'
GROUP BY u.id, u.name;

EXPLAIN ANALYZE
SELECT u.id,
       u.name,
       SUM(p.amount) AS total_amount
FROM users u
JOIN payments p ON p.user_id = u.id
WHERE p.status = 'COMPLETED'
GROUP BY u.id, u.name;