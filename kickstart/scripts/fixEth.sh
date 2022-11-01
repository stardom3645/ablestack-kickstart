#!/bin/bash

array_nic=(`ifconfig  |grep ether |awk '{print $2}'`)

for index in ${!array_nic[*]}
do
    echo -e """SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="${array_nic[$index]}", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth$index"""" >> /etc/udev/rules.d/70-persistent-net.rules
done
