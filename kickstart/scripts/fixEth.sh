#!/bin/bash

array_pci=(`lspci |grep -i eth |awk '{print $1}'`)

rm -rf /etc/udev/rules.d/70-persistent-net.rules
rm -rf /etc/sysconfig/network-scripts/ifcfg-*

for index in ${!array_pci[*]}
do
  array_mac=(`find /sys/devices/pci0000* -wholename "*net/*/address" -printf "%h/%f " -exec cat '{}' \; | grep 0000:${array_pci[$index]} | awk '{ print $2 }'`)
  echo -e "SUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{address}==\"${array_mac[@]}\", ATTR{dev_id}==\"0x0\", ATTR{type}==\"1\", KERNEL==\"eth*\", NAME=\"enx$index\"" >> /etc/udev/rules.d/70-persistent-net.rules
  echo -e "NAME=enx$index\nHWADDR=${array_mac[@]}" > /etc/sysconfig/network-scripts/ifcfg-enx$index
done
