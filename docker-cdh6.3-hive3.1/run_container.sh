#!/usr/bin/env bash
set -euo pipefail

ID=$(docker run  \
 --restart unless-stopped \
 --hostname=quickstart.cloudera \
 --name cdh620 \
 -p 50010:50010 \
 -p 50020:50020 \
 -p 50070:50070 \
 -p 50075:50075 \
 -p 50090:50090 \
 -p  8020:8020 \
 -p 10020:10020 \
 -p 10000:10000 \
 -p 10002:10002 \
 -p 19888:19888 \
 -p  8030:8030 \
 -p  8031:8031 \
 -p  8032:8032 \
 -p  8033:8033 \
 -p  8040:8040 \
 -p  8042:8042 \
 -p  8080:8080 \
 -p  8088:8088 \
 -p  8888:8888 \
 -p  7180:7180 \
 -d cdh:6.2.0)

echo "+-----------  hadoop cdh 6.2.0 started...  -----------------+"
echo "| ContainerId      : " ${ID:0:12}
echo "| login into       : docker exec -it ${ID:0:12} sh"
echo "| tail logs        : docker logs -f "${ID:0:12}
echo "| tail stderr logs : docker logs -f "${ID:0:12} ">/dev/null"
echo "| tail stdout logs : docker logs -f "${ID:0:12} "2>/dev/null"
echo "+----------------------------------------------------------+"
