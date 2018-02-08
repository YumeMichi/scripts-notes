#!/bin/bash

# crontab */1 * * * * /root/network.sh

count=`ping -c 2 qq.com | grep ttl | wc -l`
now=`date "+%Y-%m-%d %H:%M:%S"`
if [ $count == 0 || "$count" == "0"]; then
    echo $now "Network unreachable!" >> /tmp/network.log
    service networking restart
else
    echo $now "Network is OK!" >> /tmp/network.log
fi
