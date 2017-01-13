FROM cassandra

#download the migration script
ADD https://oss.sonatype.org/content/repositories/public/com/builtamont/cassandra-migration/0.9/cassandra-migration-0.9-jar-with-dependencies.jar /tmp/cassandra-migration.jar



# script to orchestrate the automatic keyspace creation and apply all migration scripts
ADD cassandra/scripts/common.sh /usr/local/bin/common.sh
ADD cassandra/scripts/createKeyspace.sh /usr/local/bin/createKeyspace.sh
ADD cassandra/scripts/migration.sh /usr/local/bin/autoMigrate
RUN chmod 755 /usr/local/bin/autoMigrate

ENTRYPOINT ["autoMigrate"]