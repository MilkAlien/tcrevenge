# tcrevenge + new scripts
Hacking TrendChip Firmware FG824CD (ADSL modem/router *****v4)

```
## NOT USE WSL/WSL2
sudo apt install libarchive-zip-perl binwalk squashfs-tools
git clone https://github.com/MilkAlien/tcrevenge.git
cd tcrevenge
make
## mv /PATH/to/*.img /PATH/to/tcrevenge/gpon.img
sudo sh ./unpack-img.sh
## Edit squashfs-root
## mv /PATH/to/tcrevenge/kernel(***)/kernel > /PATH/to/tcrevenge/kernel
check "repack_squashfs.info" for make new images!
...
```

# Original repo >> https://github.com/vasvir/tcrevenge
