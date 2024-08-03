CREATE TABLE users (
    id varchar(50) PRIMARY KEY,
    email varchar(255) UNIQUE NOT NULL,
    password_hash varchar(255) NOT NULL
);

CREATE TABLE expenses (
    id varchar(50) PRIMARY KEY,
    amount real NOT NULL,
    category varchar(255) NOT NULL,
    description text,
    created_on date DEFAULT now(),
    user_id varchar(50) REFERENCES users(id)
);