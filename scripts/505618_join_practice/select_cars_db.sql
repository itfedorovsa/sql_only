-- вывести кузова, которые не используются ни в одной машине
SELECT b.id, b.name
FROM car_bodies AS b
LEFT JOIN cars AS c ON c.body_id = b.id
WHERE c.body_id IS NULL;

-- вывести двигатели, которые не используются ни в одной машине
SELECT e.id, e.name
FROM car_engines AS e
LEFT JOIN cars AS c ON c.engine_id = e.id
WHERE c.engine_id IS NULL;

-- вывести коробки передач, которые не используются ни в одной машине
SELECT t.id, t.name
FROM car_transmissions AS t
LEFT JOIN cars AS c ON c.transmission_id = t.id
WHERE c.transmission_id IS NULL;

-- вывести список всех машин и название кузова, даже если оно не указано
SELECT c.id, c.name AS car_name, b.name AS body_name
FROM cars AS c
LEFT JOIN car_bodies AS b ON b.id = c.body_id;

-- вывести только те машины, у которых одновременно указаны
SELECT c.id, c.name AS car_name, b.name AS body_name, e.name AS engine_name, t.name AS transmission_name
FROM cars AS c
JOIN car_bodies AS b ON b.id = c.body_id
JOIN car_engines AS e ON e.id = c.engine_id
JOIN car_transmissions AS t ON t.id = c.transmission_id;

-- вывести машины, у которых есть двигатель, но нет кузова
SELECT c.id, c.name AS car_name, b.name AS body_name, e.name AS engine_name
FROM cars AS c
LEFT JOIN car_bodies AS b ON b.id = c.body_id
JOIN car_engines AS e ON e.id = c.engine_id
WHERE c.engine_id IS NOT NULL AND c.body_id IS NULL;

-- вывести все кузова и машины, которые их используют
SELECT b.id AS body_id, b.name AS body_name, c.id AS car_id, c.name AS car_name
FROM car_bodies AS b
LEFT JOIN cars AS c ON b.id = c.body_id;

-- вывести машины и все их детали, но только для машин с автоматической коробкой передач
SELECT c.id, c.name AS car_name, b.name AS body_name, e.name AS engine_name, t.name AS transmission_name
FROM cars AS c
LEFT JOIN car_bodies AS b ON b.id = c.body_id
LEFT JOIN car_engines AS e ON e.id = c.engine_id
JOIN car_transmissions AS t ON t.id = c.transmission_id
WHERE t.name ILIKE 'automatic%';

-- вывести машины, у которых отсутствует хотя бы одна деталь
SELECT c.id, c.name AS car_name, b.name AS body_name, e.name AS engine_name, t.name AS transmission_name
FROM cars AS c
LEFT JOIN car_bodies AS b ON b.id = c.body_id
LEFT JOIN car_engines AS e ON e.id = c.engine_id
LEFT JOIN car_transmissions AS t ON t.id = c.transmission_id
WHERE c.body_id IS NULL OR c.engine_id IS NULL OR c.transmission_id IS NULL;

-- вывести все машины с двигателями, но коробку передач подключить так, чтобы машины без коробки тоже попали в результат
SELECT c.id, c.name AS car_name, e.name AS engine_name, t.name AS transmission_name
FROM cars AS c
JOIN car_engines AS e ON e.id = c.engine_id
LEFT JOIN car_transmissions AS t ON t.id = c.transmission_id;

-- вывести все неиспользуемые детали в едином формате
SELECT 'body' AS detail_type, b.id AS detail_id, b.name AS detail_name
FROM car_bodies AS b
LEFT JOIN cars AS c ON c.body_id = b.id
WHERE c.body_id IS NULL
UNION
SELECT 'engine' AS detail_type, e.id AS detail_id, e.name AS detail_name
FROM car_engines AS e
LEFT JOIN cars AS c ON c.engine_id = e.id
WHERE c.engine_id IS NULL
UNION
SELECT 'transmission' AS detail_type, t.id AS detail_id, t.name AS detail_name
FROM car_transmissions AS t
LEFT JOIN cars AS c ON c.transmission_id = t.id
WHERE c.transmission_id IS NULL
ORDER BY detail_type ASC;

-- вывести машины и детали только для кузовов определенных типов
SELECT c.id, c.name AS car_name, b.name AS body_name, e.name AS engine_name, t.name AS transmission_name
FROM cars AS c
LEFT JOIN car_bodies AS b ON b.id = c.body_id
LEFT JOIN car_engines AS e ON e.id = c.engine_id
LEFT JOIN car_transmissions AS t ON t.id = c.transmission_id
WHERE b.name IN ('sedan', 'hatchback', 'suv');