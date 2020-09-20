#!/bin/bash
while [ 1 -eq 1 ]
do 
  sleep 5
  wget -cq https://jsonplaceholder.typicode.com/todos/`shuf -i 1-100 -n 1` -O - | tr -d '\n' >> /tmp/messages.log
  echo >> /tmp/messages.log
done