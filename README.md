# docker
docker 的一些配置

# 在 ubuntu arm 上 搭建 raspberry pi 的 docker 环境

参考文档： https://www.raspberrypi.com/documentation/computers/linux_kernel.html#kernel

root@71596e1a1e52:/# uname -r
6.8.0-52-generic
root@71596e1a1e52:/# uname -a
Linux 71596e1a1e52 6.8.0-52-generic #53-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 10 23:39:43 UTC 2025 aarch64 aarch64 aarch64 GNU/Linux
root@71596e1a1e52:/# uname -m
aarch64


连不上 ubuntu 虚拟机的 ssh
<!-- sudo apt-get install openssh-server -->

sudo systemctl restart ssh
sudo systemctl status ssh


make mrproper



apt update
apt install device-tree-compiler
apt install libncurses5-dev libssl-dev bc bison flex libelf-dev


make distclean
make clean

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- clean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- distclean




find -name *_defconfig


# 64-bit
    如果你正在开发一个针对 Raspberry Pi 4 的 64 位应用，你将使用 aarch64-linux-gnu-gcc


    make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- clean
    make ARCH=arm CROSS_COMPILE=aarch64-linux-gnu- distclean


    cd linux
    KERNEL=kernel8
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2711_defconfig
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- zImage modules dtbs -j$(nproc) 

    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs -j$(nproc) 


    sudo env PATH=$PATH make -j12 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=mnt/root modules_install

# 32-bit
    如果你正在开发一个针对 Raspberry Pi 3 的 32 位应用，你将使用 arm-linux-gnueabihf-gcc


    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- clean
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- distclean


    cd linux
    KERNEL=kernel7
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
    make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs -j$(nproc)


    # 执行下面的命令，安装内核及模块
    sudo env PATH=$PATH make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=mnt/ext4 modules_install
    


cp arch/arm/boot/dts/broadcom/*.dtb /opt/TEMP/fat32/

sudo cp mnt/boot/$KERNEL.img mnt/boot/$KERNEL-backup.img
sudo cp arch/arm64/boot/Image mnt/boot/$KERNEL.img
sudo cp arch/arm64/boot/dts/broadcom/*.dtb mnt/boot/
sudo cp arch/arm64/boot/dts/overlays/*.dtb* mnt/boot/overlays/
sudo cp arch/arm64/boot/dts/overlays/README mnt/boot/overlays/
sudo umount mnt/boot
sudo umount mnt/root






# 给 容器赋值 权限
docker run -it --rm --name ubuntu_arm64_raspberry_kernel_container \
  --device /dev/bus/usb:/dev/bus/usb \
  --privileged \
  ubuntu_arm64_raspberry_kernel:v0.0.1 /bin/bash

ubuntu_arm_cmake
docker run -it --rm --name ubuntu_arm_cmake_uboot_container \
  --device /dev/bus/usb:/dev/bus/usb \
  --privileged \
  ubuntu_arm_cmake_uboot:v0.0.1 /bin/bash


lsblk

# 挂载 sd 卡
 mount /dev/sdb1 /mnt/boot
 mount /dev/sdb2 /mnt/root


env PATH=$PATH make -j12 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=/mnt/root modules_install


cp mnt/boot/$KERNEL.img /mnt/boot/$KERNEL-backup.img
cp arch/arm64/boot/Image /mnt/boot/$KERNEL.img
cp arch/arm64/boot/dts/broadcom/*.dtb /mnt/boot/
cp arch/arm64/boot/dts/overlays/*.dtb* /mnt/boot/overlays/
cp arch/arm64/boot/dts/overlays/README /mnt/boot/overlays/
umount /mnt/boot
umount /mnt/root


