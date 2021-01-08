#!/bin/bash
echo=0
mv *.img gpon.img
# s01=$(binwalk gpon.img | awk '/gzip/ {print $1;}')
# s02=$(binwalk gpon.img | awk '/gzip/ {print $2;}' | awk -F"x" '{print $2;}')
# head -c$s01 gpon.img > header3
binwalk -Me gpon.img
# cd _*
# s03=$(binwalk $s02 | awk '/LZMA/ {print $1;}')
# s04=$(binwalk $s02 | awk '/LZMA/ {print $2;}' | awk -F"x" '{print $2;}')
# head -c608 $s02  > ../header2
# cd _*
mv _*/_*/squashfs-root ./squashfs-root
cd squashfs-root
rm -rf ../_*
