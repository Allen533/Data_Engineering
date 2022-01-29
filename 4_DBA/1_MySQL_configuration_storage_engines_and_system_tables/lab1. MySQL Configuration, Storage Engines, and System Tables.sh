Objectives:

- Create tables using alternative storage engines.
  SHOW ENGINES;
  e.g. CREATE TABLE csv_test (i INT NOT NULL, c CHAR(10) NOT NULL) ENGINE = CSV;

- Query MySQL system tables to retrieve meta data about objects in the database.
  USE mysql; # default db for metadata
  USE information_schema; # contains meta data about the MySQL server such as the name of a database or table, the data type of a column, or access privileges



p.s.
- Find the storage engine of the table:
SELECT TABLE_NAME,
       ENGINE
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'billing';

