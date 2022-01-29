---------------------------
 Final Assignment - Database Administration - Part 1. PG


Exercise 1.1 - Set up the lab environment
- start the PostgreSQL Server
  'start PostgreSQL' (or start_postgres)
- Download the lab setup bash file from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/postgres-setup.sh
  # in terminal
  wget http ....
- Run the bash file
  add to the .sh file #! bin/bash
  chmod if needed
  bash filename.sh


Exercise 1.2 - User Management

Task 1.2 - Create a User
# go to CLI
- \connect  tolldata
- CREATE USER backup_operator;

Task 1.3 - Create a Role
- CREATE ROLE backup;

Task 1.4 - Grant privileges to the role
- Grant the following privileges to the backup role.
    CONNECT ON tolldata DATABASE.
    SELECT ON ALL TABLES IN SCHEMA toll.
tolldata=# GRANT CONNECT ON DATABASE tolldata TO backup;
GRANT
tolldata=# GRANT SELECT ON ALL TABLES IN SCHEMA toll TO backup;
GRANT


Exercise 1.3 - Backup using PGADMIN GUI.
Task 1.6 - Backup a database on PostgreSQL server using PGADMIN GUI.




--------------------------------------------
Part 2. MySQL


Exercise 2.1 - Set up the lab environment:  start the MySQL Server.

Exercise 2.2 - Recovery
Task 2.1 - Restore MySQL server using a previous backup
  # in terminal
  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/billingdata.sql
  # in cli (same as in pg \connect filename.sql)
  SOURCE billingdata.sql;
  use ;

Task 2.2 - Find the table data size
SELECT
  table_name AS `Table`,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS `Size (MB)`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = "billing";


Exercise 2.3 - Indexing
Task 2.4 - Create an index
SELECT * FROM billdata WHERE billedamount > 19999;
CREATE INDEX billedamount_index ON billdata (billedamount);

Exercise 2.4 - Storage Engines
SHOW ENGINES;
SHOW TABLE STATUS WHERE Name = 'billdata';

SELECT TABLE_NAME,
       ENGINE
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'billing';

---------------------------------------------
part 3

Exercise 3.1 - Prepare the lab environment
perhaps I need to make it in pgAdmin
psql --username=postgres --host=localhost billing < billing.csv




CREATE INDEX billingamount
ON restored_billing(billedamount);

SELECT * FROM restored_billing WHERE billedamount = 19929;

-----------------------------------------------
OPTIONAL Exercise (Non-graded) - Connecting to IBM DB2 from command line
Bonus Task 3.6 - Connect to the clould instance of IBM DB2 using the db2cli command line tool
From the theia lab environment, you can use the db2cli to connect the IBM DB2. The generic syntax to connect is as follows.

db2cli execsql -connString "DATABASE= ;UID= ;PWD= ;HOSTNAME= ;port= ;Security=SSL"

Collect the databasename, username, password, hostname and port details using the service credentials of the IBM DB2 cloud console.

Run a sql query on the db2cli command line to find out the number of rows in the table billing.

Note the row count.

End of assignment - Part 3.