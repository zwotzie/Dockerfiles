#! /usr/bin/env bash

BEELINE_JDBC_URL="jdbc:hive2://localhost:10000/default"

if [ $# -eq 0 ]; then
  "/usr/bin/beeline" --fastConnect=false -u "${BEELINE_JDBC_URL}" -n ${USER}
else
  "/usr/bin/beeline" $@
fi
