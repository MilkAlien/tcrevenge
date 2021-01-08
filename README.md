# tcrevenge + new scripts
Hacking TrendChip Firmware FG824CD (ADSL modem/router *****v4)

```
## NOT USE WSL/WSL2
git clone https://github.com/MilkAlien/tcrevenge.git
mv /PATH/to/your/sc*.*.*.img /PATH/to/tcrevenge/gpon.img
cd tcrevenge
make
sh ./unpack-img.sh
cd /PATH/to/tcrevenge/squashfs-root
check "repack_squashfs.info" for make first images!
...
```

# Original repo >> https://github.com/vasvir/tcrevenge
