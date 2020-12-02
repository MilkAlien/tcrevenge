#!/bin/bash
echo=0
## размер header2
## Unpack
# 'gpon.img' > ../tcrevenge
# Skip superblock
s01=$(binwalk gpon.img | awk '/gzip/ {print $1;}')
dd if=gpon.img of=gpon.bin.gz skip=$s01 bs=1
gunzip gpon.bin.gz
## Extract kernel and rootfs
s02=$(binwalk gpon.bin | awk '/LZMA/ {print $1;}')
s03=$(binwalk gpon.bin | awk '/Squash/ {print $1;}')
dd if=gpon.bin of=kernel skip=$s02 count=$s03 bs=1
dd if=gpon.bin of=tclinux.squashfs skip=$s03 bs=1
## Check image original
dd if=gpon.bin of=gpon.0 skip=608 bs=1
./tcrevenge -c gpon.0
binwalk kernel
read -p "Press any key to resume ..."
sudo unsquashfs tclinux.squashfs
cd squashfs-root
