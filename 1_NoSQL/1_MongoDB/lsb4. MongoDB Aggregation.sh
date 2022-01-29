Objectives

- Describe simple aggregation operators that process and compute data such as $sort, $limit, $group,  $sum, $min, $max, and $avg
  db.marks.aggregate([{"$limit":2}]) # head(2)
  db.marks.aggregate([{"$sort":{"marks":1}}]) #sort( , asc)
  db.marks.aggregate([{"$sort":{"marks":-1}}]) #sort( , desc)
  db.marks.aggregate([
    {"$sort":{"marks":-1}},
    {"$limit":2}
    ])
  db.marks.aggregate([  # groupby()
  {
      "$group":{
          "_id":"$subject",
          "average":{"$avg":"$marks"}
          }
  }
  ])


- Combine operators to create multi-stage aggregation pipelines
- Build aggregation pipelines that draw insights about the data by returning aggregated values