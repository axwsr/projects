DROP DATABASE IF EXISTS barberia;
CREATE DATABASE barberia;
USE barberia;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "-05:00";



CREATE TABLE usuario(
    id_usuario CHAR(30) PRIMARY KEY,
    correo VARCHAR(80) NOT NULL,
    contrasenia VARCHAR(250) NOT NULL,
    rol ENUM('SUPERADMIN','BARBERO'),
    created_at TIMESTAMP,
    estado_usuario TINYINT(1) DEFAULT 1
);

CREATE TABLE tarifa(
    id_tarifa INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario CHAR(30),
    descripcion VARCHAR(100) NOT NULL,
    costo SMALLINT UNSIGNED NOT NULL,
    created_at TIMESTAMP,
    estado_tarifa TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE reserva (
    id_reserva INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario CHAR(30),
    cliente VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado_reserva TINYINT(1) DEFAULT 0,
    id_tarifa INT UNSIGNED,
    created_at TIMESTAMP,
    FOREIGN KEY (id_tarifa) REFERENCES tarifa(id_tarifa),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE movimientos(
    id_movimientos INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario CHAR(30),
    cuenta FLOAT(10,2) NOT NULL,
    tipo_movimiento ENUM('INGRESO','GASTO'),
    fecha DATE NOT NULL,
    descripcion TEXT,
    created_at TIMESTAMP,
    estado_gasto TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


INSERT INTO `usuario` (`id_usuario`, `correo`, `contrasenia`, `rol`, `estado_usuario`) VALUES
('42wgnk2xMsBODXI9CpFDftUxDSmSMn', 'winder@gmail.com', '$2b$12$cyr2SZu703rNSF5OkxghCuzPlNZGOSDS2clPPJcCSau3RPDHtdes.', 'SUPERADMIN', 1),
('7hDj9DmYUSdfrrbjQU5iWKClL4UYen', 'patron@mail.com', '$2b$12$SfVZEyvAGZuGdlnKYZKBdOEpbgBLAlR4d5cF6KPkONyWWLKD3pmqm', 'SUPERADMIN', 1),
('DwoznM0AvFXV28EPDhpCl9wPOsqFux', 'user10@example.com', '$2b$12$fsdlCeTvr1Iq5jIX5m93GuKGyfWmkzo6rI7LOAAgmAbo7T4T96xNC', 'BARBERO', 1),
('G0BgHtRKvSmzaoMvXmcNZEyluSM7y6', 'milu@mail.com', '$2b$12$zYuj8Nt4GHfsKy9F3S9N2OQ5Lq62TtaJEtRJUSyioIhjLKGAfxwsq', 'BARBERO', 1),
('Gp1q2OZwEv3aklEto8cX9pvpEKMHFT', 'mateo@mail.com', '$2b$12$ExyQSeLcG/1ZovP7I/cIHOYbmpcK3BQWjWHSuSDbJXuTQfbJji.MW', 'SUPERADMIN', 1),
('JG2PgMvagVKxRWEWK7lNAXle6TTACF', 'patron2@gmail.com', '$2b$12$iSJvhNYbQhdXu3pZJG5WSey1MZNxFHvnQY5Ljku3oCeBKpw3l6h02', 'SUPERADMIN', 1),
('mvEPrFmVAHxiyC1eOqGu5zmT0mfrz6', 'braulio@gmail.com', '$2b$12$L3lSqvjUp9FBEu99pRQDgO2TtTIiq4aK92XvNKMwyLJ.oV7Dmv8Ty', 'SUPERADMIN', 1),
('N8Hw0t9SXbRgjIppRteiGZeWxRLkru', 'user3@example.com', '$2b$12$sguVhgGXqsk..5P7lFqGyeFi9ge8MOc4T1ckx/1T0360PTYBRSDKG', 'BARBERO', 1),
('OaYhqvnl6s0DJTANQX0jFPrQj8MbDw', 'JUANPISS@example.com', '$2b$12$dcxtPEBDWZR9IT.bVmSmDeEfS6wvx.G.M3rWvUlFzw6aVR1HY3oM6', 'BARBERO', 0),
('plZr7wfSLDQac8bj1G5zVoEpr10tUM', 'user@example.com', '$2b$12$O3fLsh5FT2r9sFQztpG9..m1Nzu1C./wjseVL4Yi6CEWQvaViEFc.', 'BARBERO', 1),
('Q62ehy208AhtcLeXgE0zzsQmrHvcec', 'user5@example.com', '$2b$12$ybcsZsGkHiygzAmDLWzuPOL0Rj9iopxcxJ66cFcfeLB3NSIvA8cC2', 'BARBERO', 1),
('U3h1ZpO3onjHyfYu0OYh558eUiT5aF', 'user2@example.com', '$2b$12$Yo9ZMDnBUg0UfYaISgm6ROiYBK0mgPFJhoo0vWyCYnWijgV5P8SKW', 'BARBERO', 1),
('YzR0ReQOG8bvUuv31J4yGBW8aAuVCS', 'user4@example.com', '$2b$12$SeT65vSaR5WkxJqkhmLEuez555LEaVtRzzt2aqy1tAgr1iCGH50Z2', 'BARBERO', 1);

