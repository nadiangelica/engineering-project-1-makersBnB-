DROP TABLE IF EXISTS users, spaces; 

-- Table Definition
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name text,
    email_address text,
    password text 
);

INSERT INTO users (name, email_address, password) VALUES
('Admin', 'admin@email.com' , 'adminpassword');


CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    name text,
    description text,
    price_per_night money,
    available_from date,
    available_to date,
    host_id int,
    constraint fk_user foreign key(host_id)
        references users(id)
        on delete cascade
);