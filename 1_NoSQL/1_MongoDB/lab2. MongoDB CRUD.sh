Objectives

- Create documents in MongoDB with the insert method
  db.languages.insert({"name":"java","type":"object oriented"})
  db.languages.insert({"name":"python","type":"general purpose"})
  db.languages.insert({"name":"scala","type":"functional"})
  db.languages.insert({"name":"c","type":"procedural"})
  db.languages.insert({"name":"c++","type":"object oriented"})

- Read documents by listing them, counting them and matching them to a query
  db.languages.findOne() # List the first document in the collection.
  db.languages.find().limit(3)
  db.languages.find({"name":"python"}) # Query for "python" language.
  db.languages.find({},{"name":1}) # lists all the documents with only name field in the output.
  db.languages.find({},{"name":0})
  db.languages.find({"type":"object oriented"},{"name":1}) # ists all the "object oriented" languages with only "name" field in the output.

- Update and delete documents in MongoDB based on specific criteria
  # pattern
  db.collection.updateMany({what documents to find},{$set:{what fields to set}})
  # we are adding a field description with value programming language to all the documents.
  db.languages.updateMany({},{$set:{"description":"programming language"}})
  # Set the creater for python language.
  db.languages.updateMany({"name":"python"},{$set:{"creator":"Guido van Rossum"}})
  # Set a field named compiled with a value true for all the object oriented languages.
  db.languages.updateMany({"type":"object oriented"},{$set:{"compiled":true}})

  db.languages.remove({"name":"scala"})
  db.languages.remove({"type":"object oriented"})
  db.languages.remove({}) # Delete all the documents in a collection.