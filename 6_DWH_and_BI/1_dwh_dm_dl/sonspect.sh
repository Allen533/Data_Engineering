- A data warehouse is a large repository of data that has been cleaned to a consistent quality.
  Data warehouses enable rapid business decision-making through accurate and flexible reporting and data analysis.

- dwh - a system that aggregetes data from one ot more sources
  into a single consistent data store to support data analytics.

benefits:
- centralizes data from dispareate sources
- creates a single source of truth -- better d quality
- laverages all the d while enhancing speed to access  -- faster business insights
- facilitates smarter decisions using BI




++++++++++++++++++
popular dwh systems.

- appliances   --- Oracle Exadata, IBM Netezza,
- cloud only  -- amazon redshifd, snowflake, BigQuery,
- on premises (and cloud) --- Azure Synapse Analytics, teradata Vantage,  IBM Db2 warehouse, Vertica, Oracle Automous dwh



++++++++++++++++++++++
IBM Db2 Warehouse (Optional)
- good with contanerizing , Docker
- automate data schema and data loading
- lightning fast queries with BLU
- comes with dashboards



++++++++++++++++++++++++++
Data Marts Overview.
- a isolated part of another commercial data warehouse, designed spicifically to serve particullar business function
- departments may be using thier own dm-s

- is focused on only the most relevant data

typical structure:
- rdb
- star or snowflake schema
- central fact table of business metrics surrounded by associated dimension tables

Comparisan dm vs db, dm vs dwh.
dm:
- OLAP systems - read intensive
- Use Txn dbs or warehouses as data sources
- contain clean validated analytical data
- accumulate history for trend analysis
db:
- OLTP systems - write intensive
- use oprtational application as sources of data
- contaion raw unprocessed transactional data - may not always store  history

dm:
- small data wrh with tactical scope,
- lean and fast
dwh:
- large repositories with broad, strategic scope
- large and slow


3 types of dm:
- dependent  -  draw data from a dwh
- independent - data directly from sources
- hybrid


++++++++++++++++++++++++++++++++++
Data Lakes Overview
- storage repo that can store a large amount of data in raw format and tagged with metadata
- sometimes it is used as a staging area for T phase

can deploy  using
  - cloud objest storage
  - large scale distr sys like Hadoop
  - rdbms
  - nosql d repos

