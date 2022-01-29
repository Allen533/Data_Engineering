Objectives:

- Customize the configuration parameters of your PostgreSQL server instance
    - PostgreSQL server instance has a corresponding file named postgresql.conf
      that contains the configuration parameters for the server.
    - there `wal_level` parameter dictates how much information is written to the write-ahead log (WAL),
      which can be used for continuous archiving
    - SHOW wal_level;
    - ALTER SYSTEM SET wal_level = 'logical';

    - you can change it manually in the file postgresql.conf


- Query the system catalog to retrieve metadata about database objects
    - `pg_database` system catalog table, storing metadata about that database.
    SELECT * FROM pg_tables WHERE schemaname = 'bookings'; # schemaname referres to schemaname of a db
    - ENABLE ROW LEVEL SECURITY
      When row security is enabled on a table,
      all normal access to the table for selecting or modifying rows must be specified by a row security policy
    ALTER TABLE boarding_passes ENABLE ROW LEVEL SECURITY;

    - you cannot just modify the pg_tables! modify first a table, the pg_tables will be automatically uptaded