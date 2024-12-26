# docker
docker 的一些配置

如果 docker images 报错
sudo systemctl start docker







docker images
docker rmi centos7_cmake


docker ps

docker ps -a


docker run --name 
# --privileged  指定权限
docker run --privileged -it --name mycontainer centos  /bin/bash


docker exec -it  centos7_cmake /bin/bash


docker restart


docker rm centos7_cmake






# s删除 安装的  依赖
sudo yum remove  libusbx-devel
sudo yum remove  libftdi-devel
sudo yum remove libftdi-devel libusbx-devel 
sudo yum remove libusb-devel 
sudo yum remove libftdi libftdi-devel

sudo yum remove libusbx-devel