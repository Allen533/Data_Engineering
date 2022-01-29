Objectives:
Setup a staging server for a data warehouse
Create the schema to store the data
Load the data into the tables
Run a sample query

++++++++++++++++
1. terminal->New Terminal,  start_postgres
2. Create Database
createdb -h localhost -U postgres -p 5432 billingDW
3. Create data warehouse schema
  - Download the schema files
    wget https://
    tar -xvzf billing-datawarehouse.tgz
    ls *.sql
  - Create the schema
    psql  -h localhost -U postgres -p 5432 billingDW < star-schema.sql
4. Load data into Dimension tables
  - Load data into DimCustomer table
    psql  -h localhost -U postgres -p 5432 billingDW < DimCustomer.sql
  - Load data into DimMonth table
    psql  -h localhost -U postgres -p 5432 billingDW < DimMonth.sql
5. Load data into Fact table
  psql  -h localhost -U postgres -p 5432 billingDW < FactBilling.sql
6. Run a sample query (located under verify.sql)
  psql  -h localhost -U postgres -p 5432 billingDW < verify.sql
7