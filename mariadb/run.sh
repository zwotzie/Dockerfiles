#!/usr/bin/env bash
set -eu
set -o pipefail

SERVICE_NAME=my_mariadb
SERVICE_VERSION=10.3

IMAGE=${SERVICE_NAME}:${SERVICE_VERSION}

end_out(){
    IMAGE=$1
    ID=$2
    echo "+----------- ${IMAGE} started... --------------------+"
    echo "| ContainerId      : " ${ID:0:12}
    echo "| login into       : docker exec -it ${ID:0:12} bash"
    echo "| tail logs        : docker logs -f "${ID:0:12}
    echo "| tail stderr logs : docker logs -f "${ID:0:12} ">/dev/null"
    echo "| tail stdout logs : docker logs -f "${ID:0:12} "2>/dev/null"
    echo "+----------------------------------------------------------+"
}


ID=$(docker run \
    --restart unless-stopped \
    -p 3306:3306 \
    -d \
    ${IMAGE} \
    mysqld --datadir=/data
    )

end_out $IMAGE $ID
