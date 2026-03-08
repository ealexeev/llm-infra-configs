#!/usr/bin/env bash

# Exit if MY_VAR is null or not set
: "${RAY_NODE_TYPE:?Error: RAY_NODE_TYPE environment variable not set}"
: "${RAY_MGMT_IP:?Error: MGMG_IP environment variable not set}"

if [[ "${RAY_NODE_TYPE}" == "head" ]]; then
	ray start --head --node-ip-address=$RAY_MGMT_IP --port=6379 --dashboard-host 0.0.0.0
else
	ray start --address="${RAY_MGMT_IP}:6379"
fi
tail -f /dev/null
