#!/bin/bash

sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS*
sed -i 's/#baseurl=http:\/\/mirror\.centos\.org/baseurl=http:\/\/mirror.ablecloud.io/' /etc/yum.repos.d/CentOS*
mkdir /etc/yum.repos.d/unused
mv /etc/yum.repos.d/CentOS-Linux-Media* /etc/yum.repos.d/unused/
mv /etc/yum.repos.d/CentOS-Linux-FastTrack.repo /etc/yum.repos.d/unused/
