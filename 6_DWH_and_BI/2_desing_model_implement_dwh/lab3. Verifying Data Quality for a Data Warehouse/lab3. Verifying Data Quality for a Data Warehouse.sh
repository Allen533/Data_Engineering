Objectives
Check Duplicate values
Check Min Max
Check Invalid values
Generate a report on data quality
-----------------------
(preper env setup)

start_postgres
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/setup_staging_area.sh
bash setup_staging_area.sh

# here we are doing data cleaning with uae of pre-writen py files.
# download:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/dataqualitychecks.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/dbconnect.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/mytests.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/generate-data-quality-report.py
ls # to check if they are there

#  Install the python driver for Postgresql
pip install psycopg2

# Test database connectivity
python3 dbconnect.py

# Create a sample data quality report
python3 generate-data-quality-report.py

# Explore the data quality tests
The testing framework provides the following tests:
- checkfornulls - this test will check for nulls in a column
- checkformin_max - this test will check if the values in a column are with a range of min and max values
- checkforvalid_values - this test will check for any invalid values in a column
- checkforduplicates - this test will check for duplicates in a column


Check Null values
 # just run
 python3 generate-data-quality-report.py
 # and it will be done


