#!/bin/bash

if [ -z ${CROSS_COMPILE} ]; then echo "CROSSCOMPILE is not set."; exit; else echo "Cross compile is '$CROSS_COMPILE'"; fi

#if [ -z ${BOOTABLE_DEVICE} ]; then echo "BOOTABLE_DEVICE is not set."; exit; else echo "Bootable device is '$BOOTABLE_DEVICE'"; fi


# BUILDING GRUB
cd ../grub

./bootstrap

mkdir build
cd build

../configure --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=aarch64-linux-gnu --with-platform=efi TARGET_CC=$CROSS_COMPILE

make -j${nproc}

./grub-mkimage -d grub-core -O arm64-efi -o BOOTAA64.EFI -p /EFI/BOOT part_gpt part_msdos fat ext2 normal configfile linux search search_fs_uuid search_label echo ls cat boot efi_gop acpi lsacpi lsefisystab reboot hexdump

# Setting GRUB in external device

