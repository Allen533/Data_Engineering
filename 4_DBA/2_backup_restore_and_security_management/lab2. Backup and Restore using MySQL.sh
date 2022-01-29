
-------------------------
Objectives:

- Perform a Logical Backup and Restore
  - backup the countrylanguage table of the world database using the command below in the terminal
  mysqldump --host=127.0.0.1 --port=3306 --user=root --password world countrylanguage > world_countrylanguage_mysql_backup.sql
  - To restore the structure and data of the table countrylanguage, use the command below in the terminal
  mysql --host=127.0.0.1 --port=3306 --user=root --password world < world_countrylanguage_mysql_backup.sql

- Perform Point-in-Time Backup (thru logged information) and Restoration
  - Display the binary logs using the command below in the terminal
  mysql --host=127.0.0.1 --port=3306 --user=root --password --execute="SHOW BINARY LOGS;"
  - Write the contents of all binary log files listed above to a single file
  docker exec mysql_mysql_1 mysqlbinlog /var/lib/mysql/binlog.000003 /var/lib/mysql/binlog.000004 > logfile.sql
  - perform point-in-time restore
  mysql --host=127.0.0.1 --port=3306 --user=root --password < world_mysql_full_backup.sql


- Perform a Physical Backup and Restore
    docker cp mysql_mysql_1:/var/lib/mysql /home/project/mysql_backup   # (cp -- copy what where) (perform physical backup)
    docker cp /home/project/mysql_backup/. mysql_mysql_1:/var/lib/mysql  # (When needed, you can restore the physical backup)
----------------------
