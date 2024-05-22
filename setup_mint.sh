bash
#!/bin/bash

# Actualizează lista de pachete și upgrade-urile disponibile
sudo apt update && sudo apt upgrade -y

# Instalează build-essential
sudo apt install build-essential -y

# Instalează Sweet Theme și Candy Icons
sudo apt install -y git
git clone https://github.com/EliverLara/Sweet.git
mkdir -p ~/.themes
cp -r Sweet ~/.themes/

git clone https://github.com/EliverLara/candy-icons.git
mkdir -p ~/.icons
cp -r candy-icons ~/.icons/

# Setează tema și icoanele
gsettings set org.cinnamon.desktop.interface gtk-theme 'Sweet'
gsettings set org.cinnamon.desktop.interface icon-theme 'Candy'

# Adaugă layout-ul de tastatură RO-STANDARD
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ro+std')]"

# Adaugă Computer și Trash pe desktop
gsettings set org.nemo.desktop computer-icon-visible true
gsettings set org.nemo.desktop trash-icon-visible true

# Instalează fonturile Microsoft
sudo apt install ttf-mscorefonts-installer -y

# Instalează fonts-awesome și noto-fonts
sudo apt install fonts-font-awesome fonts-noto -y

# Instalează ultimul driver Nvidia 545
sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install nvidia-driver-545 -y

# Instalează Librewolf
sudo apt install -y wget gnupg2
wget -qO - https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
echo "deb [signed-by=/usr/share/keyrings/librewolf.gpg] https://deb.librewolf.net $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/librewolf.list
sudo apt update
sudo apt install librewolf -y

# Setează Librewolf ca browser implicit
xdg-settings set default-web-browser librewolf.desktop

# Instalează Discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ./discord.deb -y
rm discord.deb

# Instalează Vencord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

# Instalează Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y

# Instalează Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

# Instalează Spicetify Marketplace
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh

# Instalează Steam
sudo apt install steam -y

# Instalează IntelliJ IDEA Community
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:mmk2410/intellij-idea -y
sudo apt update
sudo apt install intellij-idea-community -y

# Instalează Oracle VM VirtualBox
sudo apt install virtualbox -y

# Instalează Freetube
wget -O freetube.deb "https://github.com/FreeTubeApp/FreeTube/releases/download/v0.15.1/FreeTube_0.15.1_amd64.deb"
sudo apt install ./freetube.deb -y
rm freetube.deb

# Instalează Prism Launcher
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt update
sudo apt install prismlauncher -y

# Instalează JDK-17 Temurin și JDK-21 Temurin de la Adoptium
sudo apt install -y wget apt-transport-https
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo apt-key add -
echo "deb https://packages.adoptium.net/artifactory/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install temurin-17-jdk temurin-21-jdk -y

# Instalează GIMP
sudo apt install gimp -y

# Instalează zip
sudo apt install zip -y

# Afișează mesajul de finalizare și reboot cu delay de 20 de secunde
echo "Toate pachetele și setările au fost aplicate cu succes!"
echo "Sistemul se va restarta în 20 de secunde..."
sleep 20
sudo reboot

