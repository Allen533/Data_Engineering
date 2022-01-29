Objectives

- Getting the environment ready
  start_cassandra
  cqlsh --username cassandra --password MTg3MzMtcnNhbm5h
  CREATE KEYSPACE training WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};
  use training; CREATE TABLE movies( movie_id int PRIMARY KEY, movie_name text, year_of_release int );


- Insert data into a table with an INSERT command
  INSERT into movies(
    movie_id, movie_name, year_of_release)
    VALUES (1,'Toy Story',1995);

- Read data from a table by querying from it
  select movie_name from movies where movie_id = 1;

- Update and delete data from the table based on specific criteria
  UPDATE movies
    SET year_of_release = 1996
    WHERE movie_id = 4;

  DELETE from movies
    WHERE movie_id = 5;