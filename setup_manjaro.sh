#!/bin/bash

# Setare variabile
PARU_DIR="/home/abc/paru"

# Actualizare și upgrade sistem
sudo pacman -Syyu --noconfirm

# Schimbare oglinzi pacman pentru Germania, Austria și Olanda
sudo pacman-mirrors --api --country Germany Netherlands Austria --protocol https
sudo pacman-mirrors --fasttrack 5
sudo pacman -Syyu --noconfirm
# Instalare qt5-tools pentru utilitarul qtpaths
sudo pacman -S --noconfirm qt5-tools qt6-tools

# Instalare Paru în /home/abc/
sudo pacman -S --needed --noconfirm base-devel
mkdir -p $PARU_DIR
git clone https://aur.archlinux.org/paru.git $PARU_DIR
cd $PARU_DIR
makepkg -si --noconfirm
cd ~

git clone https://aur.archlinux.org/sweet-cursor-theme-git.git
cd sweet-cursor-theme-git
makepkg -si --noconfirm
cd ~
kcmshell6 kcm_cursortheme --args "Sweet-cursors"

WALLPAPER_PATH="/usr/share/wallpapers/North/"
plasma-apply-wallpaperimage $WALLPAPER_PATH

paru -S --noconfirm ttf-ms-fonts

sudo pacman -S --noconfirm --needed nvidia-settings

paru -S --noconfirm librewolf-bin
xdg-settings set default-web-browser librewolf.desktop

sudo pacman -S --noconfirm gimp zip unzip tar discord steam thunderbird goverlay unrar
sudo pacman -S --noconfirm noto-fonts ttf-font-awesome noto-fonts-extra lutris
sudo pacman -S --noconfirm virtualbox linux610-virtualbox-host-modules virtualbox-guest-iso virtualbox-guest-utils
sudo pacman -S --noconfirm intellij-idea-community-edition
sudo pacman -S firewalld
sudo systemctl enable --now firewalld
paru -S --noconfirm jdk17-temurin jdk21-temurin jdk8-temurin
paru -S --noconfirm spotify freetube
paru -S --noconfirm prismlauncher

sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
# Instalează Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

# Instalează Spicetify Marketplace
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh

echo "Comenzile au fost rulate cu succes!"
# Reboot sistem în 10 de secunde
echo "Sistemul se va reporni în 10 de secunde..."
sleep 10
sudo reboot
