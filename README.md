# cassandra-docker

To use this, add a directory called resources/cql and place all your cql scripts in there.  
For keyspace it should not start with Vxxx__ where xxx is the number sequence for the migration.
For migration all cql should have the Vxxx__description.cql format. 

## usage
To start the docker images once you have all the prerequesite set. 
`docker-compose -f cassandra-cluster.yml up --build`

To execute more migration scripts
`docker-compose -f cassandra-cluster.yml run cassandra-migration`

To destory the db
`docker-compose -f cassandra-cluster.yml down`
