Objectives


(preper the lab environment)
  start_airflow
  mkdir /home/project/airflow/dags/finalassignment/staging # Create a directory for staging area, but no finalassignment folder, so
  mkdir /home/project/airflow/dags/finalassignment # and then this:
  mkdir /home/project/airflow/dags/finalassignment/staging
  cd /home/project/airflow/dags/finalassignment/staging # go there to download zipped file
  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz

   (overall)
   start_airflow
   mkdir /home/project/airflow/dags/finalassignment
  mkdir /home/project/airflow/dags/finalassignment/staging
  cd /home/project/airflow/dags/finalassignment/staging
  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz

----------------------------------------
- Extract data from a csv file
- Extract data from a tsv file
- Extract data from a fixed width file
- Transform the data
- Load the transformed data into the staging area

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments
default_args = {
    'owner': 'dummy bname',
    'start_date': days_ago(0), #
    'email': ['dummyemail@somemail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG
dag = DAG(
    'ETL_toll_data',
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1),
)

 # define the tasks

unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar zxvf tolldata.tgz',
    dag=dag,
)

extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command='cut -d"," -f1,2,6 vehicle-data.csv > csv_data.csv',
    dag=dag,
)

extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command='cut -f5,6,7 tollplaza-data.tsv > tsv_data.csv',
    dag=dag,
)

# not done yet --Task 1.6 - Create a task to extract data from **fixed width file
# extract all the field somehow
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command='cut -f6,7 payment-data.txt > fixed_width_data.csv',
    dag=dag,
)


consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command='past payment-data.txt tsv_data.csv tsv_data.csv > extracted_data.csv',
    dag=dag,


transform_and_load = BashOperator(
    task_id='transform',
    bash_command='tr "a-z" "A-Z" < extracted-data.txt > transformed-data.csv',
    dag=dag,
)


# task pipeline
unzip_data >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width >> consolidate_data >> transform_data

--------------------------------- Exercise 3 - Getting the DAG operational.

Task 1.10 - Submit the DAG
cp ETL_toll_data.py $AIRFLOW_HOME/dags
airflow dags list # check if dag's there
airflow dags list|grep "my-first-dag" # same, but |grep -- find a file and make its name to br an output
#list out all the tasks in my-first-dag.
airflow tasks list my-first-dag


=====================================

from datetime import timedelta
# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG
# Operators; we need this to write tasks!
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments
default_args = {
    'owner': 'dummy bname',
    'start_date': days_ago(0), #
    'email': ['dummyemail@somemail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# defining the DAG
dag = DAG(
    'ETL_toll_data',
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval=timedelta(days=1),
)

 # define the tasks

unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command='tar zxvf tolldata.tgz',
    dag=dag,
)

extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command='cut -d"," -f1,2,6 vehicle-data.csv > csv_data.csv',
    dag=dag,
)

extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command='cut -f5,6,7 tollplaza-data.tsv > tsv_data.csv',
    dag=dag,
)

# not done yet --Task 1.6 - Create a task to extract data from **fixed width file
# extract all the field somehow
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command='cut -f6,7 payment-data.txt > fixed_width_data.csv',
    dag=dag,
)


consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command='past payment-data.txt tsv_data.csv tsv_data.csv > extracted_data.csv',
    dag=dag,


transform_and_load = BashOperator(
    task_id='transform',
    bash_command='tr "a-z" "A-Z" < extracted-data.txt > transformed-data.csv',
    dag=dag,
)


# task pipeline
unzip_data >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width >> consolidate_data >> transform_data

