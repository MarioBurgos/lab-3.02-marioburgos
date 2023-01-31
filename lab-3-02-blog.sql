-- --ROOT MUST EXECUTE--
-- CREATE SCHEMA blog;
-- GRANT ALL PRIVILEGES ON blog. * TO 'ironhacker'@'localhost';
-- -- END OF ROOT--

DROP SCHEMA IF EXISTS blog;
CREATE SCHEMA blog;
USE blog;
-- 
CREATE TABLE IF NOT EXISTS author(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS blog_entry(
	id INT NOT NULL AUTO_INCREMENT,
    author_id INT,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(author_id) REFERENCES author(id)
);

CREATE TABLE IF NOT EXISTS blog_entry_data(
	id INT NOT NULL AUTO_INCREMENT,
	blog_entry_id INT,
    word_count INT,
    views INT,
    PRIMARY KEY(id),
    FOREIGN KEY(blog_entry_id) REFERENCES blog_entry(id)
);

INSERT INTO author (name) VALUES
('Maria Charlotte'),
('Juan Perez'),
('Gemma Alcocer')
;

INSERT INTO blog_entry (author_id, title) VALUES
 (1,'Best Paint Colors'),
 (2,'Small Space Decorating Tips'),
 (1,'Hot Accessories'),
 (1,'Mixing Textures'),
 (2,'Kitchen Refresh'),
 (1,'Homemade Art Hacks'),
 (3,'Refinishing Wood Floors')
;

INSERT INTO blog_entry_data (blog_entry_id, word_count, views) VALUES
(1, 814, 98),
(2, 1146, 82),
(3, 986, 65),
(4, 765, 89),
(5, 1242, 99),
(6,1002, 87),
(7, 1571, 46)
;
