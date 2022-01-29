Objectives


- Getting the environment ready
  - in IBM Cloudant, create an instance and credentials to it
  - using credential, run
  export CLOUDANTURL="https://apikey-v2-1ktn8d6fuuo6kjoz145fris5ccx24fhmirsku7o3q7bh:6b3dc2399426437b2397e08ac9cf0184@4646e655-6aee-42d8-8b93-d2bde6e9a6ca-bluemix.cloudantnosqldb.appdomain.cloud"
  - test if connected
  curl $CLOUDANTURL
  - test your credentials
  curl $CLOUDANTURL/_all_dbs

- Create, query and drop databases
  curl -X PUT $CLOUDANTURL/animals # Create a database
  curl $CLOUDANTURL/_all_dbs # lists dbs
  curl -X DELETE $CLOUDANTURL/animals

- Perform basic commands such as inserting, updating and deleting documents
  - Run the below command to insert a document in the planets database with _id of "1".
  curl -X PUT $CLOUDANTURL/planets/"1" -d '{
    "name" : "Mercury" ,
    "position_from_sum" :1
     }'
  - Verify by listing the document with the _id "1".
  curl -X GET $CLOUDANTURL/planets/1

  - Update a document
  curl -X PUT $CLOUDANTURL/planets/1 -d '{
    "name" : "Mercury" ,
    "position_from_sum" :1,
    "revolution_time":"88 days",
    "_rev":"1-3fb3ccfe80573e1ae334f0cfa7304f6c"
    }'

  - delete
  curl -X DELETE $CLOUDANTURL/planets/1?rev=2-de9fdd2d971e377c5db2d6425cb38ff1

- query
  curl -X POST $CLOUDANTURL/diamonds/_find \
    -H"Content-Type: application/json" \
    -d'{
        "selector":
            {
                "_id":"1"
            }
        }'
  curl -X POST $CLOUDANTURL/diamonds/_find \
    -H"Content-Type: application/json" \
    -d'{ "selector":
            {
                "price":
                    {
                        "$gt":345
                    }
            }
        }'

- Create an index to optimize query time
  curl -X POST $CLOUDANTURL/diamonds/_index \
    -H"Content-Type: application/json" \
    -d'{
        "index": {
            "fields": ["price"]
        }
    }'
