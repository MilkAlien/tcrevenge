#!/bin/bash
echo=0
mkdir .tmp
## Unpack
# 'gpon.img' > ../tcrevenge
# Skip superblock & extract img
s01=$(binwalk gpon.img | awk '/gzip/ {print $1;}')
dd if=gpon.img of=.tmp/gpon.bin.gz skip=$s01 bs=1
gunzip .tmp/gpon.bin.gz
# Skip superblock bin
s02=$(binwalk .tmp/gpon.bin | awk '/LZMA/ {print $1;}')
s03=$(binwalk .tmp/gpon.bin | awk '/Squash/ {print $1;}')
# Extract kernel and rootfs
dd if=.tmp/gpon.bin of=.tmp/kernel skip=$s02 count=$s03 bs=1
## Check image original
dd if=.tmp/gpon.bin of=.tmp/gpon.0 skip=608 bs=1
## Unpack kernel & check version
grep -P -a -b -m 1 --only-matching '\x5D\x00\x00' .tmp/kernel | cut -f 1 -d :
pos=$(grep -P -a -b -m 1 --only-matching '\x5D\x00\x00' .tmp/kernel | cut -f 1 -d :)
dd if=.tmp/kernel of=.tmp/piggy.lzma bs=1 skip=$pos
unlzma -c .tmp/piggy.lzma > .tmp/Image
echo
echo -----------------------------------------------------------------
echo
./tcrevenge -c .tmp/gpon.0
echo
echo -----------------------------------------------------------------
echo
strings .tmp/Image | grep 'Linux version'
echo
echo -----------------------------------------------------------------
echo
rm -rf .tmp/
read -p "Press any key to resume ..."

