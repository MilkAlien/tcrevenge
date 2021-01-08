#!/bin/bash
echo=0
sudo mksquashfs squashfs-root/ gpon.squashfs -comp lzma -b 131072 -nopad
make
./tcrevenge -k kernel -s gpon.squashfs -o header -sp
cat header kernel gpon.squashfs > firmware.0
size=`stat firmware.0 -c %s`
ver=`cat squashfs-root/etc/fw_ver`
crc32=`crc32 firmware.0`
crc32_10=`printf '%d' 0x$crc32`
d0=`date +%a`
d1=`date +%b`
d2=`date +%d`
d3=`date +%T`
d4=`date +%Y`
d5=`echo $d0 $d1 $d2 $d3 $d4`
echo $size $crc32 $crc32_10 $pid $ver $d5 $d6
echo -n 'kernel_rootfs' >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
echo -n $size >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
echo -n $ver >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
echo -n '1002' >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
echo -n $crc32_10 >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
echo $d5 >> header2
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header2
cat header2 header kernel gpon.squashfs > firmware
gzip firmware -n
pid=`cat squashfs-root/etc/pid`
sha256=`sha256sum firmware.gz | awk '{print $1;}'`
sha256_ascii=`printf $sha256 | xxd -ps -r`
echo $pid >> header3
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header3
echo -n $sha256_ascii >> header3
echo -en '\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00''\00' >> header3
cat header3 firmware.gz > $ver.img
