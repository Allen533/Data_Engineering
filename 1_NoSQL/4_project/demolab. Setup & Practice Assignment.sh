Objectives

install the couchimport and couchexport tools.
install the mongoimport and mongoexport tools.

export data from a Cloudant database.
import data into a Cloudant database.

export data from a MongoDB database.
import data into a MongoDB database.

export data from a Cassandra database.
import data into a Cassandra database.
create indexes on a Cassandra database.



--------------------------------------------------

- Getting the environment ready
  npm install -g couchimport
  couchimport --version
  wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
  tar -xf mongodb-database-tools-ubuntu1804-x86_64-100.3.1.tgz
  export PATH=$PATH:/home/project/mongodb-database-tools-ubuntu1804-x86_64-100.3.1/bin
  echo "done"
  mongoimport --version # Verify that the tools got installed

- Cloudant import/export data
  export CLOUDANTURL="YOUR_URL_HERE" # connect
  couchexport --url $CLOUDANTURL --db diamonds --delimiter "," # Export data from the 'diamonds' database into csv format
  couchexport --url $CLOUDANTURL --db diamonds --type jsonl # Export data from the 'diamonds' database into json format
  couchexport --url $CLOUDANTURL --db diamonds --type jsonl > diamonds.json #xport data from the 'diamonds' database into json format and save to a file named 'diamonds.json'.
  couchexport --url $CLOUDANTURL --db diamonds --delimiter "," > diamonds.csv # Export data from the 'diamonds' database into csv format and save to a file named 'diamonds.csv'.

- MongoDB import/export data
  start_mongo
  mongo -u root -p NTc0My1yc2FubmFy --authenticationDatabase admin local # i dont know if this is needed
  # Import data in 'diamonds.json' into a collection named 'diamonds' and a database named 'training'.
  mongoimport -u root -p MzA2NDAtcnNhbm5h --authenticationDatabase admin --db training --collection diamonds --file diamonds.json
  # Export data from the 'training' database, 'diamonds' collection into a file named 'mongodb_exported_data.json'
  mongoexport -u root -p MzA2NDAtcnNhbm5h --authenticationDatabase admin --db training --collection diamonds --out mongodb_exported_data.json
  # Export the fields _id,clarity,cut,price from the 'training' database, 'diamonds' collection into a file named 'mongodb_exported_data.csv'
  mongoexport -u root -p MzA2NDAtcnNhbm5h --authenticationDatabase admin --db training --collection diamonds --out mongodb_exported_data.csv --type=csv --fields _id,clarity,cut,price

- Cassandra import/export data. Task: Import 'diamonds.csv' into the 'training' keyspace and the 'diamonds' table/column family.
  - below, it is steps
  start_cassandra
  cqlsh --username cassandra --password MTUzOTYtZXZhbnF3
  CREATE KEYSPACE entertainment
    WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};
  use entertainment;
  CREATE TABLE movies(
    id int PRIMARY KEY,
    clarity text,
    cut text,
    price text
    );
  use training;
  COPY entertainment.movies(id,clarity,cut,price) FROM 'partial_data.csv' WITH DELIMITER=',' AND HEADER=TRUE;

- Creating an index on Cassandra
  create index price_index on diamonds(price);

exit
