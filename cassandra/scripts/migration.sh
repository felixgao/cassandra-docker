#!/usr/bin/env bash

my_dir="$(dirname "$0")"
source "$my_dir/createKeyspace.sh"

export CASSANDRA_MIGRATION_JAR=${CASSANDRA_MIGRATION_JAR:-/tmp/cassandra-migration.jar}
export MIGRATION_SCRIPT=${MIGRATION_SCRIPT:-/cql}
export CASSANDRA_KEYSPACE=${CASSANDRA_KEYSPACE:-datafabrics}

log "java -jar -Dcassandra.migration.keyspace.name=${CASSANDRA_KEYSPACE} \
    -Dcassandra.migration.cluster.port=${CASSANDRA_PORT} \
    -Dcassandra.migration.cluster.username=${CQLSH_USERNAME} \
    -Dcassandra.migration.cluster.password=${CQLSH_PASSWORD} \
    -Dcassandra.migration.scripts.locations=filesystem:${MIGRATION_SCRIPT}\
    -Dcassandra.migration.cluster.contactpoints=${CASSANDRA_HOST} \
    ${CASSANDRA_MIGRATION_JAR} migrate"

java -jar -Dcassandra.migration.keyspace.name=${CASSANDRA_KEYSPACE} \
    -Dcassandra.migration.cluster.port=${CASSANDRA_PORT} \
    -Dcassandra.migration.cluster.username=${CQLSH_USERNAME} \
    -Dcassandra.migration.cluster.password=${CQLSH_PASSWORD} \
    -Dcassandra.migration.scripts.locations=filesystem:${MIGRATION_SCRIPT} \
    -Dcassandra.migration.cluster.contactpoints=${CASSANDRA_HOST} \
    ${CASSANDRA_MIGRATION_JAR} migrate

if [ $? -ne 0 ]; then
    echo "failed to execute the migration script. Please contact administrator."
    exit 1;
fi