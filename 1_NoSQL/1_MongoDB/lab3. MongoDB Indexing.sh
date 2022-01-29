Objectives

- Measure the time it takes to execute a query with the explain function
  db.bigdata.find({"account_no":58982}).explain("executionStats").executionStats.executionTimeMillis

- Describe the process of creating, listing and deleting indexes
  db.bigdata.createIndex({"account_no":1})
  db.bigdata.getIndexes()
  db.bigdata.dropIndex({"account_no":1})
