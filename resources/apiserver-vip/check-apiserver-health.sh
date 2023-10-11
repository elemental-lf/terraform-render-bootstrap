#!/bin/bash
set -xo pipefail

APISERVER_STATE=/run/apiserver.state

while true; do
  kubectl get --raw /healthz
  echo $? >"$APISERVER_STATE"
  sleep 5
done
