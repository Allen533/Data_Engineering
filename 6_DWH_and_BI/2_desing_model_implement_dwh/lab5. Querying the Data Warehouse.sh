!!! This lab requires that you complete the previous lab Populate a Data Warehouse.
-----------------------------------------------------------
Objectives

- Grouping sets
- Rollup
- Cube
- Materialized Query Tables (MQT)

--------------------------
1. Login to your Cloud IBM DB2
# This lab requires that you complete the previous lab Populate a Data Warehouse.


2 - Write a query using grouping sets
#
select year,category, sum(billedamount) as totalbilledamount
from factbilling
left join dimcustomer
on factbilling.customerid = dimcustomer.customerid
left join dimmonth
on factbilling.monthid=dimmonth.monthid
group by grouping sets( year,category )
order by year, category


3 - Write a query using rollup
#
select year,category, sum(billedamount) as totalbilledamount
from factbilling
left join dimcustomer
on factbilling.customerid = dimcustomer.customerid
left join dimmonth
on factbilling.monthid=dimmonth.monthid
group by rollup(year,category)
order by year, category


4 - Write a query using cube
#
select year,category, sum(billedamount) as totalbilledamount
from factbilling
left join dimcustomer
on factbilling.customerid = dimcustomer.customerid
left join dimmonth
on factbilling.monthid=dimmonth.monthid
group by cube(year,category)
order by year, category


5 - Create a Materialized Query Table(MQT)
--- Step 1: Create the MQT.
#
CREATE TABLE countrystats (country, year, totalbilledamount) AS
  (select country, year, sum(billedamount)
from factbilling
left join dimcustomer
on factbilling.customerid = dimcustomer.customerid
left join dimmonth
on factbilling.monthid=dimmonth.monthid
group by country,year)
     DATA INITIALLY DEFERRED # data is not initially populated into this MQT
     REFRESH DEFERRED # whenever the underlying data changes, the MQT does NOT automatically refresh
     MAINTAINED BY SYSTEM; # The MQT is system maintained and not user maintained

--- Step 2: Populate/refresh data into the MQT
#
refresh table countrystats; #  populates the MQT with relevant data.

--- Step 3: Query the MQT.
#
select * from countrystats