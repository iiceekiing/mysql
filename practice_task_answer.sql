-- =====================================================
-- Project: SQL Fundamentals — Users & Products Relationship
-- Author: iiceekiing
-- Date: 2025-11-05
-- Description: Solutions for all tasks in the SQL assignment.
-- =====================================================


-- =====================================================
-- Task 1: Create 'users' table
-- =====================================================


CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- =====================================================
-- Task 2: Insert 20 Users (pre-populated)
-- =====================================================
INSERT INTO users (first_name, last_name, email, gender) VALUES
('Alice', 'Johnson', 'alice@example.com', 'F'),
('Benjamin', 'Smith', 'benjamin@example.com', 'M'),
('Chidera', 'Okafor', 'chidera@example.com', 'F'),
('David', 'George', 'david@example.com', 'M'),
('Emily', 'Adams', 'emily@example.com', 'F'),
('Frank', 'Adeyemi', 'frank@example.com', 'M'),
('Grace', 'Lawal', 'grace@example.com', 'F'),
('Henry', 'Ogunleye', 'henry@example.com', 'M'),
('Ifeoma', 'Ojo', 'ifeoma@example.com', 'F'),
('John', 'Eze', 'john@example.com', 'M'),
('Kemi', 'Afolabi', 'kemi@example.com', 'F'),
('Luka', 'Bello', 'luka@example.com', 'M'),
('Mary', 'Ogunbiyi', 'mary@example.com', 'F'),
('Nathan', 'Olawale', 'nathan@example.com', 'M'),
('Oluwatobi', 'Okon', 'oluwatobi@example.com', 'M'),
('Peace', 'Anyanwu', 'peace@example.com', 'F'),
('Queen', 'Mohammed', 'queen@example.com', 'F'),
('Richard', 'Adeniran', 'richard@example.com', 'M'),
('Stella', 'Ibrahim', 'stella@example.com', 'F'),
('Tunde', 'Adewale', 'tunde@example.com', 'M');




-- =====================================================
-- Task 3: Create 'products' table
-- =====================================================
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);



-- =====================================================
-- Task 4: Insert 500 products (example using procedure)
-- =====================================================
DELIMITER //
CREATE PROCEDURE populate_products()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE userId INT;
    WHILE i <= 500 DO
        SET userId = FLOOR(1 + RAND() * 20);
        INSERT INTO products (user_id, product_name, quantity, unit_price, created_at)
        VALUES (
            userId,
            CONCAT('Product_', i),
            FLOOR(1 + RAND() * 100),
            ROUND(10 + RAND() * 1000, 2),
            NOW() - INTERVAL FLOOR(RAND() * 365) DAY
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL populate_products();



-- =====================================================
-- Task 5: Get products by a particular quantity (e.g., 50 units)
-- =====================================================
SELECT * 
FROM products
WHERE quantity = 50;



-- =====================================================
-- Task 6: Get products created within a date range (Jan 1, 2025 - Mar 31, 2025)
-- =====================================================
SELECT *
FROM products
WHERE created_at BETWEEN '2025-01-01' AND '2025-03-31';



-- =====================================================
-- Task 7: Sum quantity based on product name
-- =====================================================
SELECT product_name, SUM(quantity) AS total_quantity
FROM products
GROUP BY product_name
ORDER BY total_quantity DESC;



-- =====================================================
-- Task 8: Calculate total stock value per user
-- =====================================================
SELECT u.id AS user_id, u.first_name, u.last_name,
       SUM(p.quantity * p.unit_price) AS total_stock_value
FROM users u
JOIN products p ON u.id = p.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_stock_value DESC;



-- =====================================================
-- Task 9: Update all products below quantity 5 to quantity 10
-- =====================================================
UPDATE products
SET quantity = 10
WHERE quantity < 5;



-- =====================================================
-- Task 10: Update user email domain to @dbmaniac.com
-- =====================================================
UPDATE users
SET email = CONCAT(SUBSTRING_INDEX(email, '@', 1), '@dbmaniac.com');



-- =====================================================
-- Task 11: Get products grouped by creation date (count per day)
-- =====================================================
SELECT DATE(created_at) AS creation_date, COUNT(*) AS product_count
FROM products
GROUP BY DATE(created_at)
ORDER BY creation_date;



-- =====================================================
-- Task 12: Add a new user and 5 products
-- =====================================================
INSERT INTO users (first_name, last_name, email, gender)
VALUES ('iiceekiing', 'Iceking', 'iiceekiing@dbmaniac.com', 'M');

SET @new_user_id = LAST_INSERT_ID();

INSERT INTO products (user_id, product_name, quantity, unit_price)
VALUES
(@new_user_id, 'iiceekiingProduct_1', 10, 250.00),
(@new_user_id, 'iiceekiingProduct_2', 5, 120.50),
(@new_user_id, 'iiceekiingProduct_3', 20, 19.99),
(@new_user_id, 'iiceekiingProduct_4', 2, 999.99),
(@new_user_id, 'iiceekiingProduct_5', 50, 4.50);




-- =====================================================
-- Task 13: Delete all products created before 2023
-- =====================================================
DELETE FROM products
WHERE YEAR(created_at) < 2023;




-- =====================================================
-- Task 14: Find average price of products per user
-- =====================================================
SELECT u.id AS user_id, u.first_name, u.last_name,
       AVG(p.unit_price) AS avg_price
FROM users u
JOIN products p ON u.id = p.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY avg_price DESC;



-- =====================================================
-- Task 15: Identify top 5 users with highest total product stock value
-- =====================================================
SELECT u.id AS user_id, u.first_name, u.last_name,
       SUM(p.quantity * p.unit_price) AS total_stock_value
FROM users u
JOIN products p ON u.id = p.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_stock_value DESC
LIMIT 5;
