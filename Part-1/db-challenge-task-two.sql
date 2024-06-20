/* TASK 2 (Many to Many)
The company has decided that they would like to add tags to blog posts.

Here are some requirements:

Each blog post can have one or more tags
Each tag can be applied to one or more blog posts

Here are some tasks:

- Design the table(s), and which fields they should have
- Specify the data types for each field
- Specify any constraints (e.g. primary keys, foreign keys, unique constraints)
- Write the SQL to create these table(s)
- Write the SQL to insert some tags
- There should be at least five tags
- Each blog post should have between 1-5 tags */


-- Create Tags table: 
CREATE TABLE tags ( 
    id SERIAL PRIMARY KEY, 
    tag_name VARCHAR(255) NOT NULL UNIQUE
); 

-- Create a join table for linking together the blog_posts and tags tables:  
CREATE TABLE blogpost_tags ( 
    blogposts_id INT NOT NULL, 
    tags_id INT NOT NULL, 
    PRIMARY KEY (blogposts_id, tags_id),
    FOREIGN KEY (blogposts_id) REFERENCES blog_posts(id), 
    FOREIGN KEY (tags_id) REFERENCES tags(id)
); 

-- SQL to insert 5 tags: 
INSERT INTO tags (tag_name) VALUES 
('Books'),
('Fiction'),
('Tech'),
('LGBTQ+'),
('Art'),
('History'),
('Culture'),
('Writing'); 

-- Each blog post should have 1-5 tags: 
INSERT INTO blogpost_tags (blogposts_id, tags_id) VALUES 
(1, 1),
(1, 2),
(2, 2),
(2, 4),
(3, 5),
(3, 6),
(3, 7),
(4, 3), 
(5, 8), 
(5, 1),
(6, 1), 
(6, 2), 
(6, 8); 

--- Write the SQL queries to retrieve the following data --- 

-- A list of all tags
SELECT tag_name
FROM tags; 

-- A list of all tags and how many times they have been used
SELECT tags.tag_name, COUNT(blogpost_tags.blogposts_id) AS tag_count
FROM tags
JOIN blogpost_tags
ON tags.id = blogpost_tags.tags_id
GROUP BY tags.id, tags.tag_name; 

-- A list of all tags for a particular blog post
SELECT blog_posts.title AS blog_title, tags.tag_name
FROM blog_posts
JOIN blogpost_tags 
ON blogposts.id = blogpost_tags.blogposts_id
JOIN tags
ON blogpost_tags.tags_id = tags.id 
WHERE blog_posts.id = 2;

-- A list of all blog posts for a particular tag 
SELECT blog_posts.title 
FROM blog_posts 
JOIN blogpost_tags 
ON blog_posts.id = blogpost_tags.blogposts_id
WHERE blogpost_tags.tags_id = 4;


