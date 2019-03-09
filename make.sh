#!/bin/bash
#必须使用/bin/bash ,因为后面的[[ $1 =~ /$ ]]是bash的命令

if [ $# != 1 ] ; then
echo "USAGE: ./make.sh [board]"
echo " e.g.: \n\t $0 tq210"
exit 1;
fi 

target_board=$1

if [[ $target_board =~ /$ ]]; then 
    target_board=${target_board%?}  #去掉最后一个/
    echo 'yes'; 
    echo $target_board; 
else 
    echo "no"; 
fi 

parent_dir=$(pwd)
busybox_version=1.23.2      #2019.03.09 1.23.2是能够支持jz2440的最高版本
#target_rootfs=./builded/$1-rootfs
target_dir=$parent_dir/$target_board
target_rootfs=$target_dir/rootfs-$busybox_version
target_busybox_dir=$target_dir/busybox
target_busybox_tar_file=$target_busybox_dir/busybox-${busybox_version}.tar.bz2
target_busybox_source_dir=$target_busybox_dir/tmp_busybox_source
target_busybox_source_dir_with_version=$target_busybox_source_dir/busybox-${busybox_version}

rm -rf $target_busybox_dir
rm -rf $target_rootfs

cp -rf busybox/$busybox_version $target_busybox_dir

#tar -vxf $busybox_version.tar.bz2 

mkdir -p $target_busybox_source_dir

tar -vxf $target_busybox_tar_file -C $target_busybox_source_dir
cp $target_busybox_dir/config_ok $target_busybox_source_dir_with_version/.config

cd $target_busybox_source_dir_with_version
make CROSS_COMPILE=arm-linux-gnueabihf-  CONFIG_PREFIX=$target_rootfs install
cd $parent_dir

#sh ./build-rootfs.sh  $target_rootfs

rm -rf $target_busybox_dir

