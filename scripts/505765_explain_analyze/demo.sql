CREATE TABLE orders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    status VARCHAR(20) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders (user_id, status, amount, created_at)
SELECT
    (random() * 9999 + 1)::BIGINT,
    CASE
        WHEN random() < 0.1 THEN 'NEW'
        WHEN random() < 0.2 THEN 'CANCELLED'
        ELSE 'COMPLETED'
    END,
    round((random() * 10000)::NUMERIC, 2),
    TIMESTAMP '2025-01-01'
        + random() * (TIMESTAMP '2027-01-01' - TIMESTAMP '2025-01-01')
FROM generate_series(1, 1000000);

ANALYZE orders;

SELECT id,
       user_id,
       status,
       created_at,
       amount
FROM orders
WHERE user_id = 100
  AND status = 'NEW'
  AND created_at >= TIMESTAMP '2026-01-01'
ORDER BY created_at DESC;

EXPLAIN ANALYZE
SELECT id,
       user_id,
       status,
       created_at,
       amount
FROM orders
WHERE user_id = 100
  AND status = 'NEW'
  AND created_at >= TIMESTAMP '2026-01-01'
ORDER BY created_at DESC;

CREATE INDEX idx_orders_user_status_created
ON orders(user_id, status, created_at DESC);