/* TASK 1 (One to Many)
We have been asked to design a database for a new website - a blog for a well known company. Let's call them The Guardian 2.

We need to design the table(s) for this blog.

Here are some requirements:

- The database needs to store information on blog posts
- Each blog post can have a single author
- Each author can write multiple blog posts
- Each blog post should have a title, summary, the full blog post, and the date it was written
- We should also store each author's name, email address, password, a short bio, and the date that they joined

Here are some tasks:

- Design the table(s), and which fields they should have
- Specify the data types for each field
- Specify any constraints (e.g. primary keys, foreign keys, unique constraints)
- Write the SQL to create these table(s)
- Write the SQL to insert some fake blog data
- There should be at least five authors
- Each author should have written between 1-5 blog posts */ 

--- New Database 
CREATE DATABASE guardian_2; 

--- Create Authors table: 
CREATE TABLE authors ( 
id SERIAL PRIMARY KEY, 
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE, 
password VARCHAR(255) NOT NULL, 
bio VARCHAR(255), 
date_joined DATE NOT NULL
)

--- Create Blog Posts table: 
CREATE TABLE blog_posts ( 
  id SERIAL PRIMARY KEY, 
  author_id INT NOT NULL, 
  title VARCHAR(255) NOT NULL,
  summary TEXT NOT NULL, 
  content TEXT NOT NULL, 
  date_written DATE NOT NULL
  FOREIGN KEY (author_id) REFERENCES authors(id)
  ); 

--- Insert five authors: 
INSERT INTO authors (first_name, last_name, email, password, bio, date_joined) VALUES 
('Page', 'Turner', 'page.turner@pretend.com', 'ptpassword1', 'Page Turner is simply a voracious reader', '2024-01-10'),
('Mark', 'Chapters', 'mark.chapters@pretend.com', 'mcpassword2', 'Mark Chapters writes about the latest fiction releases', '2023-10-20'),
('Bea', 'Literate', 'bea.literate@pretend.com', 'blpassword3', 'Bea Literate writes about art, history and culture', '2023-05-18'),
('Justin', 'Time', 'justin.time@pretend.com', 'jtpassword4', 'Justin Time is always on the dot, writing about the latest technology trends', '2023-05-18'),
('Rita', 'Novel', 'rita.novel@pretend.com', 'rnpassword5', 'Rita Novel writes to help you write', '2023-02-10'),
('Cliff', 'Hanger', 'cliff.hanger@pretend.com', 'cfpassword6', 'Cliff Hanger keeps readers on the edge of their seats', '2023-01-15');

--- Insert blog posts for each author:  
INSERT INTO blog_posts (author_id, title, summary, content, date_written) VALUES 

-- Page Turner (author id: 1)
(1, 'Books I Sped Through in 2023', 'Top Picks for Captivating Reads', '2023 was filled with literary gems, these books stood out...', '2024-01-15'),
(1, 'Speed Reading', 'A Book a Day', 'Five books I read in one day...', '2024-02-15'),  

-- Mark Chapters (author id: 2)
(2, 'Fiction February', 'Best New Fiction in February', 'February releases have pushed the boundaries of genre...', '2023-11-01'), 
(2, 'Pride Month', 'Best LGBTQ+ reads for Pride Month', 'There is a huge wealth of great LGBTQ+ books to choose from...', '2023-06-01'),

-- Bea Literate (author id: 3)
(3, 'Renaissance Revival', 'Modern Interpretations of Classical Art', 'Artists breathing new life into classical art....', '2023-06-15'),

-- Justin Time (author id: 4)
(4, '2024 Tech Trends', 'Latest Tech Innovations', 'Cutting-edge tech innovations are reshaping our world...', '2023-09-10'),

-- Rita Novel (author id: 5)
(5, 'Novel Writing', 'How to Write a Debut Novel', 'Grab a pen...', '2023-04-18'),
(5, 'The Second Novel', 'How to Write a Sequel', 'Grab another pen...', '2023-08-18'), 

-- Cliff Hanger (author id: 6)
(6, 'Infuriating Endings', 'Books with Ridiculous Endings', 'I read the final line of this book and wanted to throw it into the sea...', '2023-02-15'), 
(6, 'Endings 2.0', 'Book Endings I Rewrote', 'Frustrating endings are infuriating, so I rewrote some...', '2023-04-15'); 


--- Write the SQL queries to retrieve the following data --- 

-- List all blog post titles: 
SELECT title
FROM blog_posts; 

-- List all blog post titles, with the author's name: 
SELECT authors.first_name, authors.last_name, blog_posts.title
FROM authors
JOIN blog_posts 
ON authors.id = blog_posts.author_id; 

-- List all authors: 
SELECT first_name, last_name
FROM authors; 

-- List all authors, alphabetically: 
SELECT first_name, last_name 
FROM authors
ORDER BY last_name; 

-- List all authors, and a count of how many blogs they have created: 
SELECT authors.first_name, authors.last_name, COUNT(blog_posts.id) AS post_count
FROM authors
JOIN blog_posts
ON authors.id = blog_posts.author_id 
GROUP BY authors.id, authors.first_name, authors.last_name
ORDER BY authors.last_name; 

-- List all blog posts for a specific author: 
SELECT authors.first_name, authors.last_name, blog_posts.title
FROM authors 
JOIN blog_posts 
ON authors.id = blog_posts.author_id
WHERE authors.first_name = 'Cliff'; 

-- List all blog posts, sorted by the oldest first: 
SELECT authors.first_name, authors.last_name, blog_posts.title, blog_posts.date_written
FROM authors
JOIN blog_posts
ON authors.id = blog_posts.author_id
ORDER BY blog_posts.date_written ASC; 

