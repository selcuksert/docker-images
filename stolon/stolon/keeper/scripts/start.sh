#!/bin/bash

function checkAvailability() {
  ETCD_HOST=$1
  ETCD_PORT=$2

  until nc -z -v "${ETCD_HOST}" "${ETCD_PORT}"; do
    echo "$ETCD_HOST:$ETCD_PORT is NOT Alive"
    sleep 3
  done
}

(
  IFS=','
  for host_port in $ETCD_LIST; do
    IFS=':'
    host_port_arr=($host_port)
    checkAvailability "${host_port_arr[0]}" "${host_port_arr[1]}"
  done
)

unset IFS

gosu stolon stolon-keeper \
  --pg-listen-address "${HOSTNAME}" \
  --pg-repl-username "${REPLICATION_USER}" \
  --pg-repl-password "${REPLICATION_PASS}" \
  --pg-su-username "${DB_USER}" \
  --pg-su-password "${DB_PASS}" \
  --uid "${HOSTNAME}" \
  --data-dir "${PG_DATA}" \
  --cluster-name "${CLUSTER_NAME}" \
  --store-backend=etcdv3 \
  --store-endpoints "${STORE_ENDPOINTS}" \
  --log-level "${LOG_LEVEL}"
