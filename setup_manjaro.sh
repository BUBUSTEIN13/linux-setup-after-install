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
sudo pacman -S --noconfirm qt5-tools

# Instalare Paru în /home/abc/
sudo pacman -S --needed --noconfirm base-devel
mkdir -p $PARU_DIR
git clone https://aur.archlinux.org/paru.git $PARU_DIR
cd $PARU_DIR
makepkg -si --noconfirm
cd ~

# Instalare Sweet Cursors de la URL specificat și setare ca default
git clone https://aur.archlinux.org/sweet-theme-nova-git.git
cd sweet-theme-nova-git
makepkg -si --noconfirm
cd ~
kcmshell6 kcm_cursortheme --args "Sweet-cursors"

# Setare wallpaper Darkest Hour
WALLPAPER_PATH="/usr/share/wallpapers/DarkestHour/"
plasma-apply-wallpaperimage $WALLPAPER_PATH

# Instalare fonturi Microsoft, Font-Awesome și Noto Fonts
paru -S --noconfirm ttf-ms-fonts ttf-font-awesome noto-fonts

# Instalare driver Nvidia
# sudo mhwd -a pci nonfree 0300
sudo pacman -S --noconfirm --needed nvidia-settings
# Instalare Librewolf și setare ca default
paru -S --noconfirm librewolf-bin
xdg-settings set default-web-browser librewolf.desktop

paru -S --noconfirm jdk17-temurin jdk21-temurin jdk8-temurin gimp zip unzip tar

# Instalare Discord, Vencord, Spotify, Spicetify, Steam, IntelliJ IDEA Community, Virtual Box, FreeTube, PrismLauncher, JDK 17 Temurin și JDK 21 Temurin, GIMP, ZIP
paru -S --noconfirm discord spotify steam intellij-idea-community-edition virtualbox freetube-bin 
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
