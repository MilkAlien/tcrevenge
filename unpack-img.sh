#!/bin/bash
echo=0
## Unpack
# 'gpon.img' > ../tcrevenge
# Skip superblock & extract img
s01=$(binwalk gpon.img | awk '/gzip/ {print $1;}')
dd if=gpon.img of=gpon.bin.gz skip=$s01 bs=1
gunzip gpon.bin.gz
# Skip superblock bin
s02=$(binwalk gpon.bin | awk '/LZMA/ {print $1;}')
echo $s02
s03=$(binwalk gpon.bin | awk '/Squash/ {print $1;}')
# Extract kernel and rootfs
dd if=gpon.bin of=kernel skip=864 count=`binwalk gpon.bin | awk '/Squash/ {print $1 - 864;}'` bs=1
dd if=gpon.bin of=tclinux.squashfs skip=$s03 bs=1
sudo unsquashfs tclinux.squashfs
rm -rf gpon.bin.gz gpon.bin gpon.0 tclinux.squashfs gpon.img .tmp/ 
cd squashfs-root
