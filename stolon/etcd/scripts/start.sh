#!/bin/bash

etcd \
--name="${HOSTNAME}" \
--data-dir=data.etcd \
--advertise-client-urls="http://${HOSTNAME}:2379" \
--listen-client-urls=http://0.0.0.0:2379 \
--initial-advertise-peer-urls="http://${HOSTNAME}:2380" \
--listen-peer-urls=http://0.0.0.0:2380 \
--initial-cluster-state=new \
--initial-cluster="${CLUSTER_LIST}"