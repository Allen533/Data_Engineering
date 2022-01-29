# (Optional) Hands-on Lab: Message Keys and Offset

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

 4 - Create a topic and producer for processing bank ATM transactions  #-- Open a new terminal
cd kafka_2.12-2.8.0
bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic bankbranch  --partitions 2
- we can list all the topics to see if bankbranch has been created successfully
bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
- We can also use the --describe command to check the details of the topic bankbranch
bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic bankbranch

- Stay in the same terminal window with the topic details, then create a producer for topic bankbranch
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic bankbranch
- Start a new terminal and go to the extracted Kafka folder: #-- Open a new terminal
cd kafka_2.12-2.8.0
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --from-beginning
#Then, you should see the 5 new messages we just published

 5 - Produce and consume with message keys
- First, go to the consumer terminal and stop the consumer using Ctrl + C (Windows)
- Then, switch to the Producer terminal and stop the previous producer.
- start a new producer with the following message key commands:
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic bankbranch
  --property parse.key=true --property key.separator=:
# --property parse.key=true to make the producer parse message keys
# --property key.separator=: define the key separator to be the : character,
- Next, switch to the consumer terminal again, and start a new consumer with
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --from-beginning
  --property print.key=true --property key.separator=:

 6 - Consumer Offset
# By using offsets in the consumer, you can specify the starting position for message consumption,
# such as from the beginning to retrieve all messages,
# or from some later point to retrieve only the latest messages.

 7 - Consumer Group
# In addition, we normally group related consumers together as a consumer group.
# For example, we may want to create a consumer for each ATM in the bank and
# manage all ATM related consumers together in a group.
- Run the following command to create a new consumer within a consumer group called atm-app
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app
# CURRENT-OFFSET -- max num of offsets
# LOG-END-OFFSET -- indicates the last offset or the end of the sequence
# LAG -- which represents the count of unconsumed messages for each partition

 8 - Reset offset
bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092  --topic bankbranch
  --group atm-app --reset-offsets --to-earliest --execute
# Now the offsets have been set to 0 (the beginning).
- Start the consumer again
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch --group atm-app
# after the reset, after running this command the output is list of all messages again
- In fact, you can reset the offset to any position. reset the offset so that we only consume the last two messages.
bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092  --topic bankbranch
--group atm-app --reset-offsets --shift-by -2 --execute
