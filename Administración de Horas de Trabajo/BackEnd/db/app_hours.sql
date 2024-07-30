CREATE TABLE users (
    id_user CHAR(30) PRIMARY KEY,
    email VARCHAR(90) UNIQUE NOT NULL,
    username VARCHAR(40),
    role_user ENUM('USER','SUPERADMIN') DEFAULT 'USER',
    status_user TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE persons (
    id_person CHAR(30) PRIMARY KEY,
    id_user CHAR(30),
    first_name VARCHAR(70) NOT NULL,
    last_name VARCHAR(70) NOT NULL,
    identity_document CHAR(15) NOT NULL,
    address_person VARCHAR(120) NOT NULL,
    cell_phone CHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE hours_worked (
    id_hour_worked INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_company INT UNSIGNED,
    id_user CHAR(30),
    day_worked VARCHAR(30) NOT NULL,
    date_worked DATE NOT NULL,
    start_time VARCHAR(25) NOT NULL,
    end_time VARCHAR(25) NOT NULL,
    total_hours VARCHAR(24) NOT NULL,
    observation VARCHAR(255) DEFAULT 'Sin Observación',
    FOREIGN KEY (id_company) REFERENCES companies(id_company),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE companies(
    id_company INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name_company VARCHAR(100) NOT NULL,
    status_company TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

