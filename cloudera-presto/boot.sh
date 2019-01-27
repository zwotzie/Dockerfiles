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

# run presto as user ${PRESTO_USER}
export PRESTO_HOME=/usr/lib/presto
# foreground:
# su pentaho -c "$PRESTO_HOME/bin/launcher run"
# run daemonized:
su presto -c "$PRESTO_HOME/bin/launcher start"



if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

