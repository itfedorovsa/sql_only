ALTER TABLE tasks
ADD COLUMN IF NOT EXISTS status VARCHAR(50) NOT NULL DEFAULT 'new';

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'tasks_status_check' AND conrelid = 'tasks'::regclass
    ) THEN
        ALTER TABLE tasks
        ADD CONSTRAINT tasks_status_check
        CHECK (status IN ('new', 'in_progress', 'done'));
    END IF;
END
$$;