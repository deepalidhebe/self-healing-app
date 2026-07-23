#!/bin/bash

echo "$(date) - Script executed" >> /home/ec2-user/self-healing-app/monitor.log

if ! /usr/bin/docker ps --format "{{.Names}}" | grep -q "^website$"
then
    echo "$(date) - Website stopped" >> /home/ec2-user/self-healing-app/monitor.log

    /usr/bin/docker start website

    echo "$(date) - Website restarted" >> /home/ec2-user/self-healing-app/monitor.log
fi
