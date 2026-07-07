SELECT id, title, company, description
FROM vacancies
WHERE title ~* '(java|go|postgres)' OR description ~* '(java|go|postgres)';