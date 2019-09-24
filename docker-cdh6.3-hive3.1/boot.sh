#!/usr/bin/env bash

/bin/zookeeper-server start
/etc/init.d/mysql start
/etc/init.d/hadoop-hdfs-namenode start
/etc/init.d/hadoop-hdfs-datanode start
