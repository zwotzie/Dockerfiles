FROM centos:7

# USER root

ENV CDH_VERSION 6.3.0
# ENV JAVA_VER  11
# ENV JAVA_HOME /opt/jdk-$JAVA_VER/

ENV HIVE_VER 3.1.2
ENV TEZ_VER 0.9.1
ENV HIVE_HOME /opt/hive
# ENV HIVE_CONF_DIR $HIVE_HOME/conf
# ENV HADOOP_HOME /opt/hadoop
# ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
# ENV HCAT_LOG_DIR /opt/hive/logs
# ENV HCAT_PID_DIR /opt/hive/logs
# ENV WEBHCAT_LOG_DIR /opt/hive/logs
# ENV WEBHCAT_PID_DIR /opt/hive/logs

ADD *.repo /etc/yum.repos.d/

# Install Packages
RUN yum update -y \
 && rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB \
 && yum install -y wget unzip curl vim python-setuptools sudo \
                   mariadb-server mariadb-client mysql-connector-java mariadb-common mariadb-compat \
                   net-tools \
 && easy_install supervisor \
 && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py \
 && yum clean all

# install cdh6.2
RUN rpm --import https://archive.cloudera.com/cdh6/$CDH_VERSION/redhat7/yum/RPM-GPG-KEY-cloudera \
  && yum install -y hadoop-hdfs-namenode hadoop-hdfs-datanode \
                   hadoop-yarn-resourcemanager hadoop-yarn-nodemanager hadoop-mapreduce-historyserver \
                   hive-metastore \
#                   hive-server2 \
 && yum clean all \
 && ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar

# setup mysql for metastore
RUN /etc/init.d/mysql start \
 && mysql -u root -e "CREATE DATABASE metastore" \
 && cd /usr/lib/hive/scripts/metastore/upgrade/mysql/ && mysql -u root metastore <  hive-schema-2.1.1.mysql.sql \
 && mysql -u root -e "CREATE USER 'hive'@'localhost' IDENTIFIED BY 'cloudera'; GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost'; FLUSH PRIVILEGES;" \
 && /etc/init.d/mysql stop

# Vanilla Apache Hive Installation
RUN cd /opt \
 && wget http://it.apache.contactlab.it/hive/hive-$HIVE_VER/apache-hive-$HIVE_VER-bin.tar.gz \
 && tar -xvf apache-hive-$HIVE_VER-bin.tar.gz \
 && mv ../apache-hive-$HIVE_VER-bin $HIVE_HOME \
 # && wget https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O $HIVE_HOME/lib/postgresql-42.2.5.jar \
 && wget http://it.apache.contactlab.it/tez/${TEZ_VER}/apache-tez-${TEZ_VER}-bin.tar.gz \
 && tar -xvf apache-tez-${TEZ_VER}-bin.tar.gz \
 && cp apache-tez-${TEZ_VER}-bin/tez*.jar $HIVE_HOME/lib/ \
 && rm -rf apache-tez-${TEZ_VER}-bin \
 && rm -f apache-tez-${TEZ_VER}-bin.tar.gz

COPY hive/ $HIVE_HOME/
COPY ./etc /etc

RUN chmod +x $HIVE_HOME/bin/*.sh

RUN mkdir -p /var/run/hdfs-sockets \
 && chown hdfs.hadoop /var/run/hdfs-sockets \
 && mkdir -p /data/dn/ \
 && chown hdfs.hadoop /data/dn \
 && chown mapred:mapred /var/log/hadoop-mapreduce

ADD etc/supervisord.conf /etc/
ADD etc/hadoop/conf/core-site.xml /etc/hadoop/conf/
ADD etc/hadoop/conf/hdfs-site.xml /etc/hadoop/conf/
ADD etc/hadoop/conf/mapred-site.xml /etc/hadoop/conf/
ADD etc/hive/conf/hive-site.xml /etc/hive/conf/
ADD hive-kafka-handler-2.1.1-cdh6.2.0.jar /usr/lib/hive/lib/

WORKDIR /

# Various helper scripts
ADD bin/* /
RUN chmod +x ./*.sh

EXPOSE 50010 50020 50070 50075 50090 50091 50100 50105 50475 50470 8020 8485 8480 8481
EXPOSE 50030 50060 13562 10020 19888
EXPOSE 8030 8031 8032 8040 8042 8046 8047 8088 8090 8188 8190 8788 10200
EXPOSE 10000 10002

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
