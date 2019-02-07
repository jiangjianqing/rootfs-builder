#!/bin/sh

if [ $# != 1 ] ; then
echo "USAGE: target dir which will be used as rootfs"
echo " e.g.: \n\t $0 target-rootfs"
exit 1;
fi 
parent_dir=$(pwd)
prefix_dir=$parent_dir/qt-arm-lib
libc_dir="/opt/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/libc"
source_dir=$parent_dir/rootfs-base
#dest_dir="./rootfs-target"
dest_dir=$parent_dir/$1
#不覆盖目标目录的文件
#awk 'BEGIN { cmd="cp -ri $source/* $dest/"; print "n" |cmd; }'
#-s 可
#cp -rf  $libc_dir/* $dest_dir/ 
#cp -rf  mini-glic/* $dest_dir/ 
sudo cp -rf  $source_dir/* $dest_dir/

#mkfs.jffs2 -n  -s 2048  -e 128KiB  -d $dest_dir  -o $dest_dir.jffs2
#嵌入式linux开发手册  P360  “-n”表示不要在每个擦除块上都加上清除标志 "-s 512"指明一页大小为512字节，"-e 16KiB"指明一个擦除块大小为16KB，"-d"表示根目录文件系统目录
mkfs.jffs2 -n  -s 512  -e 16KiB  -d $dest_dir  -o $dest_dir.jffs2


#gcc_lib_dir="/opt/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/lib"
#rootfs_dir="rootfs"
#rm -rf $rootfs_dir
#mkdir $rootfs_dir
#cp -rf -s $gcc_lib_dir $rootfs_dir/      #拷贝软连接，只能用于nfs下的rootfs
#cp -rf -L $gcc_lib_dir $rootfs_dir/       #将文件都复制到指定目录  ,dereference!!!链接文件将会被目标文件代替
