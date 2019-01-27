#!/usr/bin/env bash

set -eu
set -o pipefail

version=10.3
mpasswd=my-secret-pw
baseimagename=base_mariadb

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${BASEDIR}

if nc -z -v -w1 localhost 3306  > /dev/null 2>&1 ; then
    echo "mysql/mariadb is running... stop first!"
    exit 1
fi

docker pull mariadb:${version}

# # renew old mysql directory
# [ -d mysql/ ] && rm -rf mysql/
# cp -a ../databases/mysql .

# will be executed in alphabetical order
[[ "$(ls -A docker-entrypoint-initdb.d/)" ]] && rm docker-entrypoint-initdb.d/*
#
# if you have ddls to execute copy all into directory docker-entrypoint-initdb.d/
#

docker run \
    --name mariadb_${version} \
    -v ${BASEDIR}/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
    -e MYSQL_ROOT_PASSWORD=${mpasswd} \
    -d \
    mariadb:${version} --datadir=/data

# wait to startup mariadb
s=10
echo "wait some time (${s}s) to start mariadb in container"
sleep ${s}

echo
echo "committing mariadb_${version} with password to new container ${baseimagename}"

docker commit mariadb_${version} ${baseimagename}:${version}

echo
echo "removing prerequisited container"
# docker rm -f mariadb_${version}

echo
echo "you have a new container with local root password for mariadb"
docker images ${baseimagename}:${version}
