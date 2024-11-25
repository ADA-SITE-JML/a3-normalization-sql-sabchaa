### Overview
This project demonstrates the normalization process for a database containing information about books and their associated courses.

- The script `course_books.sql` transforms an unnormalized dataset into a fully normalized schema, progressing through 1NF, 2NF, and 3NF. The schema includes tables for Books, Authors, Publishers, Courses and their relationships.
- Script `Unnormalized.sql` contains the creation of the unnormalized table and the import of raw data from `Unnormalized.csv`.
- Scripts `1NF.sql`, `2NF.sql`, `3NF.sql` contain the step-by-step transformation of the database into First, Second, and Third Normal Forms, with appropriate table creation and normalization processes.
- Script `drop_tables.sql` contains command to drop all existing tables to reset the database for rerunning the scripts.


### Prerequisites

- PostgreSQL16.4

### Setup Instructions

#### Clone the Repository
```
git clone https://github.com/ADA-SITE-JML/a3-normalization-sql-sabchaa.git
cd a3-normalization-sql-sabchaa
```
### Connect
```
psql -h <host> -U <username>
```

### Create a new database
```
CREATE DATABASE db;
```

### Connect to the newly created database
```
\c db
```

#### Run the SQL files
```
\i /path/to/sql/file.sql
```
Example:
```
\i Unnormalized.sql
```
