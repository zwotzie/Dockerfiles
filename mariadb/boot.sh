#!/usr/bin/env bash
set -eo pipefail
shopt -s nullglob

if [ -z "$1" ]; then
    exec gosu mysql mysqld --datadir=/data
fi

exec "$@"