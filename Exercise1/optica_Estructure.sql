USE Optica;

CREATE TABLE Supplier (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    fax VARCHAR(20),
    nif VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Glasses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50) NOT NULL,
    left_lens_diopter FLOAT NOT NULL,
    right_lens_diopter FLOAT NOT NULL,
    frame_type ENUM('floating', 'plastic', 'metal') NOT NULL,
    frame_color VARCHAR(30) NOT NULL,
    left_lens_color VARCHAR(30) NOT NULL,
    right_lens_color VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(id)
);

CREATE TABLE Customer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    referred_by INT,
    FOREIGN KEY (referred_by) REFERENCES Customer(id)
);

CREATE TABLE Employee (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Sale (
    id INT PRIMARY KEY AUTO_INCREMENT,
    glasses_id INT NOT NULL,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (glasses_id) REFERENCES Glasses(id),
    FOREIGN KEY (customer_id) REFERENCES Customer(id),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
    
);

