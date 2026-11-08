#!/bin/bash
if [ -z ${PLATFORM} ]; then echo "PLATFORM is not set."; exit; else echo "Platform is '$PLATFORM'"; fi

if [ -z ${CROSS_COMPILE} ]; then echo "CROSS_COMPILE is not set."; exit; else echo "Cross compile is '$CROSS_COMPILE'"; fi

let NPROC=$(nproc)-4

# BUILDING
cd ../busybox

make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE defconfig
sed -i 's/^# CONFIG_STATIC is not set$/CONFIG_STATIC=y/' .config
make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE oldconfig
make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE
make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE CONFIG_PREFIX=../initramfs install

cp ../configs/$PLATFORM/init ../initramfs/.

cd ../initramfs
mkdir etc proc sys dev etc/init.d usr/lib
mkdir home home/root

find . -print0 | cpio --null -o -H newc --owner=0:0 | gzip -9 > ../initramfs.cpio.gz
