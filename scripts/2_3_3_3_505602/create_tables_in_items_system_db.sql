-- TODO:
-- rules - права ролей. roles -> rules - many-to-many
-- attachs - прикрепленные файлы. items -> attachs - one-to-many

DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS states;

SET search_path TO public;

-- роли пользователей
CREATE TABLE roles
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role_type TEXT NOT NULL
);

-- пользователи
CREATE TABLE users
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login TEXT NOT NULL UNIQUE CHECK (char_length(login) >= 3) ,
    password_hash TEXT NOT NULL CHECK (char_length(password_hash) > 0),
    role_id BIGINT NOT NULL REFERENCES roles (id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- состояния заявок
CREATE TABLE states
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    state_type TEXT NOT NULL
);

-- категории заявок
CREATE TABLE categories
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_type TEXT NOT NULL
);

-- заявки
CREATE TABLE items
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    item_title TEXT NOT NULL CHECK (char_length(item_title) > 0),
    item_desc TEXT NOT NULL CHECK (char_length(item_desc) > 0),
    user_id BIGINT NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE RESTRICT,
    state_id BIGINT NOT NULL REFERENCES states (id) ON DELETE RESTRICT,
    category_id BIGINT NOT NULL REFERENCES categories (id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- комментарии
CREATE TABLE comments
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    comment_text TEXT NOT NULL CHECK (char_length(comment_text) > 0),
    item_id BIGINT NOT NULL REFERENCES items (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);