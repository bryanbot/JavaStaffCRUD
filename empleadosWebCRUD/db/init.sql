SET NAMES 'utf8mb4';
SET CHARACTER SET utf8mb4;

CREATE DATABASE IF NOT EXISTS bdempleado
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE bdempleado;

CREATE TABLE IF NOT EXISTS empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    sueldo DECIMAL(10,2) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Opcional: Insertar datos de prueba
INSERT INTO empleado (nombres, apellidos, fecha_ingreso, sueldo) VALUES 
('Bryan', 'De Lama', '2026-01-01', 1500.00),
('Ana', 'García', '2026-01-05', 1800.00);