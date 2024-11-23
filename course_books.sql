DROP TABLE IF EXISTS Unnormalized, Books, Authors, Book_authors, Courses, Coursebooks, Publishers;

CREATE TABLE Unnormalized(
	CRN INT,
	ISBN INT,
	title VARCHAR(100),
	authors VARCHAR(100),
	book_edition INT,
	publisher VARCHAR(50),
	publisher_address VARCHAR(100),
	pages INT,
	publication_year INT,
	course_name VARCHAR(50),
	PRIMARY KEY(CRN, ISBN)
);

\COPY Unnormalized FROM 'Unnormalized.csv' DELIMITER ';' CSV HEADER;

-- 1NF ------------------------------------------------------------------------
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
    TRIM(unnest(string_to_array(REPLACE(authors, E'\u00A0', ' '), ','))) AS Name
FROM Unnormalized;
ALTER TABLE Authors ADD COLUMN author_id SERIAL PRIMARY KEY;

CREATE TABLE Book_authors AS
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

ALTER TABLE Book_authors
ADD CONSTRAINT fk_ba_books FOREIGN KEY (ISBN) REFERENCES Books (ISBN)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_ba_authors FOREIGN KEY (author_id) REFERENCES Authors (author_id)
ON DELETE CASCADE ON UPDATE CASCADE;
