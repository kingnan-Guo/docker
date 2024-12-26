#centOS 7 作为基础镜像
FROM centos7_cmake:v0.0.1 

# 设置环境变量，防止在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新并安装必要的工具
RUN yum -y groupinstall "Development Tools" && \
    yum -y install \
    wget \
    git \
    cmake \
    python3 \
    python3-pip \
    unzip \
    libusb-devel \
    openocd \
    stlink-tools \
    && yum clean all

# 安装 arm-none-eabi-gcc 工具链
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-toolchain/gnu-ae/12-2020-q4-major/arm-none-eabi-gcc-12-2020-q4-major-x86_64-linux.tar.bz2 && \
    tar -xvjf arm-none-eabi-gcc-12-2020-q4-major-x86_64-linux.tar.bz2 && \
    mv arm-none-eabi-gcc-12-2020-q4-major /opt/arm-none-eabi-gcc && \
    rm arm-none-eabi-gcc-12-2020-q4-major-x86_64-linux.tar.bz2

# 设置交叉编译工具链的路径
ENV PATH="/opt/arm-none-eabi-gcc/bin:${PATH}"

# 默认工作目录
WORKDIR /workspace

# 默认启动命令
CMD ["/bin/bash"]
# vi ~/.bashrc

# /opt/packageManager/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin/
# source ~/.bashrc

# vi ~/.bash_profile
# source ~/.bash_profile
# openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program stm32F103C8T6Project.bin 0x08000000 verify reset exit"

