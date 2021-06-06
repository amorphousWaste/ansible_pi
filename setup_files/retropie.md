# RetroPie #

## Installation ##
[RetroPie Installation Instructions](https://retropie.org.uk/docs/Manual-Installation/)

## Running RetroPie ##
From cli:
```bash
emulationstation
```

## Mounting the RetroPie Data Drive ##
Lookup the drive location:
```bash
sudo lsblk -o UUID,NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,MODEL
```
Mount the drive replacing `/dev/sda1` with the real location:
```bash
sudo mount -t ext4 /dev/sda1 /media/picadeData/
```

## RetroPie (Options) ##
`/opt/retropie/configs/{system_name}`
GBA BIOS need to be copied to ~/RetroPie/BIOS

## RetroPie Controller Customizations ##
Splashscreens: `/etc/splashscreen.png`

Note: May need to change permissions on master config file:
```bash
cd /opt/retropie/emulators/retroarch/configs/
sudo chmod +rw /opt/retropie/configs/all/
```

## Controller Calibration ##
```bash
cd /opt/retropie/emulators/retroarch/
./retroarch-joyconfig -o /opt/retropie/configs/all/p1.cfg -p 1 -j 0
sudo cat /opt/retropie/configs/all/p*.cfg >> /opt/retropie/configs/all/retroarch.cfg
jstest /dev/input/js0
```

## Batch Zip Extraction (For ROM Packs) ##
-   Go to the extraction directory:
```bash
cd ~/Downloads/extract/
```
-   Unzip the pack:
```bash
7z x "PackName.ext"
```
-   Go to uncompressed folder:
```bash
cd "PackName"/
```
-   Extract only known good ROMs (contain "[!]"):
```bash
7z x "*.7z" *[!]*
```
-   Move zipped ROMs to the trash:
```bash
find ./ -name "*.7z" -exec mv -v {} ~/.local/share/Trash/files/ \;
```
-   Move Japanese ROMs to the trash:
```bash
find ./ -name "*(J)*" -exec mv -v {} ~/.local/share/Trash/files/ \;
```
-   Move ROMs to the relevant ROM folder:
```bash
mv -v * /home/pi/RetroPie/roms/"Emulator"/
```

## Updating EmulationStation ##
```bash
sudo ./retropie_setup.sh
```

## Using 7z ##
```bash
7z x -o OUTPUT/DIR FILE.7z
```

## Using tar ##
```bash
tar -zxvf FILE.tar.gz
```
