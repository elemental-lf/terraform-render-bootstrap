#!/bin/sh

APISERVER_STATE=/run/apiserver.state

# shellcheck disable=SC2046
exit $(cat "$APISERVER_STATE")
