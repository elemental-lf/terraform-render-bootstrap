#!/bin/sh
# docker-keepalived container image only contains /bin/sh

TYPE="$1"
NAME="$2"
STATE="$3"

echo -n "$${STATE}" > /var/run/keepalived.state
exit 0
