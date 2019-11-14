#!/bin/bash
set -xo pipefail

KEEPALIVED_STATE="$(cat /var/run/keepalived.state)"
[[ $KEEPALIVED_STATE == "" ]] && exit 1

ip -oneline addr show bond0 up | fgrep ${apiserver_vip}/32
IP_ADDRESS_EXISTS="$?"

[[ $KEEPALIVED_STATE == "MASTER" && $IP_ADDRESS_EXISTS == 0 ]] && exit 0
[[ $KEEPALIVED_STATE == "BACKUP" && $IP_ADDRESS_EXISTS == 1 ]] && exit 0
[[ $KEEPALIVED_STATE == "FAULT" && $IP_ADDRESS_EXISTS == 1 ]] && exit 0

# Fail in all other cases
exit 1
