
# debian-bspwm

Use the following iso: https://www.debian.org/download 

### Change To Testing
```bash
sudo nano /etc/apt/sources.list
```
Replace with this
```bash
deb http://deb.debian.org/debian/ testing main non-free-firmware
deb-src http://deb.debian.org/debian/ testing main non-free-firmware

deb http://security.debian.org/debian-security testing-security main non-free-firmware
deb-src http://security.debian.org/debian-security testing-security main non-free-firmware

deb http://deb.debian.org/debian/ testing-updates main non-free-firmware
deb-src http://deb.debian.org/debian/ testing-updates main non-free-firmware
```
Now Run
```bash
sudo apt-get update
sudo apt update
sudo apt upgrade
sudo apt full-upgrade
sudo apt dist-upgrade
```
Then Reboot

## Wifi setup

```bash
sudo nano /etc/network/interfaces
```
Then comment all 

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

use lxappearance to change icon -> papirus-dark & theme -> dracula

### For virtual box resolution

```bash
cvt 1920 1080 60
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 "1920x1080_60.00"
xrandr --output Virtual1 --primary --mode "1920x1080_60.00" --pos 0x0 --rotate normal
```
