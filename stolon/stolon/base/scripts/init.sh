#!/bin/bash

stolonctl --cluster-name="${CLUSTER_NAME}" --store-backend=etcdv3 --store-endpoints "${STORE_ENDPOINTS}" init -y
