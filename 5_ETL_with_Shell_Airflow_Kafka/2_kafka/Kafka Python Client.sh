- Kafka uses a TCP based network communication protocol to exchange data between clients and servers.

- kafka-python package
kafka-python is a Python client for the Apache Kafka distributed stream processing system,
which aims to provide similar functionalities as the main Kafka Java client.

- With kafka-python, you can easily interact with your Kafka server
such as managing topics, publish, and consume messages in Python programming language.

1. pip install kafka-python

2. Create a KafkaAdminClient object

admin_client = KafkaAdminClient(bootstrap_servers="localhost:9092", client_id='test')
# (The main purpose of KafkaAdminClient class is to enable fundamental administrative management operations
# on kafka server such as creating/deleting topic, retrieving, and updating topic configurations and so on.))

3.Create new topics:
topic_list = []
new_topic = NewTopic(name="bankbranch", num_partitions= 2, replication_factor=1)
topic_list.append(new_topic)
admin_client.create_topics(new_topics=topic_list)
- Above create topic operation is equivalent to using kafka-topics.sh --topic in Kafka CLI client:
"kafka-topics.sh --bootstrap-server localhost:9092 --create --topic bankbranch  --partitions 2 --replication_factor 1"

4. Describe a topic:
configs = admin_client.describe_configs(
    config_resources=[ConfigResource(ConfigResourceType.TOPIC, "bankbranch")])
- Above describe topic operation is equivalent to using kafka-topics.sh --describe in Kafka CLI client:
kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic bankbranch

5. KafkaProducer
-  Since many real-world message values are in the format of JSON,
  we will show you how to publish JSON messages as an example
producer = KafkaProducer(value_serializer=lambda v: json.dumps(v).encode('utf-8'))
#Since Kafka produces and consumes messages in raw bytes,
  #we need to encode our JSON messages and serialize them into bytes.
- Then, with the KafkaProducer created,
  we can use it to produce two ATM transaction messages in JSON format as follows:
producer.send("bankbranch", {'atmid':1, 'transid':100})
producer.send("bankbranch", {'atmid':2, 'transid':101})
# The above producing message operation is equivalent to using kafka-console-producer.sh --topic in Kafka CLI client:
# kafka-console-producer.sh --bootstrap-server localhost:9092 --topic bankbranch

6. KafkaConsumer
consumer = KafkaConsumer('bankbranch')
for msg in consumer:
    print(msg.value.decode("utf-8"))
# The above consuming message operation is equivalent to using kafka-console-consumer.sh --topic in Kafka CLI client:
#  kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic bankbranch
