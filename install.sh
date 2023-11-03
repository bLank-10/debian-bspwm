
username=$(id -u -n 1000)

sudo apt update && sudo apt upgrade -y

# Bspwm, sxhkd and polybar deps
sudo apt install build-essential gcc g++ make libxrandr-dev libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev libpulse-dev libnl-genl-3-dev -y
sudo apt install wget kitty nitrogen picom scrot zsh rofi network-manager network-manager-gnome pulseaudio nautilus lxappearance papirus-icon-theme blueman xinit -y


#Brave Stable
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y


#Building bspwm and sxhkd
cd /home/$username
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
cd bspwm && make && sudo make install
cd ../sxhkd && make && sudo make install

# bspwm and sxhkd configs
cd /home/$username/debian-bspwm
mkdir -p /home/$username/.config/{bspwm,sxhkd}
cp configs/bspwmrc /home/$username/.config/bspwm/
cp configs/sxhkdrc /home/$username/.config/sxhkd/
sudo chmod u+x /home/$username/.config/bspwm/bspwmrc


# Building polybar
cd /home/$username
git clone --recursive https://github.com/polybar/polybar
cd polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# polybar configs
cd /home/$username/debian-bspwm
mkdir -p /home/$username/.config/polybar
cp configs/polybar/config.ini /home/$username/.config/polybar/
cp configs/polybar/launch.sh /home/$username/.config/polybar/
sudo chmod +x /home/$username/.config/polybar/launch.sh


# rofi
cp -r /home/$username/debian-bspwm/configs/rofi /home/$username/.config/

# screenshot
mkdir -p /home/$username/Pictures

# fonts & bin
mkdir -p /home/$username/.local/share
cp -r fonts /home/$username/.local/share/
cp -r bin /home/$username/.local/
wget https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf
sudo cp NotoColorEmoji.ttf /usr/share/fonts/


# theme
sudo cp -r /home/$username/debian-bspwm/dracula /usr/share/themes/


# kitty & terminal
mkdir -p /home/$username/.config/kitty
cp configs/kitty.conf /home/$username/.config/kitty/
sudo chmod +x /home/$username/.config/kitty/kitty.conf
sudo cp /home/$username/debian-bspwm/configs/nanorc /etc/


# vscode
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb


# chrome
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# sudo apt install -f -y
# sudo apt update

# protonvpn
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb
echo "c409c819eed60985273e94e575fd5dfd8dd34baef3764fc7356b0f23e25a372c  protonvpn-stable-release_1.0.3_all.deb" | sha256sum --check -
sudo dpkg -i protonvpn-stable-release_1.0.3_all.deb
sudo apt update
sudo apt install protonvpn -y


# touchpad
sudo cp /home/$username/debian-bspwm/configs/40-libinput.conf /etc/X11/xorg.conf.d/

# never sleep
sudo cp /home/$username/debian-bspwm/configs/logind.conf /etc/systemd/

# startx
echo "dbus-launch bspwm" >> .xinitrc


# sreenlock (slock)
git clone git://git.suckless.org/slock
cd slock
sudo make clean install


printf "\e[1;32mFor zsh config run the below command .\e[0m\n\n"

cat <<'END_CAT'
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
END_CAT

printf "\n\n\e[1;32mDone! Now if you didn't encountered any error you can reboot.\e[0m\n"
