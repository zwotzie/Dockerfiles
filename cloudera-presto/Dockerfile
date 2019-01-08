FROM cloudera/quickstart

# https://github.com/CentOS/sig-cloud-instance-images/issues/15
RUN yum install -y --nogpgcheck --disablerepo "*cloudera*" yum-plugin-ovl

# This is a loan from https://github.com/HariSekhon/Dockerfiles/blob/master/presto/Dockerfile
# COPY java-1.8.0-openjdk-headless-1.8.0.191.b12-0.el6_10.x86_64.rpm /
COPY java-1.8*.rpm /

RUN yum -y --disablerepo "*cloudera*" localinstall /java-1.8.0-openjdk-headless-1.8.0.191.b12-0.el6_10.x86_64.rpm \
    && yum clean all

ARG PRESTO_VERSION=0.215

LABEL Description="Presto SQL" \
      "Presto SQL Version"="$PRESTO_VERSION"

RUN set -euxo pipefail && \
    yum -y --disablerepo "*cloudera*" install wget && \
    SERVER_BASE_URL="https://repo1.maven.org/maven2/com/facebook/presto" &&\
    CLI_JAR="presto-cli-${PRESTO_VERSION}-executable.jar" && \
    SERVER_TAR_DIR="presto-server-${PRESTO_VERSION}" && \
    SERVER_TAR="presto-server-${PRESTO_VERSION}.tar.gz" && \
    JDBC_JAR="presto-jdbc-${PRESTO_VERSION}.jar" && \
    # https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.213/presto-server-0.213.tar.gz
    # https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.213/presto-cli-0.213-executable.jar
    # https://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/0.213/presto-jdbc-0.213.jar
    wget -q -c -t 10 --retry-connrefused "$SERVER_BASE_URL/presto-server/$PRESTO_VERSION/$SERVER_TAR" && \
    wget -q -c -t 10 --retry-connrefused "$SERVER_BASE_URL/presto-cli/$PRESTO_VERSION/$CLI_JAR" && \
    wget -q -c -t 10 --retry-connrefused "$SERVER_BASE_URL/presto-jdbc/$PRESTO_VERSION/$JDBC_JAR" && \
    tar zxvf "$SERVER_TAR" && \
    mv -iv "$SERVER_TAR_DIR" /usr/lib/presto && \
    rm -rfv  "$SERVER_TAR" &&\
    #rm -rfv "$SERVER_TAR_DIR" && \
    chmod +x "$CLI_JAR" && \
    ln -sv "/$CLI_JAR" /usr/local/bin/presto && \
    # the JDBC 4.2 driver is the one for Java 8
    # mv -iv "JDBC_JAR" . && \
    # get rid of all the other unneeded drivers to save space
    # older versions of Presto look for config in /usr/lib/presto/etc, linking for compatability across versions
    ln -sv /etc/presto /usr/lib/presto/etc && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY etc/presto /etc/presto/
COPY beeline.sh /usr/local/bin/beeline.sh

# Add user support not running as root
RUN set -euxo pipefail && \
    mkdir -vp /var/lib/presto /var/log/presto && \
    useradd presto && \
    chown -R presto /etc/presto /usr/lib/presto /var/lib/presto /var/log/presto

ADD boot.sh /

CMD ["/boot.sh", "-d"]
