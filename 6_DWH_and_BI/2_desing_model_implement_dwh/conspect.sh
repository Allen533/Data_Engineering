++++++++++++++++++++
Overview of Data Warehouse Architectures.

General Enterprise DWH architecture:
1. data sources
2. staging area/ sandbox  --- ETL here, IBM InfoSphare DataStage
3. enterprise data whr repo  -- offers security for entering and exiting
4. dmarts  -- not always
5. analytics and BI tools --- IBM cognos



+++++++++++++++++++++++
Cubes, Rollups, and Materialized Views and Tables

dc - data cubes
- multidementions
- coordinates - dementions
- inside cells - facts
cube operations
- slicing
- dicing
- drilling up and down
- pivoting
- rolling up - aggregate COUNT MIN SUM AVG etc

materilized view
- a shapshot of results of query
- for replication d on the staging phase or
- precompute expensive queries
- savely work without affecting source database
- have options for refresh:
    - never - populated on creation only
    - upon request - manually or scheduled
    - immediately - auto, after every statement
- in db2 it is called MQT


++++++++++++++++++++++++++++
Grouping Sets in SQL
- The GROUPING SETS clause is used in conjunction with the GROUP BY clause to allow you
    to easily summarize data by aggregating a fact over as many dimensions as you like


+++++++++++++++++++++++++++++++
Facts and Dimensional Modeling

- fact -- cell value
- dimention  --  column, categorical variable  --  gives context
- fact table -- business processes facts + foreign keys to demension tables, can contain detail level or aggr facts
- summary table --  contains only aggr facts
- snapshot fact table  -- records events during well-defined business process
- dementional table  -- collect dementions


++++++++++++++++++++++++++++++++
Data Warehousing with Star and Snowflake schemas -- reading

- A star schema is a special case of a snowflake schema in which all hierarchical dimensions have been denormalized, or flattened
- Both star and snowflake schemas benefit from the application of normalization. “Normalization reduces redundancy
- Normalizing a table means to create, for each dimension:
    - A surrogate key to replace the natural key, that is, the unique values of the given column, and
    - A lookup table to store the surrogate and natural key pairs
- Normalization reduces data size

- if read spead/q efficiancy is needed, use denormalized star scheme.
- we can combine them by using different types at top of each others




++++++++++++++++++++++++++++++++++++++
Staging Areas for Data Warehouses

can br implemented:
- flat files + shell, Python
-  sql tables + Db2
- db + cognos

functions:
= integration
- Change detection
- scheduling
- cleaning data
- aggr
- any tr
- normalizating d

- minimize corruption risk
- simplifies ETL workflows
- simol recovery


++++++++++++++++++++++++++++++++++++++++++++++++
Verify Data Quality
- accuracy:
    - source and destination records match
    - duplicated
    - typos
    - mass misalignment
- completeness:
    - missing values
- consistency
    - non-conformance to standard terms
    - data formattind: YMD not with MDY
    - inconsistent data entry
    - consistent units
- currency:
    - outdated info
    - name changes

managing d qu


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Populating a Data Warehouse

Loading frequency -- in comertial wh
- initial load + periodic incremental loads
- full refresh -- when schema changed or a heavy db failure
- fact table -- friquent updating
- dementional tables -- rare
- good because there is a possibility of automatization

Preparation to populating data to wh
- schema -- ready
- data  -- staged
- data quality -- verified

Set up and 'initial' load:
- make instance the dwh and its schema
- create production table
- establish relations between fact/demention tables
- load transformed and cleaned data

Doing 'ongoing' loads
- automate loads with scripts # shceduling for exaample
- you need to identify what data has been changed and what has been not
    - normaly, detecting changes -- in the sourxe system
    - in many rdbms-s -- change tracking tools
    - if you can do it, use timestamps seperately for creation and change
    - otherwise, you use brute-force comparison to staged data

Periodic maintenance
- monthly/yearly data archiving
- script delition and archiving to slower less expensive storage/hardware

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Querying the Data

To optemize, use CUBE, ROLLUP, and materialized views
# cube -- set of operations - slicing, dicing, drilling up and down, pivoting
                            #- rolling up - aggregate COUNT MIN SUM AVG etc
- 1 and 2 provides summery report;
- which much easier to implement than alternative SQL q-s
- 3 are stored tables which are useful for reducing load of complex frequently q-ed views
- combining all 3 will enhence performance

- in real live
  - start with crating of mat view which denormalize the schema for better human understanding
  - modify views with CUBE ROLLUP to get gruopby summery
  - create staging tables to be implemented as incrementally refreshing materialized views

# more rows than ROLLUP, all possible combinations of Time, Region, Dept
GROUP BY
    CUBE(Time, Region, Dept)

# only inner combinations of of Time, Region, Dept
GROUP BY
    ROLLUP(Time, Region, Dept)

---------------------------------------- from web source https://www.databasejournal.com/features/mssql/using-the-rollup-cube-and-grouping-sets-operators.html
'''
What do the ROLLUP, CUBE, and GROUPING SETS operators do?
They allow you to create subtotals and grand totals a number of different ways.
ROLLUP --  It is used to create *subtotals* and grand totals for a set of columns
           The summarized amounts are created based on the columns passed to the ROLLUP operator.
CUBE -- unlike the ROLLUP operator, it produces subtotals and *grand* totals for every permutation of the columns
GROUPING SETS -- group by (1st variable) + concate + group by (2nd variable) + ....
            allows you to group your data a number of different ways in a single SELECT statement