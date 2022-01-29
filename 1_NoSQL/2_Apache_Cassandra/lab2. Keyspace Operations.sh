Objectives

- Getting the environment ready
  start_cassandra
  cqlsh --username cassandra --password MTg3MzMtcnNhbm5h

- Create, update and remove a keyspace in Cassandra
  CREATE KEYSPACE training
      WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3}; # SimpleStrategy is used when all the nodes in your cassandra cluster exist in a single data center
  drop keyspace training;
  use training;
  ALTER KEYSPACE training
      WITH replication = {'class': 'NetworkTopologyStrategy'};


- Describe a keyspace by listing all the tables in it
  describe keyspaces #List all keyspaces
  describe training
  describe tables # ist all tables in this keyspace.