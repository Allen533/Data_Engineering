Objectives

- Access the MongoDB server using the CLI
  start_mongo
  mongo -u root -p NTc0My1yc2FubmFy --authenticationDatabase admin local
- Describe the process of listing and creating collections, which contain documents, and databases, which contain one or more collections
  db.createCollection("mycollection")
  show collections
- Perform basic operations on a collection such as inserting, counting and listing documents
  db.mycollection.insert({"color":"white","example":"milk"})
  db.mycollection.count() #Count the number of documents in a collection
  db.mycollection.find() # List all documents in a collection
  exit