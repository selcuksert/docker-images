#!/bin/bash

if dpkg-query -l netcat
then 
  echo "netcat installed"
else
  apt-get update && apt-get install -y netcat
fi

until nc -z -v $CONTROLLER_HOST $CONTROLLER_PORT
do
    echo 'CONTROLLER_HOST is NOT Alive'
    sleep 3
done

java -jar /home/jar/*.jar
