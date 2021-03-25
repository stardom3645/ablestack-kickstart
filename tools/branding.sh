#!/bin/bash

red=`tput setaf 1`;
blue=`tput setaf 4`;
green=`tput setaf 2`;
reset=`tput sgr0`;

KS_PATH=$1
PWD_PATH=`pwd -P`

if [ $# -ne 1 ]
then
    echo $red;
    echo -e "\nUsage: $0 [PATH]"
    echo -e "Example: $0 /root/kickstart/ablestack-allo\n"
    echo $reset;
    exit
fi

# product.img 파일 생성
find $PWD_PATH/product | cpio -c -o | gzip -9cv > $PWD_PATH/product.img

# product.img 파일 복사
\cp -f $PWD_PATH/product.img $KS_PATH/images/

