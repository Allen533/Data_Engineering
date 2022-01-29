++++++++++
Objectives:
Study the schema of the given csv file
Design the fact tables
Design the dimension tables
Create a star schema using the fact and dimension tables


+++++++++++++
 1 - Study the schema of the given csv file
 2 - Design the fact tables  -- table FactBilling
 3 - Design the dimension tables  -- table DimCustomer, DimMounth
 4 - Create a star schema using the fact and dimension tables  -- using foreign keys
 5 - Create the schema on the data warehouse:
    # new terminal
    start_postgres
    # Create the database on the data warehouse
    createdb -h localhost -U postgres -p 5432 billingDW
    # Download the schema star-schema.sql file
    wget https://cf-courses ....
    # Create the schema:
    psql  -h localhost -U postgres -p 5432 billingDW < star-schema.sql




+++++++++++++++++++++++++