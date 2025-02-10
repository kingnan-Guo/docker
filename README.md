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
make install





cat /etc/lsb-release

uname -a

























# =======================================================



# Centos7 stm32 编译环境 搭建环境

搭建 docker 环境
```markdown
参考： https://blog.csdn.net/weixin_56781779/article/details/132258636

如果系统上已安装旧版本的 Docker，请先卸载：
    yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-selinux \
        docker-engine-selinux \
        docker-engine \
        docker-ce








安装依赖工具来支持 Docker 仓库和软件包管理：
    yum install -y yum-utils device-mapper-persistent-data  lvm2 --skip-broken



使用以下命令添加 Docker 官方仓库：
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

添加代理
# 设置docker镜像源
    yum-config-manager \
    --add-repo \
    https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
    sed -i 's/download.docker.com/mirrors.aliyun.com\/docker-ce/g' /etc/yum.repos.d/docker-ce.repo
    
    yum makecache fast


安装
yum install -y docker-ce



# 启动docker前，一定要关闭防火墙后！！
    systemctl stop firewalld # 关闭

    systemctl disable firewalld # 禁止开机启动防火墙


启动和启用 Docker 服务
    sudo systemctl start docker
    sudo systemctl enable docker


如果 docker images 报错
sudo systemctl start docker

```





# 下载镜像
```markdown

    地址 https://hub.docker.com/r/kingnan/centos7_stm32_build_burn

    命令  docker pull kingnan/centos7_stm32_build_burn


```





# 安装 cmake

```markdown

下载 gcc

    yum install -y gcc gcc-c++ make automake

    yum install -y wget

下载 cmake
    wget https://cmake.org/files/v3.6/cmake-3.6.2.tar.gz
    https://cmake.org/download/ 

./bootstrap && make -j4 && sudo make install


```



# 交叉编译工具链安装 

```markdown

https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads 中找到
arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz

配置 环境变量
    vi ~/.bashrc
    export PATH=$PATH:/opt/packageManager/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/
重启 环境变量  source ~/.bashrc


```

# 安装 git
yum  install  git


# openocd  安装 

```markdown
https://sourceforge.net/projects/openocd/files/latest/download  下载  openocd  解压

先安装
参考文章 ： https://www.cnblogs.com/zl-yang/p/9113412.html 
    sudo yum install epel-release
    ////////////  sudo yum install libusbx-devel  安装这个会导致 stlink 报错
    sudo yum install libftdi-devel libusbx-devel
最后安装
    ./configure --enable-ftdi --enable-openjtag
    make
    make install

```


# 安装 stlink

```markdown

stlink 需要依赖 libusb v1.0.21    https://github.com/libusb/libusb/releases/tag/v1.0.21
libusb v1.0.22 也可以

下载 stlink  https://github.com/stlink-org/stlink/releases 1.6.0 

使用  cmake 编译
    mkdir build
    cd ./build
    cmake ../
    make
    make install 

缺少库需要安装
    sudo yum install systemd-devel

安装完 配置环境变量  
    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

测试是否安装成功
    st-util --version
    st-info --version
    st-info --probe      打印 连接的设备


```


# 烧录程序

首先启动
```markdown
lsusb //查看当前哪些 设备 连接
lsusb | grep STMicroelectronics  //查看当前哪些 设备 连接


sudo chmod -R a+rw /dev/bus/usb // 使用以下命令，为所有用户添加对 /dev/bus/usb 设备目录的写权限



  
ls -l /dev/bus/usb // 打印权限  drwxrwxrwx 2 root root 120 Dec 17 23:03 002

ls -l /var/run/docker.sock // 查看 Docker Socket 文件的权限：

  
sudo usermod -aG docker $USER // 先给 docker 赋权限

newgrp docker // 执行完此命令后，您需要退出当前会话并重新登录，以使更改生效。或者可以运行以下命令以立即生效：


sudo docker run -it --rm --name centos7-container \
  --device /dev/bus/usb:/dev/bus/usb \
  --privileged \
  --group-add docker \
  centos7_stm32_build_burn:v0.0.2





st-info --probe // 打印 连接的设备 

```



```markdown
stm32 下 cmake-build-debug
cmake ../
make

打包完成后 执行 烧录

openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program stm32F103C8T6Project.elf verify reset exit"
  
  
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program stm32F103C8T6Project.hex verify reset exit"


openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program stm32F103C8T6Project.bin 0x08000000 verify reset exit"



```
