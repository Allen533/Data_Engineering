Objectives

- Make no password entry to mysql.
    - after `start_mysql`, open `.my.cnf` as root user, with nano editor to configure your mysql password
    sudo nano ~/.my.cnf
    - add password
    - Ctrl+O followed by the Enter, Ctrl+X to quit the nano editor
    - after command `mysql`,  there is no need of entering your password again

- Restore the Structure and Data of a Table
    create database sakila;
    use sakila;
    source sakila_mysql_dump.sql;
    SHOW FULL TABLES WHERE table_type = 'BASE TABLE'; # check, list all the table names from the sakila database


- Create the shell script to back up the database.
    - new file, say `sqlbackup.sh`
    - Enter the following code in the new file:
            #!/bin/sh
            # The above line tells the interpreter this code needs to be run as a shell script.

            # Set the database name to a variable.
            DATABASE='sakila'

            # This will be printed on to the screen. In the case of cron job, it will be printed to the logs.
            echo "Pulling Database: This may take a few minutes"

            # Set the folder where the database backup will be stored
            backupfolder=/home/theia/backups

            # Number of days to store the backup
            keep_day=30

            # Set the name of the SQL file where you will dump the database as "all-database-"
            # suffixed with the current timestamp and .sql extension.
            sqlfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).sql
            # and the zip file in which you will compress the SQL file as "all-database-"
            # suffixed with the current timestamp and .gz extension
            zipfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).gz

            # all placeholders are created.
            # Create a backup

            if mysqldump  $DATABASE > $sqlfile ; then
               echo 'Sql dump created'
                # Compress backup
                if gzip -c $sqlfile > $zipfile; then
                    echo 'The backup was successfully compressed'
                else
                    echo 'Error compressing backupBackup was not created!'
                    exit
                fi
                rm $sqlfile
            else
               echo 'pg_dump return non-zero code No backup was created!'
               exit
            fi

            # Delete old backups
            find $backupfolder -mtime +$keep_day -delete
    - save file
    - sudo chmod u+x+r sqlbackup.sh
    - You decided to create the backups in a folder, but that folder doesnt exist in the environment.
    mkdir /home/theia/backups


- Create a cron job to run the backup script thereby creating a backup file.
    - start the crontab: `crontab -e`
    - e.g. */2 * * * * /home/project/sqlbackup.sh > /home/project/backup.log
    - Ctrl+O followed by the Enter, Ctrl+X to quit the nano editor
    - cron service needs to be explicitly started.
    sudo service cron star
    - check
    ls -l /home/theia/backups
    - sudo service cron stop # if needed

- Truncate the tables in the database.
- Restore the database using the backup file.
    ls -l /home/theia/backups #  find the list of backup files that have been created
    # Select the file that you want to restore the data from and copy the file name
    gunzip /home/theia/backups/<backup zip file name> # unzip the file and extract the SQL file from the backup file
    mysql sakila < /home/theia/backups/<backup sql file name> # Populate and restore the database with the sqlfile that results from the unzip operation
    # than check
    mysql
    use sakila;
    select * from staff;


P.S. sudo rm -rfv /home/theia/backups #  clean up the backups foldeR