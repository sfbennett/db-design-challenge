/* TASK 3 (Many to Many)
(Note that you may want to create a second database for this part)

The company has decided that a blog post could have more than one author.

Here are some updated requirements:

- Each blog post can have one or more authors
- Each author can write one or more blog posts

Here are some tasks:

- Design/update the table(s), and which fields they should have
- Specify the data types for each field
- Specify any constraints (e.g. primary keys, foreign keys, unique constraints)
- Write the SQL to create/update these table(s)
- Write the SQL to update the authors
- Each blog post should have at least one author */ 


--- Create New Database (created in Postbird) 
CREATE DATABASE guardian_2_task_3; 

-- Create Authors table:  
CREATE TABLE authors (
id SERIAL PRIMARY KEY, 
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE, 
password VARCHAR(255) NOT NULL, 
bio VARCHAR(255), 
date_joined DATE NOT NULL
); 

-- Create Blogs table:  
CREATE TABLE blogs ( 
  id SERIAL PRIMARY KEY, 
  title VARCHAR(255) NOT NULL,
  summary TEXT NOT NULL, 
  content TEXT NOT NULL, 
  date_written DATE NOT NULL
);

-- Create author_blogs table
CREATE TABLE author_blogs ( 
    author_id INT REFERENCES authors(id),
    blog_id INT REFERENCES blogs(id)
    PRIMARY KEY (author_id, blogs_id)
); 

-- Insert content into authors 
INSERT INTO authors (first_name, last_name, email, password, bio, date_joined) VALUES 
('Page', 'Turner', 'page.turner@pretend.com', 'ptpassword1', 'Page Turner is a voracious reader', '2024-01-10'),
('Mark', 'Chapters', 'mark.chapters@pretend.com', 'mcpassword2', 'Mark writes about fiction releases', '2023-10-20'),
('Bea', 'Literate', 'bea.literate@pretend.com', 'blpassword3', 'Bea writes about art, history and culture', '2023-05-18'),
('Justin', 'Time', 'justin.time@pretend.com', 'jtpassword4', 'Justin Time is always on the dot, writing about the latest technology trends', '2023-05-18'),
('Rita', 'Novel', 'rita.novel@pretend.com', 'rnpassword5', 'Rita Novel writes to help you write', '2023-02-10'),
('Cliff', 'Hanger', 'cliff.hanger@pretend.com', 'cfpassword6', 'Cliff Hanger keeps readers on the edge of their seats', '2023-01-15');

-- Insert content into blogs 
INSERT INTO blogs (title, summary, content, date_written) VALUES 

('2024 Reads', 'High-Speed Reads', '2024 reads...', '2024-01-15'), 
('Non-Fiction February', 'Best Monthly Non-Fiction', 'February non-fiction has...', '2023-11-01'), 
('LGBTQ+ Books', 'LGBTQ+ books recommendations', 'Here are some...', '2023-06-01'),
('2024 Tech Trends', 'Lates Innovations', 'Cutting-edge tech innovations...', '2023-09-10'),
('Novel Writing', 'How to Write a Novel', 'Grab a pen...', '2023-04-18'),
('2024 Travel', 'Top Destinations', 'Top destination picks...', '2023-05-12')

-- Insert content to connect each author with a blog 
INSERT INTO author_blogs (author_id, blog_id) VALUES 
( 1, 1),
( 1, 2),
( 2, 2),
( 3, 3),
( 4, 4),
( 5, 5),
( 6, 6);

--- Write the SQL queries to retrieve the following data:

-- List all blog post titles
SELECT title
FROM blogs; 

-- List all authors
SELECT first_name, last_name
FROM authors
ORDER BY last_name; 

-- List all authors, and a count of how many blogs they have created
SELECT authors.first_name, authors.last_name, COUNT(author_blogs.blog_id) AS blog_count 
FROM authors 
JOIN author_blogs 
ON authors.id = author_blogs.author_id
GROUP BY authors.id
ORDER BY authors.last_name; 

-- List all blog posts for a specific author
SELECT blogs.title 
FROM blogs
JOIN author_blogs 
ON blogs.id = author_blogs.blog_id
JOIN authors 
ON authors.id = author_blogs.author_id
WHERE authors.first_name = 'Page';

-- List all authors for a specific blog post
SELECT authors.first_name, authors.last_name
FROM authors
JOIN author_blogs
ON authors.id = author_blogs.author_id
JOIN blogs 
ON blogs.id = author_blogs.blog_id
WHERE blogs.title = 'LGBTQ+ Books';