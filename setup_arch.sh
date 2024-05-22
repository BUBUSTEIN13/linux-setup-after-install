bash
#!/bin/bash

# Actualizează lista de pachete și upgrade-urile disponibile
sudo pacman -Syu --noconfirm

# Instalează build-essential
sudo pacman -S --noconfirm base-devel


git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
# Instalează Sweet Theme și Candy Icons
yay -S --noconfirm gtk-theme-sweet candy-icons

# Setează tema și icoanele
gsettings set org.cinnamon.desktop.interface gtk-theme 'Sweet'
gsettings set org.cinnamon.desktop.interface icon-theme 'Candy'

# Adaugă layout-ul de tastatură RO-STANDARD
localectl set-x11-keymap ro std

# Instalează Computer și Trash pe desktop
gsettings set org.nemo.desktop computer-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true

# Instalează fonturile Microsoft
yay -S --noconfirm ttf-ms-fonts

# Instalează fonts-awesome și noto-fonts
sudo pacman -S --noconfirm ttf-font-awesome noto-fonts

# Instalează ultimul driver Nvidia 545
sudo pacman -S --noconfirm nvidia

# Instalează Librewolf
yay -S --noconfirm librewolf-bin

# Setează Librewolf ca browser implicit
xdg-settings set default-web-browser librewolf.desktop

# Instalează Discord
yay -S --noconfirm discord

# Instalează Vencord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

# Instalează Spotify
yay -S --noconfirm spotify

# Instalează Spicetify
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh

# Instalează Spicetify Marketplace
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/extras/Themes/install.sh | sh

# Instalează Steam
sudo pacman -S --noconfirm steam

# Instalează IntelliJ IDEA Community
sudo pacman -S --noconfirm intellij-idea-community-edition

# Instalează Oracle VM VirtualBox
sudo pacman -S --noconfirm virtualbox

# Instalează Freetube
yay -S --noconfirm freetube-bin

# Instalează Prism Launcher
yay -S --noconfirm prismlauncher

# Descarcă și instalează JDK-17 Temurin
wget -qO- https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17%2B35/OpenJDK17U-jdk_x64_linux_hotspot_17_35.tar.gz | sudo tar xz -C /opt
sudo ln -sfn /opt/jdk-17.0.2+8 /opt/jdk17
sudo ln -sfn /opt/jdk17/bin/* /usr/bin/

# Descarcă și instalează JDK-21 Temurin
wget -qO- https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.3.0%2B1/OpenJDK21U-jdk_x64_linux_hotspot_21.3.0_1.tar.gz | sudo tar xz -C /opt
sudo ln -sfn /opt/jdk-21.3.0+1 /opt/jdk21
sudo ln -sfn /opt/jdk21/bin/* /usr/bin/

# Instalează GIMP
sudo pacman -S --noconfirm gimp

# Instalează zip
sudo pacman -S --noconfirm zip

echo "Toate pachetele și setările au fost aplicate cu succes!"
echo "Sistemul se va restarta în 20 de secunde..."
sleep 20
sudo reboot

