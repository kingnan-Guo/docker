# 基于 Ubuntu 20.04 镜像
FROM ubuntu:20.04

# 设置时区和环境变量
ENV TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive

# 更新并安装必要的依赖
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    cmake \
    libusb-1.0-0-dev \
    libftdi1-dev \
    gdb \
    wget \
    curl \
    unzip \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 STM32 开发工具链 (gcc-arm-none-eabi)
RUN apt-get update && \
    apt-get install -y \
    gcc-arm-none-eabi \
    gdb-multiarch \
    openocd \
    stlink-tools \
    && rm -rf /var/lib/apt/lists/*

# 安装 pip 工具
RUN pip3 install --upgrade pip

# 安装常用的 Python 工具 (例如：可以通过 OpenOCD 控制 STM32)
RUN pip3 install pyserial

# 创建工作目录
WORKDIR /workspace

# 创建挂载目录
VOLUME ["/workspace"]

# 设置默认命令为 bash
CMD ["/bin/bash"]

