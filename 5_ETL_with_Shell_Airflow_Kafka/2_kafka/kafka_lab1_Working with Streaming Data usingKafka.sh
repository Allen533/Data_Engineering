# week 4.
# lab.: Working with Streaming Data using Kafka


 1 - Download and extract Kafka
- Download Kafka
wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz
- Extract kafka from the zip file
tar -xzf kafka_2.12-2.8.0.tgz

 2 - start ZooKeeper
cd kafka_2.12-2.8.0
bin/zookeeper-server-start.sh config/zookeeper.properties

 3 - Start the Kafka broker server  #-- Open a new terminal
cd kafka_2.12-2.8.0
bin/kafka-server-start.sh config/server.properties

 4 - Create a topic #-- Open a new terminal
cd kafka_2.12-2.8.0
bin/kafka-topics.sh --create --topic toll --bootstrap-server localhost:9092

 5 - Start Producer
bin/kafka-console-producer.sh --topic news --bootstrap-server localhost:9092
# you can start writing mesages to Kafka

6 - Start Consumer #-- Open a new terminal
cd kafka_2.12-2.8.0
bin/kafka-console-consumer.sh --topic news --from-beginning --bootstrap-server localhost:9092

