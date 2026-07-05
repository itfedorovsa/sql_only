INSERT INTO roles(role_type) VALUES ('USER'), ('ADMIN');

INSERT INTO rules(rule_type) VALUES ('FULL'), ('RESTRICT'), ('LOW');

INSERT INTO users(login, password_hash, role_id) VALUES ('user1', '123321', 1), ('admin', '333333', 2);

INSERT INTO states(states_type) VALUES ('OPEN'), ('CLOSED');

INSERT INTO categories(category_type) VALUES ('OFFICE'), ('EXTERNAL');
