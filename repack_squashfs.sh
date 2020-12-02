
--------------------------------------------------------

# Clone&make tcrevenge
git clone https://github.com/MilkAlien/tcrevenge.git
cd tcrevenge
make

## Unpack
# 'gpon.img' > ../tcrevenge
# Skip superblock
dd if=gpon.img of=gpon.gz skip=192 bs=1
gunzip gpon.gz

## Check image original
binwalk gpon
dd if=gpon of=test.0 skip=608 bs=1
./tcrevenge -c test.0
binwalk test.0

## Extract kernel and rootfs
binwalk gpon
dd if=gpon of=kernel skip=864 count=`binwalk gpon | awk '/Squash/ {print $1 - 864;}'` bs=1
dd if=gpon of=gpon.squashfs skip=2482156 bs=1
sudo unsquashfs gpon.squashfs

## Edit rootfs

## Make squashfs
rm -rf gpon.squashfs
mksquashfs squashfs-root/ gpon.squashfs -comp lzma -b 131072 -nopad
./tcrevenge -k kernel -s gpon.squashfs -o header -sp
cat header kernel gpon.squashfs > firmware.0

## HEX 'header2'
# 'CRC32 firmware.0'	>	16>10	>	0xC0	//08450127	16>10	138740007
# 'size firmware.0'					>	0x20	//19158710
# 'exact time of creation rootfs'	>	0x100
cat header2 header kernel gpon.squashfs > firmware.bin
gzip firmware.bin -n

## HEX 'header3'
# SHA256 'firmware.bin.gz'			>	0x80	//3AE2E358859AA914296222030463EFD2D1B61571F4FF15327130BCD44AB85B61
cat header3 firmware.bin.gz > gpon.img

--------------------------------------------------------

## Распаковка и проверка версии zImage {
	grep -P -a -b -m 1 --only-matching '\x5D\x00\x00' kernel | cut -f 1 -d :
	pos=$(grep -P -a -b -m 1 --only-matching '\x5D\x00\x00' kernel | cut -f 1 -d :)
	dd if=kernel of=piggy.lzma bs=1 skip=$pos
	unlzma -c piggy.lzma > Image
	strings Image | grep 'Linux version'
}