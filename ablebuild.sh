# Copyright (c) 2021 ABLECLOUD Co. Ltd
# 이 파일은 ablestack ISO image를 생성하는 파일입니다.
# 최초 작성일 : 2021. 03. 23

#!/bin/bash

red=`tput setaf 1`;
blue=`tput setaf 4`;
green=`tput setaf 2`;
reset=`tput sgr0`;

VER=$1
ORG_ISO_PATH=$2
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
mkdir -p $ORG_ISO_PATH/ks
mkdir -p $ORG_ISO_PATH/rpms
mkdir -p $ORG_ISO_PATH/whls
mkdir -p $ORG_ISO_PATH/scripts
mkdir -p $ORG_ISO_PATH/settings/cockpit
mkdir -p $ORG_ISO_PATH/settings/images

yes|cp $PWD_PATH/kickstart/ks/ablestack-ks.cfg $ORG_ISO_PATH/ks/
yes|cp $PWD_PATH/kickstart/EFI/BOOT/grub.cfg $ORG_ISO_PATH/EFI/BOOT/grub.cfg
yes|cp $PWD_PATH/kickstart/isolinux/isolinux.cfg $ORG_ISO_PATH/isolinux/isolinux.cfg
yes|cp $PWD_PATH/kickstart/rpms/* $ORG_ISO_PATH/rpms/
yes|cp $PWD_PATH/kickstart/whls/* $ORG_ISO_PATH/whls/
yes|cp $PWD_PATH/kickstart/scripts/* $ORG_ISO_PATH/scripts
yes|cp $PWD_PATH/kickstart/settings/cockpit/* $ORG_ISO_PATH/settings/cockpit/
yes|cp $PWD_PATH/kickstart/settings/images/* $ORG_ISO_PATH/settings/images/

genisoimage -U -r -v -T -J -joliet-long -V "ABLESTACK" -volset "ABLESTACK" -A "ABLESTACK" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -o ./ISO/ABLESTACK-$1-el8.iso $ORG_ISO_PATH
