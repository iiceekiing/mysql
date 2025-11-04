-- =========================================================
-- DATABASE: company_db
-- DESCRIPTION: Employee and Salary Management Schema
-- AUTHOR: iiceekiing
-- CREATED: 2025-11-04
-- =========================================================

-- ✅ Create the database (if it doesn’t exist)
CREATE DATABASE IF NOT EXISTS company_db;

-- ✅ Use the newly created database
USE company_db;

-- =========================================================
-- 1️⃣ EMPLOYEES TABLE
-- Stores basic employee information.
-- =========================================================
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,             -- Unique employee ID
    first_name VARCHAR(100) NOT NULL,              -- Employee's first name
    last_name VARCHAR(100) NOT NULL,               -- Employee's last name
    gender ENUM('M', 'F') NOT NULL,                -- Gender (M/F)
    date_of_birth DATE,                            -- Optional date of birth
    hire_date DATE,                                -- Optional date of hiring
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,-- Record creation time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Last update time
);

-- =========================================================
-- 2️⃣ SALARIES TABLE
-- Stores salary information for each employee.
-- Linked to employees table using FOREIGN KEY.
-- =========================================================
CREATE TABLE salaries (
    id INT AUTO_INCREMENT PRIMARY KEY,             -- Unique salary record ID
    employee_id INT NOT NULL,                      -- Refers to employee's ID
    amount DECIMAL(10,2) NOT NULL,                 -- Salary amount
    from_date DATE NOT NULL,                       -- Salary start date
    to_date DATE,                                  -- Optional end date
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- ✅ Foreign key to link each salary to an employee
    CONSTRAINT fk_employee FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE                          -- If an employee is deleted, remove their salary too
        ON UPDATE CASCADE
);

-- =========================================================
-- 3️⃣ ADD UNIQUE CONSTRAINT ON employee_id IN salaries
-- Ensures each employee has only one salary record.
-- =========================================================
ALTER TABLE salaries
ADD CONSTRAINT unique_employee_salary UNIQUE (employee_id);

-- =========================================================
-- 4️⃣ SAMPLE DATA
-- =========================================================
INSERT INTO employees (first_name, last_name, gender, date_of_birth, hire_date)
VALUES
('John', 'Doe', 'M', '1990-05-12', '2020-01-01'),
('Jane', 'Smith', 'F', '1992-08-25', '2021-03-14'),
('Alex', 'Brown', 'M', '1988-12-10', '2019-07-09'),
('Mary', 'Johnson', 'F', '1995-11-20', '2022-09-01');

INSERT INTO salaries (employee_id, amount, from_date)
VALUES
(1, 550000.00, '2020-01-01'),
(2, 620000.00, '2021-03-14'),
(3, 700000.00, '2019-07-09'),
(4, 450000.00, '2022-09-01');

-- =========================================================
-- ✅ EXAMPLE QUERIES
-- =========================================================

-- 1. Show all employees
SELECT * FROM employees;

-- 2. Show total number of male employees
SELECT COUNT(*) AS total_males FROM employees WHERE gender = 'M';

-- 3. Show employee + salary joined view
SELECT e.first_name, e.last_name, s.amount AS salary, s.from_date
FROM employees e
JOIN salaries s ON e.id = s.employee_id;

-- =========================================================
-- END OF FILE
-- =========================================================
