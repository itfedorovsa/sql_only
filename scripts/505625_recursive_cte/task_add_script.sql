CREATE TABLE IF NOT EXISTS folders (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INTEGER REFERENCES folders(id)
);

INSERT INTO folders (id, name, parent_id) VALUES
    (1, 'Projects', NULL),
    (2, 'Backend', 1),
    (3, 'Frontend', 1),
    (4, 'Java', 2),
    (5, 'Python', 2),
    (6, 'src', 4),
    (7, 'test', 4),
    (8, 'React', 3),
    (9, 'components', 8),
    (10, 'utils', 9),
    -- Искусственно создаем цикл для проверки защиты (utils ссылается на React)
    (11, 'buggy_folder', 10)
;

-- Создаем петлю: React (8) -> components (9) -> utils (10) -> buggy_folder (11) -> React (8)
UPDATE folders SET parent_id = 8 WHERE id = 11;