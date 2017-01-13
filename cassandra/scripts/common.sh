#!/usr/bin/env bash

#Common

function log {
    echo "[$(date)]: $*"
}

function logDebug {
    ((DEBUG_LOG)) && echo "[DEBUG][$(date)]: $*"
}

export CASSANDRA_HOST=${CASSANDRA_CONTACT_POINT:-localhost}
export CASSANDRA_PORT=${CASSANDRA_PORT:-9042}


function waitForClusterConnection() {
    log "Waiting for Cassandra connection..."
    retryCount=0
    maxRetry=20
    cqlsh -e "Describe KEYSPACES;" ${CASSANDRA_HOST} &>/dev/null
    # nc -w 1 -z ${CASSANDRA_HOST} ${CASSANDRA_PORT}
    while [ $? -ne 0 ] && [ "$retryCount" -ne "$maxRetry" ]; do
        logDebug 'Cassandra not reachable yet. sleep and retry. retryCount =' $retryCount
        sleep 5
        ((retryCount+=1))
        cqlsh -e "Describe KEYSPACES;" ${CASSANDRA_HOST} &>/dev/null
    done

    if [ $? -ne 0 ]; then
      log "Not connected after " $retryCount " retry. Abort the migration."
      exit 1
    fi

    log "Connected to Cassandra cluster"
}

logDebug "exporting CASSANDRA_HOST=${CASSANDRA_HOST} and CASSANDRA_PORT=${CASSANDRA_PORT}"