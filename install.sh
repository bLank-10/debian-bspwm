#ip a
#wpa_passphrase wifi-name wifi-password | sudo tee /etc/wpa_supplicant.conf
#sudo wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp6s0 -B
#sudo dhclient wlp6s0
#ip a

username=$(id -u -n 1000)

sudo apt update -y && sudo apt upgrade -y

# Bspwm, sxhkd and polybar deps

sudo apt install gcc make libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev  build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y

sudo apt install wget kitty network-manager network-manager-gnome nitrogen picom dmenu pulseaudio nautilus lxappearance papirus-icon-theme xinit -y



#Brave Stable

sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install brave-browser -y


cd /home/$username
#Building bspwm and sxhkd

git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

cd bspwm && make && sudo make install
cd ../sxhkd && make && sudo make install

cd /home/$username


cd debian-bspwm
mkdir -p /home/$username/.config/{bspwm,sxhkd}
cp configs/bspwmrc /home/$username/.config/bspwm/
cp configs/sxhkdrc /home/$username/.config/sxhkd/
sudo chmod u+x /home/$username/.config/bspwm/bspwmrc

cd /home/$username

# Building polybar

git clone --recursive https://github.com/polybar/polybar
cd polybar

mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

cd /home/$username/debian-bspwm

# polybar
mkdir -p /home/$username/.config/polybar
cp configs/polybar/config.ini /home/$username/.config/polybar/
cp configs/polybar/launch.sh /home/$username/.config/polybar/
sudo chmod +x /home/$username/.config/polybar/launch.sh

# fonts
mkdir -p /home/$username/.local/share/fonts
cp fonts/fantasque_sans_mono.ttf /home/$username/.local/share/fonts/
cp fonts/material_design_iconic_font.ttf /home/$username/.local/share/fonts/


# kitty
mkdir -p /home/$username/.config/kitty
cp configs/kitty.conf /home/$username/.config/kitty/
sudo chmod +x /home/$username/.config/kitty/kitty.conf

# startup
cd /home/$username
mkdir .start && cd .start
echo "exec bspwm" > .start.sh

cd /home/$username

# theme
sudo cp -r /home/$username/debian-bspwm/dracula /usr/share/themes/

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt install -f -y
sudo apt update -y

#sudo chmod 777 /home/$username/.config

echo "installation completed......"
echo "use lxappearance to change icon -> papirus-icon-theme  &&  theme -> dracula"
echo "startx ~/.start/start.sh"

