#!/usr/bin/env bash

echo -e "\n---------------------------------------"

echo -e	"Starting Hive-Metastore..."
supervisorctl start hive-metastore

echo -e	"Starting HiveServer2..."
supervisorctl start hive-server2

