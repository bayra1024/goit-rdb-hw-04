1
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


2
INSERT INTO authors (author_name) VALUES
('George Orwell'),
('Astrid Lindgren');

INSERT INTO genres (genre_name) VALUES
('Dystopian'),
('Children\'s Fantasy');

INSERT INTO books (title, publication_year, author_id, genre_id) VALUES
('1984', 1949, 1, 1),
('Ronja, the Robber\'s Daughter', 1981, 2, 2);

INSERT INTO users (username, email) VALUES
('martin_johnson', 'martin_johnson@example.com'),
('marla_jordan', 'marla_jordan@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES
(1, 1, '2024-06-16', '2024-07-03'),
(2, 2, '2024-08-05', NULL);


3
SELECT *
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
INNER JOIN 
    customers ON orders.customer_id = customers.id
INNER JOIN 
    shippers ON orders.shipper_id = shippers.id
INNER JOIN 
    products ON order_details.product_id = products.id
INNER JOIN 
    categories ON products.category_id = categories.id
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.id
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id;


4.1
SELECT COUNT(*)
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
INNER JOIN 
    customers ON orders.customer_id = customers.id
INNER JOIN 
    shippers ON orders.shipper_id = shippers.id
INNER JOIN 
    products ON order_details.product_id = products.id
INNER JOIN 
    categories ON products.category_id = categories.id
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.id
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id; 


4.2
SELECT*
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
LEFT JOIN 
    customers ON orders.customer_id = customers.id
LEFT JOIN 
    shippers ON orders.shipper_id = shippers.id
LEFT JOIN 
    products ON order_details.product_id = products.id
LEFT JOIN 
    categories ON products.category_id = categories.id
RIGHT JOIN 
    suppliers ON products.supplier_id = suppliers.id
RIGHT JOIN 
    employees ON orders.employee_id = employees.employee_id    
WHERE 
    employees.employee_id > 3 AND employees.employee_id <= 10;  

Змінені LEFT JOIN та RIGHT JOIN можуть призвести до збільшення y кількості рядків у результаті запиту через включення додаткових рядків з відсутніми відповідностями.


4.3
SELECT *
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
INNER JOIN 
    customers ON orders.customer_id = customers.id
INNER JOIN 
    shippers ON orders.shipper_id = shippers.id
INNER JOIN 
    products ON order_details.product_id = products.id
INNER JOIN 
    categories ON products.category_id = categories.id
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.id
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id
WHERE 
    employees.employee_id > 3 AND employees.employee_id <= 10;


4.4    
SELECT 
    categories.name, 
    COUNT(*) AS number_of_orders,
    AVG(order_details.quantity) AS average_quantity 
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
INNER JOIN 
    customers ON orders.customer_id = customers.id
INNER JOIN 
    shippers ON orders.shipper_id = shippers.id
INNER JOIN 
    products ON order_details.product_id = products.id
INNER JOIN 
    categories ON products.category_id = categories.id
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.id
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id
WHERE 
    employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY 
    categories.name


4.5, 4.6, 4.7
SELECT 
    categories.name, 
    COUNT(*) AS number_of_orders,
    AVG(order_details.quantity) AS average_quantity 
FROM 
    order_details
INNER JOIN 
    orders ON order_details.order_id = orders.id
INNER JOIN 
    customers ON orders.customer_id = customers.id
INNER JOIN 
    shippers ON orders.shipper_id = shippers.id
INNER JOIN 
    products ON order_details.product_id = products.id
INNER JOIN 
    categories ON products.category_id = categories.id
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.id
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id
WHERE 
    employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY 
    categories.name
HAVING 
	AVG(order_details.quantity) > 21
ORDER BY 
    number_of_orders DESC
LIMIT 4 OFFSET 1;    
