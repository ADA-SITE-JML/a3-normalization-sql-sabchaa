CREATE TABLE Publishers AS
SELECT DISTINCT
    publisher AS publisher_name,
    publisher_address
FROM Books;
ALTER TABLE Publishers ADD COLUMN publisher_id SERIAL PRIMARY KEY;

ALTER TABLE Books ADD COLUMN publisher_id INT;
UPDATE Books
SET publisher_id = p.publisher_id
FROM Publishers p
WHERE Books.publisher = p.publisher_name;

ALTER TABLE Books ADD CONSTRAINT fk_books_publishers FOREIGN KEY (publisher_id)
REFERENCES Publishers (publisher_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Books
DROP COLUMN publisher,
DROP COLUMN publisher_address;