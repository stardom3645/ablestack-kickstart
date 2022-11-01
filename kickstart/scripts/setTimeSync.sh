#!/bin/bash

RESULT=$(chronyc sources |grep "*" |wc -l)
if [ $RESULT -eq 0 ]
then
  systemctl restart chronyd.service
fi
