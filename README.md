
# debian-bspwm

Use the following iso: debian-testing-amd64-netinst.iso
https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/

## Wifi setup

use ip a to find your wlan interface

```bash
wpa_passphrase wifi-name wifi-password | sudo tee /etc/wpa_supplicant.conf
sudo wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp6s0 -B
sudo dhclient wlp6s0
```

change from wpa supplicant to nmtui
```bash
sudo apt install network-manager network-manager-gnome
sudo reboot
```
Now use nmtui to connect to wifi


## Installation

```bash
sudo apt install git
git clone https://github.com/bLank-10/debian-bspwm
cd debian-bspwm
sudo chmod +x install.sh
./install
```

## After installation

use lxappearance to change icon -> papirus-icon-theme & theme -> dracula
### For virtual box resolution

```bash
cvt 1920 1080 60
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 "1920x1080_60.00"
xrandr --output Virtual1 --primary --mode "1920x1080_60.00" --pos 0x0 --rotate normal
```