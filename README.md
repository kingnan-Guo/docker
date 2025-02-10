# docker
docker 的一些配置


docker pull ubuntu:latest --platform linux/arm64


# 在 x86_64 上运行 arm64 的镜像
docker run -it --name ubuntu_cmake --platform linux/amd64 ubuntu:latest /bin/bash


docker restart -it --platform linux/amd64 ubuntu_cmake
docker exec -it --platform linux/amd64 ubuntu_cmake /bin/bash
docker exec -it ubuntu_cmake /bin/bash

# 复制 
docker cp cmake-3.31.2.tar.gz eefe4c9d47d5:/home/


apt install openssl
apt install libssl-dev
apt install  wget  git    python3  python3-pip  unzip     openocd   stlink-tools 

<!-- apt install libssl-dev libusb-devel -->

# 安装 cmake
./bootstrap
make
sudo make install





cat /etc/lsb-release

uname -a


