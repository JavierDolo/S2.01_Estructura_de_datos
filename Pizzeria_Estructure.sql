USE Pizzeria;

CREATE TABLE province (
    province_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE city (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    province_id INT NOT NULL,
    FOREIGN KEY (province_id) REFERENCES province(province_id) ON DELETE CASCADE
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city_id INT NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    FOREIGN KEY (city_id) REFERENCES city(city_id) ON DELETE CASCADE
);

CREATE TABLE store (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id) ON DELETE CASCADE
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nif VARCHAR(9) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    role ENUM('Chef', 'Delivery') NOT NULL,
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES store(store_id) ON DELETE CASCADE
);

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    image VARCHAR(255) NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    type ENUM('Pizza', 'Burger', 'Drink') NOT NULL,
    category_id INT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE SET NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_type ENUM('Home Delivery', 'Pickup') NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price > 0),
    delivery_person_id INT NULL,
    delivery_date TIMESTAMP NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES store(store_id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_person_id) REFERENCES employee(employee_id) ON DELETE SET NULL
);

CREATE TABLE order_product (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);