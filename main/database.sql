CREATE DATABASE chat_app;
USE chat_app;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES users(id),
    FOREIGN KEY (receiver_id) REFERENCES users(id)
);


CREATE TABLE user_status (
    user_id INT PRIMARY KEY,
    status VARCHAR(20) NOT NULL DEFAULT 'offline',
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

ALTER TABLE messages 
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'sent',
ADD COLUMN delivered_at TIMESTAMP NULL,
ADD COLUMN read_at TIMESTAMP NULL;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add a test user (username: admin, password: admin)
INSERT INTO users (username, password, email) 
SELECT 'admin', 'admin', 'admin@example.com'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');

-- Add another test user (username: user, password: password)
INSERT INTO users (username, password, email) 
SELECT 'user', 'password', 'user@example.com'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'user');

use chatapp;

select * from users;
select * from user_statuses;