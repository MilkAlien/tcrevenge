# tcrevenge + new scripts
Hacking TrendChip Firmware FG824CD (ADSL modem/router *****v4)

```
## NOT USE WSL/WSL2
sudo apt install libarchive-zip-perl binwalk squashfs-tools
git clone https://github.com/MilkAlien/tcrevenge.git
mv /PATH/to/sc*.*.*.img /PATH/to/tcrevenge/gpon.img
cd tcrevenge
make
sudo sh ./unpack-img.sh
cd squashfs-root
check "repack_squashfs.info" for make first images!
...
```

# Original repo >> https://github.com/vasvir/tcrevenge
