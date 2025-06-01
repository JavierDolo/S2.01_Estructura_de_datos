USE Optica

-- Lista el total de facturas de un cliente/a en un período determinado.
SELECT c.name AS Customer, COUNT(s.id) AS Total_Sales
FROM Sale s
JOIN Customer c ON s.customer_id = c.id
WHERE s.sale_date BETWEEN '2025-05-01' AND '2025-05-31'
AND c.id = 1  -- Reemplaza '1' con el ID del cliente que deseas consultar
GROUP BY c.name;

-- Lista los diferentes modelos de gafas que ha vendido un empleado durante un año.
SELECT DISTINCT g.brand AS Glasses_Model, e.name AS Employee
FROM Sale s
JOIN Glasses g ON s.glasses_id = g.id
JOIN Employee e ON s.employee_id = e.id
WHERE YEAR(s.sale_date) = 2025
AND e.id = 2;  -- Reemplaza '2' con el ID del empleado que deseas consultar

-- Lista a los diferentes proveedores que han suministrado gafas vendidas con éxito por la óptica.
SELECT DISTINCT p.name AS Supplier
FROM Sale s
JOIN Glasses g ON s.glasses_id = g.id
JOIN Supplier p ON g.supplier_id = p.id;

