CREATE TABLE payments
(
    id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id   BIGINT         NOT NULL REFERENCES orders (id),
    amount     NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    status     TEXT           NOT NULL,
    created_at TIMESTAMPTZ    NOT NULL DEFAULT now()
);

INSERT INTO payments (order_id, amount, status)
VALUES (1, 129990.00, 'PAID'),
       (3, 4990.00, 'FAILED');

-- пользователи, у которых нет ни одного платежа
SELECT DISTINCT
    u.id,
    u.name,
    u.email
FROM users AS u
LEFT JOIN orders AS o ON o.user_id = u.id
LEFT JOIN payments AS p ON p.order_id = o.id
WHERE p.id IS NULL;

-----

CREATE TABLE roles
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL
);

CREATE TABLE user_roles
(
    user_id BIGINT NOT NULL REFERENCES users (id),
    role_id BIGINT NOT NULL REFERENCES roles (id),
    PRIMARY KEY (user_id, role_id)
);

INSERT INTO roles (code, name)
VALUES ('ADMIN', 'Administrator'),
       ('CUSTOMER', 'Customer'),
       ('MANAGER', 'Manager'),
       ('SUPPORT', 'Support');

INSERT INTO user_roles (user_id, role_id)
VALUES (1, 1),
       (1, 2),
       (2, 2);

-- сверочный отчет FULL JOIN
SELECT
    r.id AS role_id,
    r.code,
    ur.user_id
FROM roles AS r
FULL JOIN user_roles AS ur ON ur.role_id = r.id;

-----

CREATE TABLE environments
(
    id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code TEXT NOT NULL UNIQUE
);

INSERT INTO environments (code)
VALUES ('dev'), ('stage'), ('prod');

-- все комбинации “роль + окружение”
SELECT
    r.code AS role_code,
    e.code AS environment_code
FROM roles AS r
CROSS JOIN environments AS e;

-----

CREATE TABLE categories
(
    id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name      TEXT NOT NULL,
    parent_id BIGINT REFERENCES categories (id)
);

INSERT INTO categories (name, parent_id)
VALUES
    ('Электроника', NULL),
    ('Смартфоны', 1),
    ('Ноутбуки', 1),
    ('Аксессуары', 1),
    ('Чехлы', 4);


-- self join
SELECT
    c.id,
    c.name AS category_name,
    p.name AS parent_category_name
FROM categories AS c
LEFT JOIN categories AS p ON c.parent_id = p.id;