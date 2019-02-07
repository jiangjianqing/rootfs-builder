#!/bin/sh

busybox_version=busybox-1.23.2
target_rootfs=builded-rootfs

rm -rf $busybox_version
rm -rf $target_rootfs

tar -vxf $busybox_version.tar.bz2 
cp config_ok $busybox_version/.config

cd $busybox_version
make CROSS_COMPILE=arm-linux-  CONFIG_PREFIX=../$target_rootfs install
cd ..

sh ./build-rootfs.sh  $target_rootfs

rm -rf $busybox_version
