#!/bin/bash

DAEMONS="\
   mysqld \
   cloudera-quickstart-init \
   zookeeper-server \
   hadoop-hdfs-datanode \
   hadoop-hdfs-journalnode \
   hadoop-hdfs-namenode \
   hadoop-hdfs-secondarynamenode \
   hadoop-httpfs \
   hadoop-mapreduce-historyserver \
   hadoop-yarn-nodemanager \
   hadoop-yarn-resourcemanager \
   hive-metastore \
   hive-server2 \
   hue"

#        hbase-master \
#        hbase-rest \
#        hbase-thrift \
#        sqoop2-server \
#        spark-history-server \
#        hbase-regionserver \

#        impala-state-store \
#        oozie \
#        solr-server \
#        impala-catalog \
#        impala-server \

for daemon in ${DAEMONS}; do
    echo "=========================================================="
    echo "===== STARTE ${daemon} ==================================="
    echo "=========================================================="

    service ${daemon} start
done

echo "all daemons started"
echo "=========================================================="

export PRESTO_HOME=/usr/lib/presto
su rh -c "$PRESTO_HOME/bin/launcher run"



if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

