CREATE TABLE Books AS 
SELECT DISTINCT
    ISBN,
    title,
    pages,
    publication_year,
    book_edition,
    publisher,
	publisher_address
FROM Unnormalized;
ALTER TABLE Books ADD PRIMARY KEY (ISBN);

CREATE TABLE Authors AS
SELECT DISTINCT
    TRIM(unnest(string_to_array(REPLACE(authors, E'\u00A0', ' '), ',')))
    AS Name
FROM Unnormalized;
ALTER TABLE Authors ADD COLUMN author_id SERIAL PRIMARY KEY;

CREATE TABLE Book_authors (
    ISBN INT,
    author_id INT,
    PRIMARY KEY (ISBN, author_id),
    FOREIGN KEY (ISBN) REFERENCES Books (ISBN)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors (author_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Book_authors
SELECT DISTINCT
    b.ISBN,
    a.author_id
FROM Books b
JOIN Authors a
ON a.name IN (
    SELECT TRIM(unnest(string_to_array(REPLACE(u.authors, E'\u00A0', ' '), ',')))
    FROM Unnormalized u
    WHERE u.ISBN = b.ISBN
);
