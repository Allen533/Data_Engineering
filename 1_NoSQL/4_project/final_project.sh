Objectives:
replicate a Cloudant database.
create indexes on a Cloudant database.
query data in a Cloudant database.
import data into a MongoDB database.
query data in a MongoDB database.
export data from MongoDB.
import data into a Cassandra database.
query data in a Cassandra database.

------------------------------------------
Overall:

npm install -g couchimport
couchimport --version
export CLOUDANTURL="https://apikey-v2-2ifpq9i8vancjs254q0k8tonq6698xmq0tuvb3fkwew7:13c6195fbf262a75c8402e9e5dbe1e32@61d60de1-9f4f-47ea-9262-69d33bd1c348-bluemix.cloudantnosqldb.appdomain.cloud"
curl $CLOUDANTURL
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
tar -xf mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
export PATH=$PATH:/home/project/mongodb-database-tools-ubuntu1804-x86_64-100.3.1/bin
echo "done"
curl -X POST $CLOUDANTURL/movies/_index -H"Content-Type: application/json" -d'{ "index":
{"fields": ["director"]}
}'
curl -X POST $CLOUDANTURL/movies/_index -H"Content-Type: application/json" -d'{ "index":
{"fields": ["title"]}
}'
url -X POST $CLOUDANTURL/movies/_find -H"Content-Type: application/json" -d'{ "selector":
       {
            "title": "Top Dog"

        }, "fields": ["year", "director"]
    }'
couchexport --url $CLOUDANTURL --db movies --type jsonl>movies.json

start_mongo
mongoimport -u root -p MjA4MDgtZXZhbnF3 --authenticationDatabase admin --db entertainment --collection movies --file movies.json
mongo -u root -p Mjc3NjAtZXZhbnF3 --authenticationDatabase admin local

-------------------------------------------
Exercise 1 - Check the lab environment

npm install -g couchimport
couchimport --version
export CLOUDANTURL="https://apikey-v2-2ifpq9i8vancjs254q0k8tonq6698xmq0tuvb3fkwew7:13c6195fbf262a75c8402e9e5dbe1e32@61d60de1-9f4f-47ea-9262-69d33bd1c348-bluemix.cloudantnosqldb.appdomain.cloud"
curl $CLOUDANTURL
wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
tar -xf mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
export PATH=$PATH:/home/project/mongodb-database-tools-ubuntu1804-x86_64-100.3.1/bin
echo "done"


-------------------------------------------
Exercise 2 - Working with a Cloudant database

Task 1 - Replicate a remote database into your Cloudant instance
answer:

Task 2 - Create an index for the "director" key, on the 'movies' database using the HTTP API
answer:
curl -X POST $CLOUDANTURL/movies/_index -H"Content-Type: application/json" -d'{ "index":
{"fields": ["director"]}
}'

Task 3 - Write a query to find all movies directed by 'Richard Gage' using the HTTP API
answer:
curl -X POST $CLOUDANTURL/movies/_find -H"Content-Type: application/json" -d'{ "selector":
       {
            "title": "Top Dog"

        }
    }'

Task 4 - Create an index for the "title" key, on the 'movies' database using the HTTP API
answer:
curl -X POST $CLOUDANTURL/movies/_index -H"Content-Type: application/json" -d'{ "index":
{"fields": ["title"]}
}'

Task 5 - Write a query to list only the "year" and "director" keys for the 'Top Dog' movies using the HTTP API
answer:
url -X POST $CLOUDANTURL/movies/_find -H"Content-Type: application/json" -d'{ "selector":
       {
            "title": "Top Dog"

        }, "fields": ["year", "director"]
    }'

Task 6 - Export the data from the 'movies' database into a file named 'movies.json'
answer:
couchexport --url $CLOUDANTURL --db movies --type jsonl>movies.json




-----------------------------------------------------------
Exercise 3 - Working with a MongoDB database

Task 7. - Import 'movies.json' into mongodb server into a database named 'entertainment'
        and a collection named 'movies'
answer:
start_mongo
mongoimport -u root -p MjA4MDgtZXZhbnF3 --authenticationDatabase admin --db entertainment --collection movies --file movies.json

Task 8 - Write a mongodb query to find the year in which most number of movies were released
answer:
use movies
mongo -u root -p NzMxNy1ldmFucXdx --authenticationDatabase admin local
#now it is CLI
use entertainment
db.movies.aggregate([
{
    "$group":{
        "_id":"$year",
        "moviecount":{"$sum":1}
        }
}, {
    "$sort":{"moviecount":-1}
},
{
    "$limit":1
}
])


Task 9 - Write a mongodb query to find the count of movies released after the year 1999
db.movies.find( { "year": { "$gt": 1999 } } ).count()


Task 10. Write a query to find out the average votes for movies released in 2007
db.movies.aggregate([
{"$match": {"year":2007}},
{
    "$group":{
        "_id":"$year",
        "avg_votecount":{"$avg":"$imdb.votes"}
        }
  } ])


db.articles.aggregate(
    [ {"$match": {"year":2007} } ]
)
db.movies.aggregate([
{"$match": {"year":2007}},
{
    "$group":{
        "_id":"$year",
        "votecount":{"$avg":"imdb{votes}"}
        }
}
])

{"$match": {"year":2007}},
{
    "$group":{
        "_id":"$title",
        "votecount":{"$avg":"vote"}
        }
}
])



Task 11 - Export the fields _id, "title", "year", "rating" and "director" from the 'movies' collection into a file named partial_data.csv
# Export the fields _id,clarity,cut,price from the 'training' database, 'diamonds' collection into a file named 'mongodb_exported_data.csv'
mongoexport -u root -p NzMxNy1ldmFucXdx --authenticationDatabase admin --db entertainment --collection movies --out partial_data.csv --type=csv --fields _id,title,year,rating,director



-------------------------------------------------------------
Exercise 4 - Working with a Cassandra database

Task 12 - Import 'partial_data.csv' into cassandra server into a keyspace named 'entertainment' and a table named 'movies'
  start_cassandra
  cqlsh --username cassandra --password MTUzOTYtZXZhbnF3
  CREATE KEYSPACE entertainment
    WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};
  use entertainment;
  CREATE TABLE movies(
    id text PRIMARY KEY,
    title text,
    year text,
    rating text,
    runtime text
    );

COPY entertainment.movies(id,title,year,rating,runtime) FROM 'partial_data.csv' WITH DELIMITER=',' AND HEADER=TRUE;
SELECT * FROM movies;

14.
create index rating_index on entertainment.movies(rating);
DESC INDEX entertainment.rating_index;
#check
SELECT column_name, index_name, index_options, index_type, component_index
FROM system.schema_columns;

15.
SELECT COUNT(*) FROM movies WHERE rating='G';