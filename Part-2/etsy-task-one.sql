/* PART 2 (One to Many)
TASK 1
(Again, you may want to create a new database)

A second company has seen the website we designed for The Guardian 2 and have decided to employ us to build them a new e-commerce store. Let's call them Etsy 2.

We need to design the table(s) for this e-commerce website.

Here are some requirements:

- The database needs to store information on products
- Each product can have a single seller
- Each seller can have multiple products
- Each product should have a title, summary, the full product, price, and the date it was advertised
- We should also store each seller's name, email address, password, a short bio, and the date that they joined

Here are some tasks:

- Design the table(s), and which fields they should have
- Specify the data types for each field
- Specify any constraints (e.g. primary keys, foreign keys, unique constraints)
- Write the SQL to create these table(s)
- Write the SQL to insert some fake product data
-- There should be at least five sellers
-- Each seller should have between 1-5 products */

--- Create Etsy Database 
CREATE DATABASE etsy_2 

-- Create Sellers table:  
CREATE TABLE sellers ( 
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL, 
    bio VARCHAR(255), 
    date_joined DATE NOT NULL
); 

-- Create Products table: 
CREATE TABLE products (
    id SERIAL PRIMARY KEY, 
    title VARCHAR(25), 
    summary VARCHAR(255),
    full_product VARCHAR(25),
    price MONEY, 
    date_advertised DATE NOT NULL,
    seller_id INT REFERENCES sellers(id)
); 

-- Insert 5 sellers: 
INSERT INTO sellers (id, first_name, last_name, email, password, bio, date_joined) VALUES 
(1, 'Herbert', 'Blackwood', 'h.blackwood@pretend.com', 'hbpassword1', 'Crafting unique handmade jewelry pieces', '2023-04-12'), 
(2, 'Ruari', 'Thornton', 'r.thornton@pretend.com', 'rtpassword2', 'Custom woodworking and carpentry designs', '2023-07-23'), 
(3, 'Sam', 'Keane', 's.keane@pretend.com', 'skpassword3', 'Specializing in handmade stained glass', '2023-09-15'), 
(4, 'Edwin', 'Thistle', 'e.tlackwood@pretend.com', 'etpassword4', ' Artisanal leather goods and accessories', '2023-11-07'), 
(5, 'Amelia', 'Bennett', 'a.bennett@pretend.com', 'abpassword5', 'Hand-painted ceramics, cards and pottery', '2024-02-05'); 

-- Insert 5 products: 
INSERT INTO products (id, title, summary, full_product, price, date_advertised, seller_id) VALUES 
(1, 'Signet ring', 'An exquisite ring with intricate design', 'Handmade Jewelery', 75.00, '2024-01-12', 1), 
(2, 'Amber Earrings', 'Gold intricate amber earrings', 'Handmade Jewelery', 75.00, '2024-03-12', 1), 
(3, 'Wooden Vinyl Cabinet', 'A beautifully crafted record cabinet', 'Handmade Furtniture', 200.00, '2024-05-12', 2), 
(4, 'Wooden Bookshelf', 'A sturdy custom bookshelf', 'Handmade Furtniture', 200.00, '2023-10-08', 2), 
(5, 'Stained Glass Window', 'An exquisite handmade stained glass window', 'Stained Glass', 500.00, '2024-05-15', 3), 
(6, 'Stained Glass Lamp', 'An exquisite handmade stained glass lamp', 'Stained Glass', 450.00, '2024-02-14', 3), 
(7, 'Leather Wallet', 'A premium handcrafted leather wallet', 'Leather Goods', 200.00, '2024-05-26', 4), 
(8, 'Leather Belt', 'A premium handcrafted leather belt', 'Leather Goods', 80.00, '2023-09-04', 4), 
(9, 'Ceramic Bowl', 'Handmade ceramic bowl with unique design', 'Ceramics', 40.00, '2024-05-26', 5),
(10, 'Ceramic Mug', 'Handmade ceramic mug with unique design', 'Ceramics', 35.00, '2024-05-20', 5); 


--- Write the SQL queries to retrieve the following data:

-- List all product titles
SELECT title
FROM products; 

-- List all product titles, with the seller's name
SELECT products.title, sellers.first_name, sellers.last_name
FROM products
JOIN sellers
ON products.seller_id = sellers.id; 

-- List all sellers
SELECT first_name, last_name 
FROM sellers; 

-- List all sellers, and a count of how many products they have
SELECT sellers.first_name, sellers.last_name, COUNT(products.id) AS product_count
FROM sellers 
JOIN products 
ON sellers.id = products.seller_id
GROUP BY sellers.id, sellers.first_name, sellers.last_name
ORDER BY sellers.last_name; 

-- List all product titles for a specific seller
SELECT sellers.first_name, sellers.last_name, products.title 
FROM sellers 
JOIN products
ON sellers.id = products.seller_id 
WHERE sellers.first_name = 'Amelia';