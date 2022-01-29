Objectives

- Enable error logging for your PostgreSQL instance.
    - go  postgres > data > postgresql.conf, there is `logging_collector = off`
    - stop pg, start
    - check
    SHOW logging_collector;

- Access server logs for troubleshooting.
    - To find where the system logs are stored, enter the following command into the CLI:
    SHOW log_directory;
    - open file with a name of the form
    postgresql-YYYY-MM-DD-<numbers>.log
    - Inspect and familiarize yourself with the logs
    - stop pg, start
    - check


- Diagnose commonly encountered issues caused by poor performance, improper configuration, or poor connectivity.
    - just look at what is in logs error messages.

- Resolve common issues you may encounter as a database administrator.
    - accordingly to the error message.
    - e.g. `FATAL: sorry, too many clients already` -> (postgres > data and open the postgresql.conf) -> change max_connections
    - there,you can also change:  shared_buffers, work_mem, maintenance_work_mem,  etc
    - stop pg, start
    - check




p.s
- \timing # enable the timer. how long each query takes (in milliseconds)

