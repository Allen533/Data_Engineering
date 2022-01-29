Objectives

- Getting the environment ready
  start_cassandra
  cqlsh --username cassandra --password MTg3MzMtcnNhbm5h
  CREATE KEYSPACE training WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};

- Create a table in a keyspace by defining a column name and data type
      use training;
      CREATE TABLE movies(
      movie_id int PRIMARY KEY,
      movie_name text,
      year_of_release int
      );

- Extract the details of a table with the DESCRIBE command
  describe movies

- Alter a table by adding columns
  ALTER TABLE movies ADD genre text;

- Drop a table by removing it from the keyspace
  drop table movies;