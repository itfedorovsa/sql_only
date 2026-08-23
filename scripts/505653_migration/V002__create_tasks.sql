CREATE TABLE IF NOT EXISTS tasks(
id BIGSERIAL PRIMARY KEY,
project_id BIGINT NOT NULL REFERENCES projects(id),
title TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_project_id
ON tasks(project_id);