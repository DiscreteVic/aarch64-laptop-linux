#!/bin/bash


if [ -z ${PLATFORM} ]; then echo "PLATFORM is not set."; exit; else echo "Platform is '$PLATFORM'"; fi

if [ -z ${CROSS_COMPILE} ]; then echo "CROSS_COMPILE is not set."; exit; else echo "Cross compile is '$CROSS_COMPILE'"; fi

let NPROC=$(nproc)-4

# BUILDING
cd ../kernel

cp ../configs/$PLATFORM/kernel_defconfig arch/arm64/configs/custom_defconfig

make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE custom_defconfig
make -j$NPROC ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE

