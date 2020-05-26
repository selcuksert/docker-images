#!/bin/bash

ZOOKEEPER_HOST=$1
ZOOKEEPER_PORT=$2
KAFKA_BS_SERVERS=$3
SR_URL=$4
DB_HOST=$5
DB_PORT=$6

sed "s/bootstrap.servers=localhost:9092/bootstrap.servers=$KAFKA_BS_SERVERS/g" -i $KAFKA_HOME/config/connect-standalone.properties
sed "s/org.apache.kafka.connect.json.JsonConverter/io.confluent.connect.avro.AvroConverter/g" -i $KAFKA_HOME/config/connect-standalone.properties
sed "s/org.apache.kafka.connect.json.JsonConverter/io.confluent.connect.avro.AvroConverter/g" -i $KAFKA_HOME/config/connect-standalone.properties

echo "key.converter.schema.registry.url=$SR_URL" >> $KAFKA_HOME/config/connect-standalone.properties
echo "value.converter.schema.registry.url=$SR_URL" >> $KAFKA_HOME/config/connect-standalone.properties

echo "plugin.path=${KAFKA_HOME}/plugins" >> $KAFKA_HOME/config/connect-standalone.properties

until nc -z -v $ZOOKEEPER_HOST $ZOOKEEPER_PORT
do
    echo "$ZOOKEEPER_HOST:$ZOOKEEPER_PORT is NOT Alive"
	sleep 3
done

until nc -z -v $DB_HOST $DB_PORT
do
    echo "$DB_HOST:$DB_PORT is NOT Alive"
	sleep 3
done


connect-standalone.sh $KAFKA_HOME/config/connect-standalone.properties $KAFKA_HOME/config/mysql-connector.properties