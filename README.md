# ablestack-kickstart

## ablestack-kickstart 사전 준비 사항

| build server (VM)   |  CentOS8.3 (server with GUI 설치)   | 
|:---|:---|
| CentOS ISO image  |  CentOS-8.3.2011-x86_64-dvd1.iso   | 

## ablestack-kickstart 빌드 서버 구성
1. CentOS-8.3.2011-x86_64-dvd1.iso 이미지 마운트 및 복사
```
]# mount -t iso9660 -o loop CentOS-8.3.2011-x86_64-dvd1.iso /root/kickstart/tmp/
]# cp -pRf tmp/ ablestack-allo/
]# umount tmp/
```
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-1.png?raw=true)

2. github kickstart repository clone
> git clone https://github.com/ablecloud-team/ablestack-kickstart.git

![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-2.png?raw=true)
#### clone이 완료되면 ablestack-kickstart 디렉터리가 생성됩니다. ablestack-kickstart 구조는 아래와 같습니다.
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-3.png?raw=true)

3. kickstart 디렉터리 및 파일
#### ablestack-kickstart 하위 kickstart 디렉터리 구조는 아래와 같습니다.
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-4.png?raw=true)
> EFI/BOOT/grub.cfg 파일은 EFI 부팅에 사용되는 파일입니다.

> isolinux/isolinux.cfg 파일은 legacy 부팅에 사용되는 파일입니다.

> ks/ablestack-ks.cfg 파일은 kickstart 설치가 진행될 때 실제 실행되는 스크립트 파일입니다.

4. 설치 rpm 및 script 파일
#### kickstart에서 설치 되어야 할 rpm 및 script 파일을 각각 위치에 복사합니다.
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-5.png?raw=true)
#### rpms, scripts 디렉터리 이외 다른 용도의 디렉터리를 생성했다면 (예를들어, docker image 등) ablebuild.sh 스크립트 파일에 추가 해야합니다.
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-8.png?raw=true)

5. 모든 사전 구성이 끝나면 ablebuild.sh 스크립트를 실행하여 ISO 파일을 생성할 수 있습니다.
#### ablebuild.sh 스크립트는 버전, ISO 디렉터리의 절대 경로를 입력 받아 실행됩니다. (ISO 디렉터리의 절대 경로는 이 가이드에서 /root/kickstart/ablestack-allo 에 해당합니다.)
![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-6.png?raw=true)

6. 스크립트가 정상 실행되면 ablestack_{version}-el8.iso 파일이 생성됩니다.

![kickstart_image](https://github.com/ablecloud-team/ablecloud-homepage/blob/master/wiki-img/kickstart-readme-7.png?raw=true)
