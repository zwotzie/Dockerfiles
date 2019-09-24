#!/usr/bin/env bash
set -euxo pipefail

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SERVICE=cdh
SERVICE_VERSION=6.3.0

IMAGE=$SERVICE:$SERVICE_VERSION

docker build -t $IMAGE .