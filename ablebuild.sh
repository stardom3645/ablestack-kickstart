'''
Copyright (c) 2021 ABLECLOUD Co. Ltd
이 파일은 ablestack ISO image를 생성하는 파일입니다.
최초 작성일 : 2021. 03. 23
'''

#!/bin/bash

red=`tput setaf 1`;
blue=`tput setaf 4`;
green=`tput setaf 2`;
reset=`tput sgr0`;

VER=$1
KS_PATH=$2
PWD_PATH=`pwd -P`

if [ $# -ne 2 ]
then
    echo $red;
    echo -e "\nUsage: $0 [version] [PATH]"
    echo -e "Example: $0 allo /opt/ablestack-kickstart\n"
    echo $reset;
    exit
fi

echo $blue;
echo "#####  make iso 'ablestack_$1-el8.iso' #####"
echo $reset;

# 추가 디렉토리 필요시 추가
mkdir -p $KS_PATH/ks
mkdir -p $KS_PATH/rpms
mkdir -p $KS_PATH/whls
mkdir -p $KS_PATH/docker
mkdir -p $KS_PATH/scripts

yes|cp $PWD_PATH/kickstart/ks/ablestack-ks.cfg $KS_PATH/ks/
yes|cp $PWD_PATH/kickstart/EFI/boot/grub.cfg $KS_PATH/EFI/boot/grub.cfg
yes|cp $PWD_PATH/kickstart/isolinux/isolinux.cfg $KS_PATH/isolinux/isolinux.cfg
yes|cp $PWD_PATH/kickstart/rpms/* $KS_PATH/rpms/
yes|cp $PWD_PATH/kickstart/whls/* $KS_PATH/whls/
yes|cp $PWD_PATH/kickstart/docker/* $KS_PATH/docker/
yes|cp $PWD_PATH/kickstart/scripts/* $KS_PATH/scripts

sed -i "s/^ablestack_ver.*/ablestack_ver=$VER/g" $KS_PATH/ks/ablestack-ks.cfg

mkisofs -o $PWD_PATH/ablestack_$1-el8.iso -b isolinux/isolinux.bin -J -R -l -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -graft-points -r -V "CentOS-8-3-2011-x86_64-dvd" $KS_PATH
