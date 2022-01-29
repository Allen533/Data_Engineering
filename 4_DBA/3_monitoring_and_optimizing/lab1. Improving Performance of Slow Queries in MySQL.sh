Objectives:
- learn how to improve the performance of your slow queries in MySQL, which can be particularly helpful with large databases.

- Use the EXPLAIN statement to check the performance of your query
  EXPLAIN SELECT * FROM employees; # the number of rows query is planning on looking through.

- improvivng: Add indexes to improve the performance of your query
  SHOW INDEX FROM employees; # let's take at the existing indexes
  CREATE INDEX hire_date_index ON employees(hire_date); # add index on column hire_date
  DROP INDEX hire_date_index ON employees; # if needed

- improvivng: Apply other best practices such as using the UNION ALL clause to improve query performance
  - if we need to have OR in WHERE clause, dont use
  WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
    but
  SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';

  - Be SELECTive! dont use *, use column names which is needed.