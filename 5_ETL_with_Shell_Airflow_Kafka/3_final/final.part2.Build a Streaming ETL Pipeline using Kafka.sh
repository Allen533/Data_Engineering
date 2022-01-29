Objectives

(Prepare the lab environment)
wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz
tar -xzf kafka_2.12-2.8.0.tgz
start_mysql
mysql --host=127.0.0.1 --port=3306 --user=root --password=Mjk0NDQtcnNhbm5h
create database tolldata;
use tolldata;
create table livetolldata(timestamp datetime,vehicle_id int,vehicle_type char(15),toll_plaza_id smallint);
# This is the table where you would store all the streamed data that comes from kafka.
exit
pip3 install kafka-python
pip3 install mysql-connector-python



- Start Zookeeper
cd kafka_2.12-2.8.0
bin/zookeeper-server-start.sh config/zookeeper.properties

- Start the Kafka server
cd kafka_2.12-2.8.0
bin/kafka-server-start.sh config/server.properties

- Create a topic named toll in kafka.
cd kafka_2.12-2.8.0
bin/kafka-topics.sh --create --topic toll --bootstrap-server localhost:9092

- Download streaming data generator program.
  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/toll_traffic_generator.py
 # Customize the generator program to steam to toll topic.

- Download and customise streaming data consumer.
  wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/streaming_data_reader.py
  #Customize the consumer program to write into a MySQL database table.

- Verify that streamed data is being collected in the database table