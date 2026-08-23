-- Практическая задача 1. UUID как PRIMARY KEY
CREATE TABLE orders(
id UUID PRIMARY KEY DEFAULT uuidv7(),
customer_id BIGINT NOT NULL,
status TEXT NOT NULL,
created_at TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
);

-- Практическая задача 2. BIGINT внутри, UUID снаружи
CREATE TABLE payments(
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
public_id UUID NOT NULL UNIQUE DEFAULT uuidv7(),
order_id BIGINT NOT NULL REFERENCES orders(id),
amount NUMERIC(12, 2) CHECK (amount > 0),
created_at TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
);