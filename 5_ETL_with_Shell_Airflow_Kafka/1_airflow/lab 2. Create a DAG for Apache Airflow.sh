Objectives

- Explore the anatomy of a DAG.
  Imports
  DAG Arguments
  DAG Definition
  Task Definitions
  Task Pipeline

- Create a DAG.
  this is in a py file my_first_dag:
              # import the libraries

              from datetime import timedelta
              # The DAG object; we'll need this to instantiate a DAG
              from airflow import DAG
              # Operators; we need this to write tasks!
              from airflow.operators.bash_operator import BashOperator
              # This makes scheduling easy
              from airflow.utils.dates import days_ago

              #defining DAG arguments

              # You can override them on a per-task basis during operator initialization
              default_args = {
                  'owner': 'Ramesh Sannareddy',
                  'start_date': days_ago(0), # when this DAG should run from: days_age(0) means today,
                  'email': ['ramesh@somemail.com'], # for alerts
                  'email_on_failure': False, # whether alert must be sent on failure,
                  'email_on_retry': False, # whether alert must be sent on retry,
                  'retries': 1, # the number of retries in case of failure, and
                  'retry_delay': timedelta(minutes=5), # the time delay between retries
              }

              # defining the DAG


              # define the DAG
              dag = DAG(
                  dag_id = 'my-first-dag',
                  default_args=default_args,
                  description='My first DAG',
                  schedule_interval=timedelta(days=1), # how frequently this DAG runs
              )


              # define the tasks

              # define the first task
              extract = BashOperator(
                  task_id='extract',
                  bash_command='cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt', # What bash command it represents.
                  dag=dag, # Which dag this task belongs to
              )
              # define the second task
              transform_and_load = BashOperator(
                  task_id='transform',
                  bash_command='tr ":" "," < extracted-data.txt > transformed-data.csv',
                  dag=dag,
              )
              # task pipeline
              extract >> transform_and_load
  - save

  #Submit a DAG.
  #Submitting a DAG is as simple as copying the DAG python file into dags folder in the AIRFLOW_HOME directory.
  cp my_first_dag.py $AIRFLOW_HOME/dags
  airflow dags list # check if dag's there
  airflow dags list|grep "my-first-dag" # same, but |grep -- find a file and make its name to br an output
  #list out all the tasks in my-first-dag.
  airflow tasks list my-first-dag


overall snapshot
  # import the libraries

              from datetime import timedelta
              # The DAG object; we'll need this to instantiate a DAG
              from airflow import DAG
              # Operators; we need this to write tasks!
              from airflow.operators.bash_operator import BashOperator
              # This makes scheduling easy
              from airflow.utils.dates import days_ago

              #defining DAG arguments

              # You can override them on a per-task basis during operator initialization
              default_args = {
                  'owner': 'Ramesh Sannareddy',
                  'start_date': days_ago(0), #
                  'email': ['ramesh@somemail.com'],
                  'email_on_failure': False,
                  'email_on_retry': False,
                  'retries': 1,
                  'retry_delay': timedelta(minutes=5),
              }

              # defining the DAG

              # define the DAG
              dag = DAG(
                  'my-first-dag',
                  default_args=default_args,
                  description='My first DAG',
                  schedule_interval=timedelta(days=1),
              )

              # define the tasks

              # define the first task

              extract = BashOperator(
                  task_id='extract',
                  bash_command='cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt',
                  dag=dag,
              )


              # define the second task
              transform_and_load = BashOperator(
                  task_id='transform',
                  bash_command='tr ":" "," < extracted-data.txt > transformed-data.csv',
                  dag=dag,
              )


              # task pipeline
              extract >> transform_and_load


------------------------------ Task
# import the libraries

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments

# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Ramesh Sannareddy',
    'start_date': days_ago(0), # when this DAG should run from: days_age(0) means today,
    'email': ['ramesh@somemail.com'], # for alerts
    'email_on_failure': False, # whether alert must be sent on failure,
    'email_on_retry': False, # whether alert must be sent on retry,
    'retries': 1, # the number of retries in case of failure, and
    'retry_delay': timedelta(minutes=5), # the time delay between retries
}

# defining the DAG


# define the DAG
dag = DAG(
    dag_id = 'etl-log-processsing-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1), # how frequently this DAG runs
)


# define the tasks

# define the task 'download'
download = BashOperator(
    task_id='download',
    bash_command='wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Apache%20Airflow/Build%20a%20DAG%20using%20Airflow/web-server-access-log.txt"',
    dag=dag,
)

# define the task 'extract'
extract = BashOperator(
    task_id='extract',
    bash_command='cut -f1,4 -d"#" web-server-access-log.txt > extracted.txt', # fields 1 and 4. delimeter #
    dag=dag,
)

# define the task 'transform'
transform = BashOperator(
    task_id='transform',
    bash_command='tr "[a-z]" "[A-Z]" < extracted.txt > capitalized.txt',
    dag=dag,
)
# define the task 'load'
load = BashOperator(
    task_id='load',
    bash_command='zip log.zip capitalized.txt' ,
    dag=dag,
)

# task pipeline
download >> extract >> transform >> load


