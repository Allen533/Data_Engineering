Objectives

- Monitor the performance of your database with the command line interface and pgAdmin.
    - FROM pg_stat_activity in termina SELECT: # pg_stat_activity -- the latest query that was run
        pid, usename, datname, state, state_change,
        tup_inserted, tup_updated, tup_deleted,
        tup_fetched, tup_returned,

    - after connecting to db, open the GUI, theres different dashboards and monit tools

- Identify optimal data types for your database.

- Optimize your database via the command line with best practices.
    - To select the table name, number of dead rows, the last time it was autovacuumed,
      and the number of times this table has been autovacuumed, you can use the following query
    SELECT relname, n_dead_tup, last_autoanalyze, autovacuum_count FROM pg_stat_user_tables;



p.s.

- you can create a extantion
CREATE EXTENSION pg_stat_statements; # pg_stat_statements -- aggregated view of the queries that were run since the extension was installed.
- edit the PostgreSQL configuration file to include the extension you just added
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';
- DROP EXTENSION pg_stat_statements; # if needed

- \dx # installed extensions

- show shared_preload_libraries;

- \x # turn on expanded table formatting if result output is to be vast

- What if you wanted to check which datbase name matches the database ID?
SELECT oid, datname FROM pg_database;