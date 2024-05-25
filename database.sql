CREATE DATABASE IF NOT EXISTS my_store;

USE my_store;

CREATE TABLE IF NOT EXISTS `Town`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `City`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    town_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Auth`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Address`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city_id INT NOT NULL,
    street VARCHAR(255) NOT NULL,
    neighbor VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `User`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    validated BOOLEAN NOT NULL DEFAULT 0,
    auth_id INT NOT NULL,
    -- city_id INT NOT NULL,
    address_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Role`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `User_Role`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    role_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `User_Cart`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    active BOOLEAN NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Cart`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_cart_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Image`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    url VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Product`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Product_Image`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Product_Cart`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    amount TINYINT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Product_Cart_Payed`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    amount TINYINT NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Comment` (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    content VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Rating_Product`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    product_id INT NOT NULL,
    qualification TINYINT NOT NULL,
    comment_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Store`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `Store_Product`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    store_id INT NOT NULL,
    product_id INT NOT NULL
);

-- Add foreign key constraints using ALTER TABLE statements
ALTER TABLE `City`
ADD CONSTRAINT fk_city_town_id FOREIGN KEY (town_id) REFERENCES `Town`(id) ON DELETE CASCADE;

ALTER TABLE `User`
ADD CONSTRAINT fk_user_auth_id FOREIGN KEY (auth_id) REFERENCES `Auth`(id) ON DELETE CASCADE,
-- ADD CONSTRAINT fk_user_user_id FOREIGN KEY (user_id) REFERENCES `User`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_user_address_id FOREIGN KEY (address_id) REFERENCES `Address`(id) ON DELETE CASCADE;

ALTER TABLE `User_Role`
ADD CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES `User`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_user_role_role_id FOREIGN KEY (role_id) REFERENCES `Role`(id) ON DELETE CASCADE;

ALTER TABLE `User_Cart`
ADD CONSTRAINT fk_user_cart_user_id FOREIGN KEY (user_id) REFERENCES `User`(id) ON DELETE CASCADE;

ALTER TABLE `Cart`
ADD CONSTRAINT fk_cart_user_cart_id FOREIGN KEY (user_cart_id) REFERENCES `User_Cart`(id) ON DELETE CASCADE;

ALTER TABLE `Product_Image`
ADD CONSTRAINT fk_product_image_product_id FOREIGN KEY (product_id) REFERENCES `Product`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_product_image_image_id FOREIGN KEY (image_id) REFERENCES `Image`(id) ON DELETE CASCADE;

ALTER TABLE `Product_Cart`
ADD CONSTRAINT fk_product_cart_cart_id FOREIGN KEY (cart_id) REFERENCES `Cart`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_product_cart_product_id FOREIGN KEY (product_id) REFERENCES `Product`(id) ON DELETE CASCADE;

ALTER TABLE `Product_Cart_Payed`
ADD CONSTRAINT fk_product_cart_payed_cart_id FOREIGN KEY (cart_id) REFERENCES `Cart`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_product_cart_payed_product_id FOREIGN KEY (product_id) REFERENCES `Product`(id) ON DELETE CASCADE;

ALTER TABLE `Rating_Product`
ADD CONSTRAINT fk_rating_product_product_id FOREIGN KEY (product_id) REFERENCES `Product`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_rating_product_comment_id FOREIGN KEY (comment_id) REFERENCES `Comment`(id) ON DELETE CASCADE;

ALTER TABLE `Store`
ADD CONSTRAINT fk_store_user_id FOREIGN KEY (user_id) REFERENCES `User`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_store_address_id FOREIGN KEY (address_id) REFERENCES `Address`(id) ON DELETE CASCADE;

ALTER TABLE `Store_Product`
ADD CONSTRAINT fk_store_product_store_id FOREIGN KEY (store_id) REFERENCES `Store`(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_store_product_product_id FOREIGN KEY (product_id) REFERENCES `Product`(id) ON DELETE CASCADE;

ALTER TABLE `Address`
ADD CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES `City`(id) ON DELETE CASCADE;

-- Create roles
INSERT INTO Role(id, name, description) VALUES(NULL, "user", "default user"), (NULL, "admin", "default admin");

-- Create towns
-- Insertar nombres de departamentos en la tabla Town
INSERT INTO `Town` (name) VALUES 
('Amazonas'),
('Antioquia'),
('Arauca'),
('Atlántico'),
('Bolívar'),
('Boyacá'),
('Caldas'),
('Caquetá'),
('Casanare'),
('Cauca'),
('Cesar'),
('Chocó'),
('Córdoba'),
('Cundinamarca'),
('Guainía'),
('Guaviare'),
('Huila'),
('La Guajira'),
('Magdalena'),
('Meta'),
('Nariño'),
('Norte de Santander'),
('Putumayo'),
('Quindío'),
('Risaralda'),
('San Andrés y Providencia'),
('Santander'),
('Sucre'),
('Tolima'),
('Valle del Cauca'),
('Vaupés'),
('Vichada');

-- Insertar ciudades representativas en la tabla City
-- Amazonas
INSERT INTO `City` (name, town_id) VALUES 
('Leticia', (SELECT id FROM Town WHERE name = 'Amazonas')),
('Puerto Nariño', (SELECT id FROM Town WHERE name = 'Amazonas'));

-- Antioquia
INSERT INTO `City` (name, town_id) VALUES 
('Medellín', (SELECT id FROM Town WHERE name = 'Antioquia')),
('Envigado', (SELECT id FROM Town WHERE name = 'Antioquia')),
('Itagüí', (SELECT id FROM Town WHERE name = 'Antioquia'));

-- Arauca
INSERT INTO `City` (name, town_id) VALUES 
('Arauca', (SELECT id FROM Town WHERE name = 'Arauca')),
('Saravena', (SELECT id FROM Town WHERE name = 'Arauca'));

-- Atlántico
INSERT INTO `City` (name, town_id) VALUES 
('Barranquilla', (SELECT id FROM Town WHERE name = 'Atlántico')),
('Soledad', (SELECT id FROM Town WHERE name = 'Atlántico'));

-- Bolívar
INSERT INTO `City` (name, town_id) VALUES 
('Cartagena', (SELECT id FROM Town WHERE name = 'Bolívar')),
('Magangué', (SELECT id FROM Town WHERE name = 'Bolívar'));

-- Boyacá
INSERT INTO `City` (name, town_id) VALUES 
('Tunja', (SELECT id FROM Town WHERE name = 'Boyacá')),
('Duitama', (SELECT id FROM Town WHERE name = 'Boyacá'));

-- Caldás
INSERT INTO `City` (name, town_id) VALUES 
('Manizales', (SELECT id FROM Town WHERE name = 'Caldas')),
('La Dorada', (SELECT id FROM Town WHERE name = 'Caldas'));

-- Caquetá
INSERT INTO `City` (name, town_id) VALUES 
('Florencia', (SELECT id FROM Town WHERE name = 'Caquetá')),
('El Paujil', (SELECT id FROM Town WHERE name = 'Caquetá'));

-- Casanare
INSERT INTO `City` (name, town_id) VALUES 
('Yopal', (SELECT id FROM Town WHERE name = 'Casanare')),
('Villanueva', (SELECT id FROM Town WHERE name = 'Casanare'));

-- Cauca
INSERT INTO `City` (name, town_id) VALUES 
('Popayán', (SELECT id FROM Town WHERE name = 'Cauca')),
('Santander de Quilichao', (SELECT id FROM Town WHERE name = 'Cauca'));

-- Cesar
INSERT INTO `City` (name, town_id) VALUES 
('Valledupar', (SELECT id FROM Town WHERE name = 'Cesar')),
('Aguachica', (SELECT id FROM Town WHERE name = 'Cesar'));

-- Chocó
INSERT INTO `City` (name, town_id) VALUES 
('Quibdó', (SELECT id FROM Town WHERE name = 'Chocó')),
('Nuquí', (SELECT id FROM Town WHERE name = 'Chocó'));

-- Córdoba
INSERT INTO `City` (name, town_id) VALUES 
('Montería', (SELECT id FROM Town WHERE name = 'Córdoba')),
('Sahagún', (SELECT id FROM Town WHERE name = 'Córdoba'));

-- Cundinamarca
INSERT INTO `City` (name, town_id) VALUES 
('Bogotá', (SELECT id FROM Town WHERE name = 'Cundinamarca')),
('Zipaquirá', (SELECT id FROM Town WHERE name = 'Cundinamarca'));

-- Guainía
INSERT INTO `City` (name, town_id) VALUES 
('Inírida', (SELECT id FROM Town WHERE name = 'Guainía')),
('Puerto Colombia', (SELECT id FROM Town WHERE name = 'Guainía'));

-- Guaviare
INSERT INTO `City` (name, town_id) VALUES 
('San José del Guaviare', (SELECT id FROM Town WHERE name = 'Guaviare')),
('El Retorno', (SELECT id FROM Town WHERE name = 'Guaviare'));

-- Huila
INSERT INTO `City` (name, town_id) VALUES 
('Neiva', (SELECT id FROM Town WHERE name = 'Huila')),
('Pitalito', (SELECT id FROM Town WHERE name = 'Huila'));

-- La Guajira
INSERT INTO `City` (name, town_id) VALUES 
('Riohacha', (SELECT id FROM Town WHERE name = 'La Guajira')),
('Maicao', (SELECT id FROM Town WHERE name = 'La Guajira'));

-- Magdalena
INSERT INTO `City` (name, town_id) VALUES 
('Santa Marta', (SELECT id FROM Town WHERE name = 'Magdalena')),
('Ciénaga', (SELECT id FROM Town WHERE name = 'Magdalena'));

-- Meta
INSERT INTO `City` (name, town_id) VALUES 
('Villavicencio', (SELECT id FROM Town WHERE name = 'Meta')),
('Granada', (SELECT id FROM Town WHERE name = 'Meta'));

-- Nariño
INSERT INTO `City` (name, town_id) VALUES 
('Pasto', (SELECT id FROM Town WHERE name = 'Nariño')),
('Tumaco', (SELECT id FROM Town WHERE name = 'Nariño'));

-- Norte de Santander
INSERT INTO `City` (name, town_id) VALUES 
('Cúcuta', (SELECT id FROM Town WHERE name = 'Norte de Santander')),
('Ocaña', (SELECT id FROM Town WHERE name = 'Norte de Santander'));

-- Putumayo
INSERT INTO `City` (name, town_id) VALUES 
('Mocoa', (SELECT id FROM Town WHERE name = 'Putumayo')),
('Puerto Asís', (SELECT id FROM Town WHERE name = 'Putumayo'));

-- Quindío
INSERT INTO `City` (name, town_id) VALUES 
('Armenia', (SELECT id FROM Town WHERE name = 'Quindío')),
('Calarcá', (SELECT id FROM Town WHERE name = 'Quindío'));

-- Risaralda
INSERT INTO `City` (name, town_id) VALUES 
('Pereira', (SELECT id FROM Town WHERE name = 'Risaralda')),
('Dosquebradas', (SELECT id FROM Town WHERE name = 'Risaralda'));

-- San Andrés y Providencia
INSERT INTO `City` (name, town_id) VALUES 
('San Andrés', (SELECT id FROM Town WHERE name = 'San Andrés y Providencia')),
('Providencia', (SELECT id FROM Town WHERE name = 'San Andrés y Providencia'));

-- Santander
INSERT INTO `City` (name, town_id) VALUES 
('Bucaramanga', (SELECT id FROM Town WHERE name = 'Santander')),
('Girón', (SELECT id FROM Town WHERE name = 'Santander'));

-- Sucre
INSERT INTO `City` (name, town_id) VALUES 
('Sincelejo', (SELECT id FROM Town WHERE name = 'Sucre')),
('Corozal', (SELECT id FROM Town WHERE name = 'Sucre'));

-- Tolima
INSERT INTO `City` (name, town_id) VALUES 
('Ibagué', (SELECT id FROM Town WHERE name = 'Tolima')),
('Espinal', (SELECT id FROM Town WHERE name = 'Tolima'));

-- Valle del Cauca
INSERT INTO `City` (name, town_id) VALUES 
('Cali', (SELECT id FROM Town WHERE name = 'Valle del Cauca')),
('Buenaventura', (SELECT id FROM Town WHERE name = 'Valle del Cauca'));

-- Vaupés
INSERT INTO `City` (name, town_id) VALUES 
('Mitú', (SELECT id FROM Town WHERE name = 'Vaupés')),
('Carurú', (SELECT id FROM Town WHERE name = 'Vaupés'));

-- Vichada
INSERT INTO `City` (name, town_id) VALUES 
('Puerto Carreño', (SELECT id FROM Town WHERE name = 'Vichada')),
('Cumaribo', (SELECT id FROM Town WHERE name = 'Vichada'));

-- Procedures

-- Gell al towns
CREATE PROCEDURE  GetAllTowns() 

BEGIN
	SELECT * from Town;
END;

-- Get all citis by town's id

CREATE PROCEDURE GetCityByTownId(id INT)

BEGIN
	SELECT * FROM City WHERE town_id = id;
END;


-- Store user
CREATE PROCEDURE `StoreUser`(IN json_data JSON)
BEGIN
	DECLARE user_id INT;
	DECLARE role_id INT;
    DECLARE address_id INT;
    DECLARE auth_id INT;
    DECLARE city_id INT;
    DECLARE description TEXT;
    DECLARE neighbor VARCHAR(255);
    DECLARE street VARCHAR(255);
    DECLARE email VARCHAR(255);
    DECLARE last_name VARCHAR(255);
    DECLARE name VARCHAR(255);
    DECLARE pass VARCHAR(255);
    DECLARE phone VARCHAR(20);


    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    SET city_id = JSON_EXTRACT(json_data, '$.address.city_id');
    SET description = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.description'));
    SET neighbor = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.neighbor'));
    SET street = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.street'));

    INSERT INTO Address (city_id, description, neighbor, street)
    VALUES (city_id, description, neighbor, street);

    SET address_id = LAST_INSERT_ID();

    SET email = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.email'));
    SET pass = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.password'));

    INSERT INTO Auth (email, password) VALUES (email, pass);

    SET auth_id = LAST_INSERT_ID();

    SET last_name = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.last_name'));
    SET name = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.name'));
    SET phone = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.phone'));

    INSERT INTO User (address_id, auth_id, last_name, name, phone)
    VALUES (address_id, auth_id, last_name, name, phone);
    
    SET user_id = LAST_INSERT_ID();
	SELECT id INTO role_id FROM Role WHERE Role.name = 'user';
    
    INSERT INTO User_Role(user_id, role_id) VALUES(user_id, role_id);

    COMMIT;
    SELECT * FROM User WHERE id = user_id;
END

-- Get user login and if it validated
CREATE PROCEDURE `GetUserLogin`(IN email VARCHAR(255), IN is_admin TINYINT(1))
BEGIN
	DECLARE role_name TEXT;
    IF is_admin THEN
		SELECT name INTO role_name FROM Role WHERE name = "admin";
	ELSE 
		SELECT name INTO role_name FROM Role WHERE name = "user";
    END IF;
	SELECT a.id as auth_id, u.id, a.email, a.password, u.validated, r.name as role_name FROM Auth a INNER JOIN User u ON a.email = email AND a.id = u.auth_id INNER JOIN User_Role as ur ON ur.user_id = u.id INNER JOIN Role r ON r.id = ur.role_id AND r.name = role_name;
END

-- Create a new store
CREATE PROCEDURE `CreateStore`(IN json_data JSON)
BEGIN
    DECLARE user_id INT;
    DECLARE address_id INT;
    DECLARE city_id INT;
    DECLARE name VARCHAR(255);
    DECLARE description_store VARCHAR(255);
    DECLARE description_address VARCHAR(255);
    DECLARE neighbor VARCHAR(255);
    DECLARE street VARCHAR(255);
    DECLARE store_id INT;
    DECLARE admin_role_id INT;

    -- Rollback if transaction failed and return error message with error code
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

    START TRANSACTION;

	SET city_id = JSON_EXTRACT(json_data, '$.address.city_id');
    SET description_address = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.description'));
    SET neighbor = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.neighbor'));
    SET street = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.address.street'));

    INSERT INTO Address (city_id, description, neighbor, street)
    VALUES (city_id, description_address, neighbor, street);

    SET address_id = LAST_INSERT_ID();

    SET name = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.name'));
    SET description_store = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.description'));
    SET user_id = JSON_UNQUOTE(JSON_EXTRACT(json_data, "$.user_id"));

    -- Insert into Store table
    INSERT INTO Store(name, description, user_id, address_id) VALUES(name, description_store, user_id, address_id);
    SET store_id = LAST_INSERT_ID();
    
    SELECT id INTO admin_role_id FROM Role WHERE Role.name = "Admin";
    
    IF admin_role_id IS NOT NULL THEN
		IF NOT EXISTS (SELECT 1 FROM User_Role WHERE User_Role.user_id = user_id AND User_Role.role_id = admin_role_id) THEN
			INSERT INTO User_Role(user_id, role_id) VALUES(user_id, admin_role_id);
		END IF;
	ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Admin role not exist';
	END IF;

    COMMIT;
    SELECT * FROM Store WHERE id = store_id;
END

-- Create a product
CREATE PROCEDURE `CreateProduct`(IN json_data JSON)
BEGIN
    DECLARE store_id INT;
    DECLARE product_id INT;
    DECLARE name VARCHAR(255);
    DECLARE description VARCHAR(255);
    DECLARE price FLOAT;

    -- Loop variables
    DECLARE i INT DEFAULT 0;
    DECLARE n INT;

    -- Error handler
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Extract JSON values
    SET store_id = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.store_id'));
    SET name = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.name'));
    SET description = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.description'));
    SET price = JSON_UNQUOTE(JSON_EXTRACT(json_data, '$.price'));

    -- Insert into Product table
    INSERT INTO Product(name, description, price) VALUES(name, description, price);
    SET product_id = LAST_INSERT_ID();

    -- Insert into Store_Product table
    INSERT INTO Store_Product(store_id, product_id) VALUES (store_id, product_id);

    -- Loop through the images array
    SET n = JSON_LENGTH(json_data, '$.images');
    WHILE i < n DO
        SET @image_url = JSON_UNQUOTE(JSON_EXTRACT(json_data, CONCAT('$.images[', i, '].url')));
        
        -- Insert into Image table
        INSERT INTO Image(url) VALUES (@image_url);
        SET @last_image_id = LAST_INSERT_ID();
        
        -- Insert into Product_Image table
        INSERT INTO Product_Image(product_id, image_id) VALUES (product_id, @last_image_id);
        
        -- Increment the counter
        SET i = i + 1;
    END WHILE;

    COMMIT;
    
    -- Return the inserted product
    SELECT * FROM Product WHERE Product.id = product_id;
END



COMMIT;
