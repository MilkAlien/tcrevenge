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
s03=$(binwalk gpon.bin | awk '/Squash/ {print $1;}')
# Extract kernel and rootfs
dd if=gpon.bin of=kernel skip=$s02 count=$s03 bs=1
dd if=gpon.bin of=tclinux.squashfs skip=$s03 bs=1
## Check image original
	mkdir .tmp
	dd if=gpon.bin of=.tmp/gpon.0 skip=608 bs=1
## Unpack kernel & check version
	cp kernel .tmp/
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
read -p "Press any key to resume ..."
sudo unsquashfs tclinux.squashfs
rm -rf gpon.bin.gz gpon.bin gpon.0 tclinux.squashfs .tmp/ 
cd squashfs-root
