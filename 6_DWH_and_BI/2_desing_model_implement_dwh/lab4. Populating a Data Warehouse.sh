Objectives

(db2cli shortcuts):
db2cli writecfg add -database -host  -port  -parameter
db2cli writecfg add -dsn dsn_name
db2cli validate -connect -user -passwd
db2cli execsql -dsn -user -passwd -inputsql file.sql

- Create an instance of IBM DB2 on cloud # on IBM Cloud

- Create credentials for external accessibility # same
  Make a note of the following details:
    user
    password
    host
    port
    database_name

Create a db2cli dsn # -- data source name
  - access to IDM Cloud:
    - web broser interface
    - in terminal, using 'db2cli'
  - Creating a dsn is two step process
    1. We add the database, host, port and the security mode details
    db2cli writecfg add -database dbname -host hostname -port 50001 -parameter "SecurityTransportMode=SSL"
    2. Give a name to the data source we just created # This dsn name helps us to easily point to the IBM DB2
    db2cli writecfg add -dsn dsn_name -database dbname -host hostname -port 5000

    # real code
    db2cli writecfg add -database bludb
    -host 55fbc997-9266-4331-afd3-888b05e734c0.bs2io90l08kqb1od8lcg.databases.appdomain.cloud
    -port 31929 -parameter "SecurityTransportMode=SSL"
    db2cli writecfg add -dsn production -database bludb
    -host 55fbc997-9266-4331-afd3-888b05e734c0.bs2io90l08kqb1od8lcg.databases.appdomain.cloud
    -port 31929

    #in one line
    db2cli writecfg add -database bludb -host 55fbc997-9266-4331-afd3-888b05e734c0.bs2io90l08kqb1od8lcg.databases.appdomain.cloud -port 31929 -parameter "SecurityTransportMode=SSL"
    db2cli writecfg add -dsn production -database bludb -host 55fbc997-9266-4331-afd3-888b05e734c0.bs2io90l08kqb1od8lcg.databases.appdomain.cloud -port 31929



- Verify a db2cli dsn
db2cli validate -dsn production -connect -user vvc13302 -passwd igXhtlSXVFlbmCTg


- Create the schema on production data warehouse
# download
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Populating%20a%20Data%20Warehouse/star-schema.sql
# create the schema on the production data warehouse
db2cli execsql -dsn production -user vvc13302 -passwd igXhtlSXVFlbmCTg -inputsql star-schema.sql


- Populate the production data warehouse
#download sql files for ingection data to the tables
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Populating%20a%20Data%20Warehouse/DimCustomer.sql
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Populating%20a%20Data%20Warehouse/DimMonth.sql
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Populating%20a%20Data%20Warehouse/FactBilling.sql
ls *.sql
# load the data on to the production data warehouse.
db2cli execsql -dsn production -user vvc13302 -passwd igXhtlSXVFlbmCTg -inputsql DimCustomer.sql
db2cli execsql -dsn production -user vvc13302 -passwd igXhtlSXVFlbmCTg -inputsql DimMonth.sql
db2cli execsql -dsn production -user vvc13302 -passwd igXhtlSXVFlbmCTg -inputsql FactBilling.sql


- Verify the data on the production data warehouse
#download file with queries
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Populating%20a%20Data%20Warehouse/verify.sql
#apply the query filo
db2cli execsql -dsn production -user jrg38634 -passwd SuWySBe5Y4MsYnh9 -inputsql verify.sql

- Work with db2cli interactive command line
# open an interactive sql command shell to your production data warehouse
db2cli execsql -dsn production -user vvc13302 -passwd igXhtlSXVFlbmCTg # opens CLI
# run the command below on the db2cli
select count(*) from DimMonth;
quit
