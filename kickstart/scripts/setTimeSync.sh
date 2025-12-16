#!/bin/bash

RESULT1=$(chronyc sources |grep "*" |wc -l)
RESULT2=$(timedatectl show -p NTPSynchronized --value)

if [ $RESULT1 -eq 0 ] || [ $RESULT2 == "no" ]
then
  systemctl restart chronyd.service
fi
