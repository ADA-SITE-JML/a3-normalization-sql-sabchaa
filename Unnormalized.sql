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