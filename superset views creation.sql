CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    order_date DATE,
    quantity INT,
    total_amount NUMERIC(10,2)
);

CREATE TABLE regions (
    city VARCHAR(50) PRIMARY KEY,
    region VARCHAR(50)
);

INSERT INTO customers (customer_name, gender, age, city, signup_date) VALUES
('John Smith', 'Male', 34, 'New York', '2023-01-15'),
('Emily Johnson', 'Female', 28, 'Los Angeles', '2023-03-21'),
('Michael Brown', 'Male', 45, 'Chicago', '2022-11-05'),
('Sarah Davis', 'Female', 32, 'Houston', '2023-04-18'),
('David Wilson', 'Male', 39, 'Phoenix', '2023-02-10');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Coffee Maker', 'Appliances', 90.00),
('Running Shoes', 'Sports', 110.00);

INSERT INTO regions (city, region) VALUES
('New York', 'East'),
('Los Angeles', 'West'),
('Chicago', 'Midwest'),
('Houston', 'South'),
('Phoenix', 'Southwest');

INSERT INTO orders (customer_id, product_id, order_date, quantity, total_amount) VALUES
(1, 1, '2023-02-01', 1, 1200.00),
(2, 2, '2023-03-10', 2, 1600.00),
(3, 3, '2023-04-05', 1, 150.00),
(4, 4, '2023-04-20', 3, 270.00),
(5, 5, '2023-05-15', 1, 110.00),
(1, 2, '2023-06-02', 1, 800.00),
(2, 1, '2023-06-10', 1, 1200.00),
(3, 5, '2023-06-15', 2, 220.00);

create view sales_by_region as
select r.region, sum(o.total_amount) as total_sales
from orders o
join customers c on o.customer_id=c.customer_id
join regions r on c.city = r.city
group by r.region;

create view product_sales as
select p.product_name, sum(o.total_amount) as total_sales
from orders o
join products p on o.product_id=p.product_id
group by p.product_name;


create view Top_Selling_Products as
SELECT 
    o.order_id,
    o.order_date,
    o.quantity,
    o.total_amount,
    p.product_name,
    p.category,
    p.price
FROM orders o
JOIN products p ON o.product_id = p.product_id;



SELECT 
    o.order_id,
    o.order_date,
    o.quantity,
    o.total_amount,
    c.customer_name,
    c.gender,
    c.city,
    r.region,
    p.product_name,
    p.category,
    p.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
JOIN regions r ON c.city = r.city;


