USE Optica;

INSERT INTO Supplier (name, address, phone, fax, nif) VALUES
('OptiGlass Ltd.', '123 Main St, Madrid, Spain', '+34 911223344', '+34 911223355', 'A12345678'),
('VisionWorld S.A.', '45 Optical Ave, Barcelona, Spain', '+34 932345678', '+34 932345679', 'B98765432'),
('ClearSight Corp.', '78 Lens Lane, Valencia, Spain', '+34 960123456', '+34 960123457', 'C56789012');

INSERT INTO Glasses (brand, left_lens_diopter, right_lens_diopter, frame_type, frame_color, left_lens_color, right_lens_color, price, supplier_id) VALUES
('Ray-Ban', 1.5, 2.0, 'plastic', 'black', 'blue', 'blue', 120.50, 1),
('Carrera', 2.0, 1.75, 'metal', 'silver', 'green', 'green', 150.75, 2),
('Lois', 1.0, 1.25, 'floating', 'gold', 'brown', 'brown', 180.30, 3);

INSERT INTO Customer (name, address, phone, email, registration_date, referred_by) VALUES
('Javier López', '67 Ocean Drive, Barcelona, Spain', '+34 600112233', 'javier.lopez@email.com', '2025-05-20', NULL),
('Maria Fernández', '89 Sunset Blvd, Madrid, Spain', '+34 612334455', 'maria.fernandez@email.com', '2025-05-21', 1),
('Carlos Martínez', '23 Avenida Central, Valencia, Spain', '+34 622556677', 'carlos.martinez@email.com', '2025-05-22', 2);

INSERT INTO Employee (name) VALUES
('Pedro Pascal');

INSERT INTO Sale (glasses_id, customer_id, employee_id, sale_date) VALUES
(1, 1, 1, '2025-05-22'),
(2, 2, 1, '2025-05-23'),
(3, 3, 1, '2025-05-24');