CREATE TABLE workspaces (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slug TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE workspace_integrations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    workspace_id BIGINT NOT NULL REFERENCES workspaces(id),
    integration_type TEXT NOT NULL,
    is_enabled BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE projects (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    workspace_id BIGINT NOT NULL REFERENCES workspaces(id),
    name TEXT NOT NULL
);

CREATE TABLE project_members (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_id BIGINT NOT NULL REFERENCES projects(id),
    user_id BIGINT NOT NULL,
    role TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true
);


-- 1) уникальный slug активного пространства
CREATE UNIQUE INDEX idx_slug_is_active_constraint
ON workspaces(slug)
WHERE is_active = TRUE;

-- неактивное
INSERT INTO workspaces (slug, is_active) VALUES ('company', false);

-- активное
INSERT INTO workspaces (slug, is_active) VALUES ('company', true);

-- ошибка
-- INSERT INTO workspaces (slug, is_active) VALUES ('company', true);


-- 2) одна включенная интеграция каждого типа
CREATE UNIQUE INDEX idx_one_enable_integration_for_each_type
ON workspace_integrations(workspace_id, integration_type)
WHERE is_enabled = TRUE;

-- разные типы
INSERT INTO workspace_integrations (workspace_id, integration_type, is_enabled) VALUES (1, 'GITHUB', true);
INSERT INTO workspace_integrations (workspace_id, integration_type, is_enabled) VALUES (1, 'SLACK', true);

-- один тип
INSERT INTO workspace_integrations (workspace_id, integration_type, is_enabled) VALUES (1, 'GITHUB', false);
INSERT INTO workspace_integrations (workspace_id, integration_type, is_enabled) VALUES (1, 'GITHUB', false);

-- ошибка
-- INSERT INTO workspace_integrations (workspace_id, integration_type, is_enabled) VALUES (1, 'GITHUB', true);


-- 3) один активный владелец проекта
CREATE UNIQUE INDEX idx_unique_owner
ON project_members(project_id)
WHERE role = 'OWNER' AND is_active = TRUE;

-- подготовка данных
INSERT INTO projects (workspace_id, name) VALUES (1, 'Test Project');

-- один активный OWNER и много DEVELOPER
INSERT INTO project_members (project_id, user_id, role, is_active) VALUES (1, 100, 'OWNER', true);
INSERT INTO project_members (project_id, user_id, role, is_active) VALUES (1, 101, 'DEVELOPER', true);
INSERT INTO project_members (project_id, user_id, role, is_active) VALUES (1, 102, 'DEVELOPER', true);

-- неактивный OWNER
INSERT INTO project_members (project_id, user_id, role, is_active) VALUES (1, 200, 'OWNER', false);

-- ошибка
-- INSERT INTO project_members (project_id, user_id, role, is_active) VALUES (1, 300, 'OWNER', true);