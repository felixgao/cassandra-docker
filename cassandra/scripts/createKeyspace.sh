#!/usr/bin/env bash

#as the time of the script creation, the cqlsh supporting
#[cqlsh 5.0.1 | Cassandra 3.9 | CQL spec 3.4.2 | Native protocol v4]

my_dir="$(dirname "$0")"
source "$my_dir/common.sh"

waitForClusterConnection    

logDebug "$(printenv)"

if [ -z ${CREATE_KEYSPACE_SCRIPT+x} ]; then
    logDebug "No create keyspace script is provided: ${CREATE_KEYSPACE_SCRIPT+x}"
else
    CREATE_SCRIPT="/cql/${CREATE_KEYSPACE_SCRIPT}"
    logDebug "check create keyspace script exist?"
    if [ ! -f "${CREATE_SCRIPT}" ]; then
        log "Create keyspace CQL file ${CREATE_SCRIPT} does not exits" 
        exit 1
    fi
    
    cqlsh=$(which cqlsh)
    logDebug "cqlsh is located at: ${cqlsh}"

    log "${cqlsh} " \
     "--file=${CREATE_SCRIPT}" \
     "--username=${CQLSH_USERNAME}" \
     "--password=\"${CQLSH_PASSWORD}\"" \
     "${CASSANDRA_HOST}" \
     "${CASSANDRA_PORT}"


    $cqlsh \
    --file=${CREATE_SCRIPT} \
    --username="${CQLSH_USERNAME}" \
    --password="${CQLSH_PASSWORD}" \
    ${CASSANDRA_HOST} \
    ${CASSANDRA_PORT}

    if [ $? -ne 0 ]; then
        log "failed to execute the create keyspace command. Please contact administrator."
        exit 1;

    fi
fi

cqlsh -e "Describe ${CASSANDRA_KEYSPACE:-datafabrics};" ${CASSANDRA_HOST} ${CASSANDRA_PORT} &>/dev/null
if [ $? -ne 0 ]; then
    log "keyspace ${CASSANDRA_KEYSPACE:-datafabrics} does not exists!!!"
    exit 1;
fi