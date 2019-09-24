#!/bin/bash

ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' hadoop`

if [ -z "$ip" ]; then
    echo -e "\nDocker container 'hadoop' not running.\n"
    exit 0;
fi

echo -e"\n\nThe Hadoop Docker IP is: " $ip

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e " You can now access to the following Hadoop Web GUI:"
echo -e ""
echo -e " 	Hadoop - NameNode:			        http://$ip:50070"
echo -e " 	Hadoop - DataNode:			        http://$ip:50075"
echo -e "	Hadoop - YARN Node Manager:		    http://$ip:8042"
echo -e " 	Hadoop - YARN Resource Manager:		http://$ip:8088"
echo -e " 	Hadoop - YARN Application History:	http://$ip:8188"
echo -e " 	Hadoop - MapReduce Job History:		http://$ip:19888/jobhistory"
echo -e "--------------------------------------------------------------------------------\n\n"

