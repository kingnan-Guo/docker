# docker
docker 的一些配置




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