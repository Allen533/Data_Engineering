Objectives

- Start Apache Airflow.
  Terminal->New Terminal # start new terminal
  start_airflow


- Open the Airflow UI in a browser.
  # lick on the URL by holding the control key to and at a page

- List all the DAGs.
  airflow dags list


- List the tasks in a DAG.
  airflow tasks list task_name

- Pause/Unpause a DAG
  airflow dags unpause dag_name
  airflow dags pause dag_name


- Explore a DAG in the UI.
  - trees
  - graphs
  - calendar # for tasks
  - task duration
  - landing time
  - gantt # Diagram Gantt for displaying schedule timline
  - details
  - code
