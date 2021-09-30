# Copyright (c) 2021 ABLECLOUD Co. Ltd
# 이 파일은 ablestack ISO image를 생성하는 파일입니다.
# 최초 작성일 : 2021. 03. 23

#!/bin/bash

red=`tput setaf 1`;
blue=`tput setaf 4`;
green=`tput setaf 2`;
reset=`tput sgr0`;

VER=$1

ISO_DIR_PATH=$2

PWD_PATH=`pwd -P`

if [ $# -ne 2 ]
then
    echo $red;
    echo -e "\nUsage: $0 [version] [PATH]"
    echo -e "Example: $0 allo /opt/ablestack-iso\n"
    echo $reset;
    exit
fi

echo $blue;
echo "#####  make iso 'ablestack_$1-el8.iso' #####"
echo $reset;

# 추가 디렉토리 필요시 추가

mkdir -p $ISO_DIR_PATH/ks
mkdir -p $ISO_DIR_PATH/rpms
mkdir -p $ISO_DIR_PATH/whls
mkdir -p $ISO_DIR_PATH/scripts
mkdir -p $ISO_DIR_PATH/settings/images
mkdir -p $ISO_DIR_PATH/settings/ablestack-wall
mkdir -p $ISO_DIR_PATH/settings/ablestack-skydive


yes|cp $PWD_PATH/kickstart/ks/ablestack-ks.cfg $ISO_DIR_PATH/ks/
yes|cp $PWD_PATH/kickstart/EFI/BOOT/grub.cfg $ISO_DIR_PATH/EFI/BOOT/grub.cfg
yes|cp $PWD_PATH/kickstart/EFI/BOOT/BOOT.conf $ISO_DIR_PATH/EFI/BOOT/BOOT.conf
yes|cp $PWD_PATH/kickstart/isolinux/isolinux.cfg $ISO_DIR_PATH/isolinux/isolinux.cfg
yes|cp $PWD_PATH/kickstart/rpms/* $ISO_DIR_PATH/rpms/
yes|cp $PWD_PATH/kickstart/whls/* $ISO_DIR_PATH/whls/
yes|cp $PWD_PATH/kickstart/scripts/* $ISO_DIR_PATH/scripts
yes|cp $PWD_PATH/kickstart/settings/images/* $ISO_DIR_PATH/settings/images/
yes|cp $PWD_PATH/kickstart/settings/ablestack-wall/* $ISO_DIR_PATH/settings/ablestack-wall/
yes|cp $PWD_PATH/kickstart/settings/ablestack-skydive/* $ISO_DIR_PATH/settings/ablestack-skydive/


#mkisofs -o ./ISO/ablestack-$1-el8.iso -b isolinux/isolinux.bin -J -R -l -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -graft-points -r -V "ABLESTACK" $ISO_DIR_PATH

genisoimage -U -r -v -T -J -joliet-long -V "ABLESTACK" -volset "ABLESTACK" -A "ABLESTACK-2.0.0" -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -o ./ISO/ablestack-$1-el8.iso $ISO_DIR_PATH
