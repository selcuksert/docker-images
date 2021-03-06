#!/bin/bash

ZOOKEEPER_HOST=$1
ZOOKEEPER_PORT=$2
KAFKA_BS_SERVERS=$3
SR_HOST=$4
SR_PORT=$5


sed "s/bootstrap.servers=localhost:9092/bootstrap.servers=$KAFKA_BS_SERVERS/g" -i $KSQL_HOME/config/ksql-server.properties
sed "s/#ksql.schema.registry.url=?/ksql.schema.registry.url=http:\/\/$SR_HOST:$SR_PORT/g" -i $KSQL_HOME/config/ksql-server.properties

until nc -z -v $ZOOKEEPER_HOST $ZOOKEEPER_PORT
do
    echo "$ZOOKEEPER_HOST:$ZOOKEEPER_PORT is NOT Alive"
	sleep 3
done

until nc -z -v $SR_HOST $SR_PORT
do
    echo "$SR_HOST:$SR_PORT is NOT Alive"
	sleep 3
done


ksql-server-start $KSQL_HOME/config/ksql-server.properties