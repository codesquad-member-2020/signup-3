DROP TABLE IF EXISTS user CASCADE ;

CREATE TABLE user (
    id IDENTITY,
    user_id VARCHAR(20) UNIQUE,
    password VARCHAR(20),
    name VARCHAR(32),
    email VARCHAR(32) UNIQUE,
    dob DATE,
    gender CHAR(1),
    phone CHAR(11) UNIQUE
);

CREATE TABLE interest (
    user VARCHAR(20),
    user_key VARCHAR(20),
    name VARCHAR(32)
);
