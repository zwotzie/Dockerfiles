#!/bin/bash
set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SERVICE=my_mariadb
SERVICE_VERSION=10.3

IMAGE=$SERVICE:$SERVICE_VERSION

docker build -t $IMAGE .

