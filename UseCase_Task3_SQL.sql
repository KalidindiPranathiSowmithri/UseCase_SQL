CREATE DATABASE USECASE_TASK3;
USE USECASE_TASK3;
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO customers (customer_id, customer_name, city)
VALUES
('C101', 'Rahul', 'Hyderabad'),
('C102', 'Priya', 'Bangalore'),
('C103', 'Amit', 'Chennai');



CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO products (product_id, product_name, price)
VALUES
('P101', 'Laptop', 50000),
('P102', 'Mobile', 20000),
('P103', 'Headphones', 2000);

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    status VARCHAR(20),
    FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);

INSERT INTO orders (order_id, customer_id, product_id, quantity, status)
VALUES
('O101', 'C101', 'P101', 1, 'Delivered'),
('O102', 'C102', 'P102', 2, 'Delivered'),
('O103', 'C103', 'P103', 1, 'Pending'),
('O104', 'C101', 'P102', 1, 'Delivered');


SELECT * FROM customers;
SELECT * from products;
select * from orders;


SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    o.quantity,
    o.status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id;

SELECT
    c.customer_name,
    SUM(o.quantity * p.price) AS total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY c.customer_name;


SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;

SELECT
    p.product_name,
    SUM(o.quantity * p.price) AS sales_amount
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY sales_amount DESC
LIMIT 1;


SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
