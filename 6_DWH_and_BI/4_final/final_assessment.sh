Scenario
You are a data engineer hired by a solid waste management company.
The company collects and recycles solid waste across major cities in the country of Brazil.
The company operates hundreds of trucks of different types to collect and transport solid waste.
The company would like to create a data warehouse so that it can create reports like
  total waste collected per year per city
  total waste collected per month per city
  total waste collected per quarter per city
  total waste collected per year per trucktype
  total waste collected per trucktype per city
  total waste collected per trucktype per station per city


Objectives
  Design a Data Warehouse
  Load data into Data Warehouse
  Write aggregation queries
  Create MQTs
  Create a Dashboard

---------------------------- Exercise 1 - Design a Data Warehouse
Task 1 - Design the dimension table MyDimDate
#
columns:
  date_id
  date,
  Year,
  Quarter,
  QuarterName,
  Month,
  Monthname,
  Day,
  Weekday,
  WeekdayName

#
Fields:
  1,2019-03-09,2019,1,Q1,3,March,9,7,Sunday
  2,2019-03-10,2019,1,Q1,3,March,10,1,Monday
  3,2019-03-11,2019,1,Q1,3,March,11,2,Tuesday
  4,2019-03-12,2019,1,Q1,3,March,12,3,Wednesday



Task 2 - Design the dimension table MyDimWaste
#
columns:
  waste_type_id
  waste_type_name
#
fields:
  1, wet
  2, dry
  3, plastic
  4, electronic


Task 3 - Design the dimension table MyDimZone
#
columns:
  collection_zone_id
  collection_zone_name
#
fields:
  1, North,
  2, South,
  3, Central,
  4, West,
  5, East


Task 4 - Design the fact table MyFactTrips
#
columns:
  trip_id
  waste_collected_in_tons
  waste_type_id
  collection_zone_id
  collection_city
  date_id

#
fields:
  1, 45.23, 1, 2, Sao Paulo, 1001,
  2, 43.12, 2, 3, Rio de Janeiro, 1002,
  3, 40.19, 3, 2, Sao Paulo, 1001,
  4, 34.87, 4, 4, Rio de Janeiro, 1002,
  5, 45.34, 2, 4, Rio de Janeiro, 1001

---------------- Exercise 2 - Create schema for Data Warehouse on DB2

#
start_postgres
psql --username=postgres --host=localhost
create database assessment;


Task 5 - Create the dimension table MyDimDate
#
create table MyDimDate(
  date_id int PRIMARY KEY,
  day int,
  month int,
  monthname varchar,
  year int,
  weekday int
);

Task 6 - Create the dimension table MyDimWaste
#
CREATE TABLE MyDimWaste(
  waste_type_id INT PRIMARY KEY,
  waste_type_name VARCHAR
);

Task 7 - Create the dimension table MyDimZone
#
CREATE TABLE MyDimZone(
  collection_zone_id INT PRIMARY KEY,
  collection_zone_name VARCHAR
);

Task 8 - Create the fact table MyFactTrips
#
CREATE TABLE MyFactTrips(
  trip_id INT PRIMARY KEY,
  waste_collected_in_tons FLOAT,
  waste_type_id INT,
  collection_zone_id INT,
  collection_city VARCHAR,
  date_id int,
  FOREIGN KEY(waste_type_id) REFERENCES MyDimWaste(waste_type_id),
  FOREIGN KEY(collection_zone_id) REFERENCES MyDimZone(collection_zone_id),
  FOREIGN KEY(date_id) REFERENCES MyDimDate(date_id)
);

--------------------- Exercise 3 - Load data into the Data Warehouse

Task 9 - Load data into the dimension table DimDate
# in terminal
wget  https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Final%20Assignment/DimDate.csv
# check first 5
head -5 DimDate.csv

# schema
1,2019-03-09,2019,1,Q1,3,March,9,7,Sunday

# sql
CREATE TABLE DimDate(
  dateid INT PRIMARY KEY,
  date DATE,
  Year INT,
  Quarter INT,
  QuarterName VARCHAR,
  Month INT,
  Monthname VARCHAR,
  Day INT,
  Weekday INT ,
  WeekdayName VARCHAR
);

# populate XXXXXXXXXX


Task 10 - Load data into the dimension table DimTruck
#
wget ..

# schema
Truckid,TruckType
115,Volvo

# sql
CREATE TABLE DimTruck(
  Truckid INT PRIMARY KEY,
  TruckType VARCHAR
);

# populate XXXXXXXXXX


Task 11 - Load data into the dimension table DimStation
#
wget ..

# schema
Stationid,City
19,Sao Paulo

# sql
CREATE TABLE DimStation(
  Stationid INT PRIMARY KEY,
  City VARCHAR
);


# populate XXXXXXXXXX



Task 12 - Load data into the fact table FactTrips
#
wget ..

# schema
Tripid,Dateid,Stationid,Truckid,Wastecollected
23475,1,71,133,33.36

# sql
CREATE TABLE FactTrips(
  Tripid INT PRIMARY KEY,
  Dateid INT,
  Stationid INT,
  Truckid INT,
  Wastecollected FLOAT,
  FOREIGN KEY(Truckid) REFERENCES DimTruck(Truckid),
  FOREIGN KEY(Stationid) REFERENCES DimStation(Stationid),
  FOREIGN KEY(dateid) REFERENCES DimDate(dateid)
);

# populate XXXXXXXXXX


------------------------------------- Exercise 4 - Write aggregation queries and create MQTs

Task 13 - Create a grouping sets query
Create a grouping sets query using the columns stationid, trucktype, total waste collected.

SELECT FT.stationid,
    DT.trucktype,
    SUM(FT.WASTECOLLECTED) AS TOTAL_WASTE_COLLECTED
FROM FACTTRIPS AS FT
LEFT JOIN DIMTRUCK AS DT
	ON FT.truckid = dt.truckid
GROUP BY GROUPING SETS (FT.stationid, DT.trucktype);

SELECT * FROM FACTTRIPS LIMIT 5;
SELECT * FROM DIMTRUCK LIMIT 5;



Task 14 - Create a rollup query
Create a rollup query using the columns year, city, stationid, and total waste collected.

SELECT DD.YEAR,
	DS.CITY,
	FT.stationid,
    AVG(FT.WASTECOLLECTED) AS AVARAGE_WASTE_COLLECTED
FROM DIMSTATION AS DS
LEFT JOIN FACTTRIPS AS FT
	ON DS.STATIONID = FT.STATIONID
	LEFT JOIN DIMDATE AS DD
	ON FT.DATEID = DD.DATEID
GROUP BY ROLLUP (DD.YEAR, DS.CITY, FT.stationid);



Task 15 - Create a cube query
Create a cube query using the columns year, city, stationid, and average waste collected.
SELECT
	DD.YEAR,
	DS.CITY,
	FT.stationid,
    AVG(FT.WASTECOLLECTED) AS AVARAGE_WASTE_COLLECTED
FROM DIMSTATION AS DS
LEFT JOIN FACTTRIPS AS FT
	ON DS.STATIONID = FT.STATIONID
	LEFT JOIN DIMDATE AS DD
	ON FT.DATEID = DD.DATEID
GROUP BY CUBE (DD.YEAR, DS.CITY, FT.stationid);



Task 16 - Create an MQT
Create an MQT named max_waste_stats using the columns city, stationid, trucktype, and max waste collected.
CREATE TABLE "DRF66162".max_waste_stats AS (
	SELECT
		DS.CITY,
		FT.stationid,
		DT.TRUCKTYPE,
	    MAX(FT.WASTECOLLECTED) AS MAX_WASTE_COLLECTED
	FROM DIMSTATION AS DS
	LEFT JOIN FACTTRIPS AS FT
		ON DS.STATIONID = FT.STATIONID
		LEFT JOIN DIMTRUCK AS DT
		ON FT.TRUCKID = DT.TRUCKID
	GROUP BY DS.CITY,
		FT.stationid,
		DT.TRUCKTYPE

 ) DATA INITIALLY DEFERRED REFRESH DEFERRED
 MAINTAINED BY USER;
 -- ORGANIZE BY CITY;
 SET INTEGRITY FOR "DRF66162".max_waste_stats ALL IMMEDIATE UNCHECKED;

 SELECT * FROM "DRF66162".max_waste_stats LIMIT 10;





------------------------------------ Exercise 5 - Create a dashboard using Cognos Analytics
Download the data from https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Final%20Assignment/DataForCognos.csv
# here. the work is conducted in Cognos in a browser


Task 17 - Create a pie chart in the dashboard
Create a pie chart that shows the waste collected by truck type.


Task 18 - Create a bar chart in the dashboard
Create a bar chart that shows the waste collected station wise.


Task 19 - Create a line chart in the dashboard
Create a line chart that shows the waste collected by month wise.


Task 20 - Create a pie chart in the dashboard
Create a pie chart that shows the waste collected by city.



End of the assignment.