
````markdown
# SQL Fundamentals — Users & Products Relationship

## Overview
This project is an intermediate-level SQL assignment that focuses on relational database concepts, data manipulation, filtering, aggregation, and reporting using a **Users ↔ Products** relationship model.  

Students interact with two main tables:

1. **users** — Represents system users.
2. **products** — Represents products owned by users. Each product belongs to one user.

The database comes pre-populated with sample data. The tasks focus on querying, updating, aggregating, and inserting data, giving practical experience with SQL.

---



## Database Schema

### **users** Table
| Column      | Type                              | Description                               |
|------------ |----------------------------------|-------------------------------------------|
| id          | INT (PK, AUTO_INCREMENT)         | Unique user ID                             |
| first_name  | VARCHAR(50)                      | User’s first name                           |
| last_name   | VARCHAR(50)                      | User’s last name                            |
| email       | VARCHAR(100), UNIQUE             | User’s email address                        |
| gender      | CHAR(1), CHECK ('M','F')         | User’s gender                               |
| created_at  | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | Record creation time                     |
| updated_at  | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Record update time |




### **products** Table
| Column       | Type                       | Description                                 |
|------------- |----------------------------|---------------------------------------------|
| id           | INT (PK, AUTO_INCREMENT)  | Unique product ID                            |
| user_id      | INT (FK → users.id)       | Owner of the product                         |
| product_name | VARCHAR(100)              | Product name                                 |
| quantity     | INT                        | Quantity in stock                            |
| unit_price   | DECIMAL(10,2)             | Price per unit                               |
| created_at   | TIMESTAMP DEFAULT CURRENT_TIMESTAMP | Creation time                           |
| updated_at   | TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last modification time |

---

## Project Setup

1. **Clone the Repository**

```bash
git clone https://github.com/iiceekiing/mysql.git
cd mysql
````

2. **Run SQL Scripts**

* **Step 1:** Create tables and insert 20 users:

```sql
source setup_tables_and_users.sql;
```

* **Step 2:** Populate 500 random products:

```sql
source populate_products.sql;
```

---

## Project Tasks


### **Task 3: Get Products by a Particular Quantity**

Retrieve all products with a specific quantity, e.g., 50 units.


### **Task 4: Get Products Created Within a Date Range**

Find products created between January 1, 2025, and March 31, 2025.


### **Task 5: Sum Quantity Based on Product Name**

Compute the total quantity available per product.


### **Task 6: Calculate Total Stock Value per User**

Calculate total stock value = quantity × unit_price per user.


### **Task 7: Update Product or User Records**

* Update products below quantity 5 to quantity 10.
* Update user emails to a new domain `@dbmaniac.com`.


### **Task 8: Order and Group by Creation Date**

Get products grouped by creation date with count per day.


### **Additional Tasks**

* Add a new user and at least 5 products for them.
* Delete all products created before a specific year.
* Find the average product price per user.
* Identify the top 5 users with the highest total product stock value.

---

## Technologies Used

* **MySQL** — Relational database management system
* **SQL** — Queries, updates, aggregation, and joins

---


## Author

* **iiceekiing**
* Fullstack Developer | SQL Enthusiast

* [GitHub](https://github.com/iiceekiing)

---

## License

This project is open-source and available under the MIT License.

```

