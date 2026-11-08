#!/bin/bash

if [ -z $1 ]; then echo "Usage: $0 /dev/sdX"; exit; fi

if [ -z ${PLATFORM} ]; then echo "PLATFORM is not set."; exit; else echo "Platform is '$PLATFORM'"; fi

DEVICE=$1
ROOT=$(dirname $(realpath $0))/..
MNT=$(mktemp -d)

# FORMAT
sudo umount ${DEVICE}* 2>/dev/null
sudo parted -s $DEVICE mklabel msdos
sudo parted -s -a optimal $DEVICE mkpart primary fat32 1MiB 1025MiB
sudo mkfs.fat -F 32 ${DEVICE}1

# COPY BOOT FILES
sudo mount ${DEVICE}1 $MNT
sudo mkdir -p $MNT/EFI/BOOT

sudo cp $ROOT/grub/build/BOOTAA64.EFI                        $MNT/EFI/BOOT/
sudo cp $ROOT/configs/$PLATFORM/grub.cfg                     $MNT/EFI/BOOT/
sudo cp $ROOT/kernel/arch/arm64/boot/Image                   $MNT/EFI/BOOT/
sudo cp $ROOT/initramfs.cpio.gz                              $MNT/EFI/BOOT/
sudo cp $ROOT/kernel/arch/arm64/boot/dts/qcom/kalambo-crd.dtb $MNT/EFI/BOOT/

ls -l $MNT/EFI/BOOT

sudo umount $MNT
rmdir $MNT
