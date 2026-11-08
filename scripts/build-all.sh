#!/bin/bash

if [ -z ${PLATFORM} ]; then echo "PLATFORM is not set."; exit; else echo "Platform is '$PLATFORM'"; fi

if [ -z ${CROSS_COMPILE} ]; then echo "CROSS_COMPILE is not set."; exit; else echo "Cross compile is '$CROSS_COMPILE'"; fi

set -e

cd $(dirname $(realpath $0))

# UPDATING SUBMODULES
git -C .. submodule update --init --remote

# BUILDING
./build-grub.sh
./build-kernel.sh
./build-busybox.sh

# CREATING BOOTABLE USB (only if a device is given)
if [ -n "$1" ]; then ./create-bootable.sh $1; fi
