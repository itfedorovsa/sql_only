CREATE TABLE users
(
    id         INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name  VARCHAR(50) NOT NULL,
    email      VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (full_name, email)
VALUES ('full_name', 'a@mail.ru'),
       ('full_name', 'b@mail.ru'),
       ('full_name', 'c@mail.ru'),
       ('full_name', 'd@mail.ru'),
       ('full_name', 'e@mail.ru');