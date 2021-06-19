#!/bin/bash

function checkAvailability() {
  ETCD_HOST=$1
  ETCD_PORT=$2

  until nc -z -v "${ETCD_HOST}" "${ETCD_PORT}"; do
    echo "$ETCD_HOST:$ETCD_PORT is NOT Alive"
    sleep 3
  done
}

function initCluster() {
  sleep $((1 + RANDOM % 10))s

  CLUSTER_STATUS="$(getClusterStatus)"

  echo "Cluster status: ${CLUSTER_STATUS}"

  if [ "${CLUSTER_STATUS}" != "completed" ]; then
    setClusterStatus "completed"
    gosu stolon init
  fi
}

function getClusterStatus() {
  etcdctl --endpoints "${STORE_ENDPOINTS}" get --print-value-only init
}

function setClusterStatus() {
  etcdctl --endpoints "${STORE_ENDPOINTS}" put init "$1"
}

function startSentinel() {
  initCluster

  gosu stolon stolon-sentinel \
    --cluster-name "${CLUSTER_NAME}" \
    --store-backend=etcdv3 \
    --store-endpoints "${STORE_ENDPOINTS}" \
    --log-level "${LOG_LEVEL}"
}

function startProxy() {
  gosu stolon stolon-proxy \
    --listen-address 0.0.0.0 \
    --cluster-name "${CLUSTER_NAME}" \
    --store-backend=etcdv3 \
    --store-endpoints "${STORE_ENDPOINTS}" \
    --log-level "${LOG_LEVEL}"
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

if [ "${PROFILE}" == "sentinel" ]; then
  startSentinel
elif [ "${PROFILE}" == "proxy" ]; then
  startProxy
fi
