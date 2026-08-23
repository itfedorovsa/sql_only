-- Практическая задача 1. Создание и чтение JSONB
CREATE TABLE products (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    category VARCHAR(100) NOT NULL,
    attributes JSONB NOT NULL DEFAULT '{}'::jsonb
);

INSERT INTO products(name, category, attributes) VALUES (
'Ноутбук',
'Электроника',
'{
    "weight": 1.8,
    "color": "серый",
    "tags": ["electronics", "laptop"],
    "specs": {
        "cpu": "i7",
        "ram": 16
    }
}'
);

INSERT INTO products(name, category, attributes) VALUES (
'Футболка',
'Одежда',
'{
    "size": "L",
    "color": "синий",
    "weight": 0.2,
    "tags": ["clothing", "sale"]
}'
);

INSERT INTO products(name, category, attributes) VALUES (
'Книга',
'Книги',
'{
    "author": "Лев Толстой",
    "pages": 800,
    "weight": 0.5,
    "tags": ["books"]
}'
);

INSERT INTO products(name, category, attributes) VALUES (
'Кроссовки',
'Одежда',
'{
    "size": 42,
    "color": "белый",
    "tags": ["clothing", "shoes"]
}'
);

SELECT
name,
COALESCE(attributes ->> 'weight', 'Отсутствует') AS weight
FROM products;


-- Практическая задача 2. Поиск и изменение JSONB
SELECT *
FROM products
WHERE attributes @> '{"tags": ["electronics"]}';

SELECT *
FROM products
WHERE (attributes ->> 'weight')::NUMERIC < 1;

UPDATE products SET attributes = attributes || '{"discount": 15}'::jsonb
WHERE name = 'Ноутбук';

SELECT *
FROM products;


-- Практическая задача 3. Индексирование JSONB
CREATE INDEX idx_products_electronics
ON products USING GIN(attributes jsonb_path_ops);
-- какой вариант вы выбрали; - GIN
-- почему он подходит для запроса с @>; - GIN строит индекс по значениям JSONB
-- в чем основное отличие выбранного варианта от второго класса операторов. - jsonb_path_ops выгоднее, так как индексирует хэши полных путей,
-- а не массив ключей в JSONB.