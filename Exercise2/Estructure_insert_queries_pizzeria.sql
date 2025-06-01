CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

SET FOREIGN_KEY_CHECKS = 0; -- - Desactivar FOREIGN_KEY_CHECKS permite crear todas las tablas sin preocuparse del orden.

DROP TABLE IF EXISTS province;
CREATE TABLE IF NOT EXISTS province (
  province_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (province_id),
  UNIQUE KEY province_unique (name)
);

DROP TABLE IF EXISTS locality;
CREATE TABLE IF NOT EXISTS locality (
  locality_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  province_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (locality_id),
  UNIQUE KEY locality_unique (name),
  KEY locality_province_FK (province_id),
  CONSTRAINT locality_province_FK FOREIGN KEY (province_id) REFERENCES province (province_id)
);

DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
  address_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  building_number varchar(20) DEFAULT NULL,
  floor varchar(20) DEFAULT NULL,
  door varchar(20) DEFAULT NULL,
  postal_code varchar(20) NOT NULL,
  locality_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (address_id),
  KEY address_locality_FK (locality_id),
  CONSTRAINT address_locality_FK FOREIGN KEY (locality_id) REFERENCES locality (locality_id)
);

DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
  customer_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  surname varchar(50) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  phone varchar(20) NOT NULL,
  PRIMARY KEY (customer_id),
  UNIQUE KEY customer_unique (name, address_id),
  KEY customer_address_FK (address_id),
  CONSTRAINT customer_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
);

DROP TABLE IF EXISTS shop;
CREATE TABLE IF NOT EXISTS shop (
  shop_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  address_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (shop_id),
  UNIQUE KEY shop_unique (name, address_id),
  KEY shop_address_FK (address_id),
  CONSTRAINT shop_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
);

DROP TABLE IF EXISTS job_position;
CREATE TABLE IF NOT EXISTS job_position (
  job_position_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (job_position_id)
);

DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
  employee_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  surname varchar(50) DEFAULT NULL,
  address_id bigint(20) unsigned NOT NULL,
  job_position_id bigint(20) unsigned NOT NULL,
  shop_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (employee_id),
  KEY employee_address_FK (address_id),
  KEY employee_job_positions_FK (job_position_id),
  KEY employee_shop_FK (shop_id),
  CONSTRAINT employee_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id),
  CONSTRAINT employee_job_positions_FK FOREIGN KEY (job_position_id) REFERENCES job_position (job_position_id),
  CONSTRAINT employee_shop_FK FOREIGN KEY (shop_id) REFERENCES shop (shop_id)
);

DROP TABLE IF EXISTS product_type;
CREATE TABLE IF NOT EXISTS product_type (
  product_type_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  description varchar(150) NOT NULL,
  PRIMARY KEY (product_type_id)
);

DROP TABLE IF EXISTS pizza_category;
CREATE TABLE IF NOT EXISTS pizza_category (
  pizza_category_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (pizza_category_id)
);

DROP TABLE IF EXISTS product;
CREATE TABLE IF NOT EXISTS product (
  product_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  product_type_id bigint(20) unsigned NOT NULL,
  pizza_category_id bigint(20) unsigned DEFAULT NULL,
  name varchar(50) NOT NULL,
  description varchar(200) DEFAULT NULL,
  picture blob DEFAULT NULL,
  price decimal(10,4) NOT NULL,
  PRIMARY KEY (product_id),
  KEY product_product_type_FK (product_type_id),
  KEY product_pizza_category_FK (pizza_category_id),
  CONSTRAINT product_pizza_category_FK FOREIGN KEY (pizza_category_id) REFERENCES pizza_category (pizza_category_id),
  CONSTRAINT product_product_type_FK FOREIGN KEY (product_type_id) REFERENCES product_type (product_type_id)
);

DROP TABLE IF EXISTS delivery;
CREATE TABLE IF NOT EXISTS delivery (
  delivery_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (delivery_id),
  UNIQUE KEY delivery_unique (name),
  KEY delivery_name_FK (name)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
  orders_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  shop_id bigint(20) unsigned NOT NULL,
  customer_id bigint(20) unsigned NOT NULL,
  delivery_id bigint(20) unsigned NOT NULL,
  registration_date datetime NOT NULL DEFAULT current_timestamp(),
  employee_reception_id bigint(20) unsigned NOT NULL,
  employee_delivery_id bigint(20) unsigned NOT NULL,
  PRIMARY KEY (orders_id),
  KEY orders_shop_FK (shop_id),
  KEY orders_customer_FK (customer_id),
  KEY orders_delivery_FK (delivery_id),
  KEY orders_employee_reception_FK (employee_reception_id),
  KEY orders_employee_delivery_FK (employee_delivery_id),
  CONSTRAINT orders_customer_FK FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT orders_delivery_FK FOREIGN KEY (delivery_id) REFERENCES delivery (delivery_id),
  CONSTRAINT orders_employee_delivery_FK FOREIGN KEY (employee_delivery_id) REFERENCES employee (employee_id),
  CONSTRAINT orders_employee_reception_FK FOREIGN KEY (employee_reception_id) REFERENCES employee (employee_id),
  CONSTRAINT orders_shop_FK FOREIGN KEY (shop_id) REFERENCES shop (shop_id)
);

DROP TABLE IF EXISTS orders_detail;
CREATE TABLE IF NOT EXISTS orders_detail (
  orders_detail_id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  orders_id bigint(20) unsigned NOT NULL,
  product_id bigint(20) unsigned NOT NULL,
  quantity bigint(20) DEFAULT NULL,
  PRIMARY KEY (orders_detail_id),
  KEY orders_detail_orders_FK (orders_id),
  KEY orders_detail_product_FK (product_id),
  CONSTRAINT orders_detail_product_FK FOREIGN KEY (product_id) REFERENCES product (product_id),
  CONSTRAINT orders_detail_orders_FK FOREIGN KEY (orders_id) REFERENCES orders (orders_id)
);

-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;



USE pizzeria;


-- Desactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 0;


-- Borrar datos existentes antes de insertar nuevos registros
TRUNCATE TABLE address;
TRUNCATE TABLE customer;
TRUNCATE TABLE delivery;
TRUNCATE TABLE employee;
TRUNCATE TABLE job_position;
TRUNCATE TABLE locality;
TRUNCATE TABLE orders;
TRUNCATE TABLE orders_detail;
TRUNCATE TABLE pizza_category;
TRUNCATE TABLE product;
TRUNCATE TABLE product_type;
TRUNCATE TABLE province;
TRUNCATE TABLE shop;

-- province
INSERT INTO province (name) VALUES
('Barcelona'),
('Tarragona');

-- locality
INSERT INTO locality (name, province_id) VALUES
('Santa Coloma', 1),
('Hospitalet', 1),
('Torredembarra', 2);

-- address
INSERT INTO address (name, building_number, floor, door, postal_code, locality_id) VALUES
('Calle Falsa', '123', NULL, NULL, '08135', 1),
('Avenida Siempre Viva', '742', NULL, NULL, '08135', 1),
('Plaza del Sol', '45', NULL, NULL, '08135', 1),
('Calle Luna', '9', NULL, NULL, '08135', 3),
('Calle Mar', '12', NULL, NULL, '08135', 1),
('Avenida Río', '8', NULL, NULL, '08135', 1), 
('Calle Sant Adria', '6', NULL, NULL, '08001', 3),
('Calle Paseo Maritimo', '108',  NULL, NULL, '08001', 3),
('Calle Sol', '23', NULL, NULL, '08001', 3),
('Calle Ana de Armas', '75', NULL, NULL, '08001', 3),
('Calle Jonh Snow', '41', NULL, NULL, '08001', 3);

-- Clientes
INSERT INTO customer (name, surname, address_id, phone) VALUES
('Rita', 'Pérez', 1, '600123456'),
('Juan', 'López', 2, '600654321'),
('Pedro', 'Sanchez', 3, '600789123'),
('Fernando', 'Torres', 4, '600987654'),
('Paco', 'Leon', 5, '600456789'),
('Javier', 'Yo', 6, '600321654');

-- shop
INSERT INTO shop (name, address_id) VALUES
('Pizzeria Campidano', 7),
('Pizzeria Molto', 1);

INSERT INTO job_position(name) VALUES
('Coker'),
('Delibery man');

-- employee
INSERT INTO employee(name, surname, address_id, job_position_id, shop_id) VALUES
('Mariano', 'Rajoy', 9, 1, 1),
('Alberto', 'Primo', 8, 2, 1),
('Maribel', 'Patatas', 9, 1, 1);

-- product_type
INSERT INTO product_type(name, description) VALUES
('pizzas', 'home pizzas'),
('hamburgers', 'big hamburgers'),
('drinks', 'cold drinks');

-- pizza_category
INSERT INTO pizza_category (name) VALUES
('Clasic'),
('Special');

-- product
INSERT INTO product(product_type_id, pizza_category_id, name, description, picture, price) VALUES
(1, 1, 'Pizza napolitana', 'Pizzas with tomatoes', NULL, 11),
(1, 2, 'Pizza napolitana vegetarian', 'Pizzas with tomatoes', NULL, 15),
(2, NULL, 'Hamburger cheddar', 'hamburger with cheddar and onions', NULL, 5),
(3, NULL, 'Water', 'water cold', NULL, 2),
(3, NULL, 'Fanta naranja', 'drink cold', NULL, 3),
(3, NULL, 'Fanta Limon', 'drink cold', NULL, 3),
(3, NULL, 'Sprite', 'drink cold', NULL, 3);

-- delivery
INSERT INTO delivery(name) VALUES
('pick up in store'),
('home delivery');

-- orders
INSERT INTO orders (shop_id, customer_id, delivery_id, employee_reception_id, employee_delivery_id) VALUES
(1, 2, 1, 1, 1),
(1, 2, 1, 2, 2),
(1, 3, 2, 1, 1),
(2, 4, 2, 2, 2);

-- orders_detail
INSERT INTO orders_detail (orders_id, product_id, quantity) VALUES
(1, 1, 4),
(1, 2, 2),
(1, 4, 2),
(1, 5, 2),
(1, 6, 2),
(2, 3, 5),
(2, 1, 1),
(2, 5, 2),
(2, 7, 4),
(3, 1, 4),
(3, 4, 1),
(3, 6, 3),
(4, 3, 4),
(4, 5, 2),
(4, 7, 2);

-- Reactivar claves foráneas
SET FOREIGN_KEY_CHECKS = 1;

USE pizzeria;


-- Lists how many products from the 'drinks' category have been sold in a specific locality
SELECT DISTINCT l.name locality, pt.name product_type, pr.name product, SUM(od.quantity) total_product
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN locality l ON a.locality_id = l.locality_id
JOIN orders o ON c.customer_id = o.customer_id
jOIN orders_detail od ON o.orders_id = od.orders_id
JOIN product pr ON od.product_id = pr.product_id
JOIN product_type pt ON pr.product_type_id = pt.product_type_id
WHERE a.locality_id = 1 AND pr.product_type_id = 3
GROUP BY l.name, pt.name, pr.name;


-- Lists how many different orders a specific employee has made
SELECT CONCAT(e.name, ' ', e.surname) employee, o.orders_id
FROM employee e
JOIN orders o ON o.employee_reception_id = e.employee_id
WHERE e.employee_id = 2;
