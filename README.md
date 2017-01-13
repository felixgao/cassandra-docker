# cassandra-docker

##Requirements
* **Docker 1.12.5+** 
* **docker-compose 1.9.0+**

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


####Environment Variables
- CREATE_KEYSPACE_SCRIPT
    * the name of the cql script located in resources/cql directory
- CASSANDRA_KEYSPACE
    * default: datafabrics
- CQLSH_USERNAME
    * default: [empty]
- CQLSH_PASSWORD
    * default: [empty]
- CASSANDRA_CONTACT_POINT
    * default: localhost
- CASSANDRA_PORT
    * default: 9042