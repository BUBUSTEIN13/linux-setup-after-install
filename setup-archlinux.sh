#!/bin/bash

# Verificare dacă scriptul rulează ca root
if [ "$EUID" -ne 0 ]; then 
    echo "Rulează scriptul ca root"
    exit
fi

# Setare variabile
USERNAME="abc"  # Înlocuiește cu numele tău de utilizator
HOSTNAME="arch"  # Înlocuiește cu numele dorit pentru sistem
PARU_DIR="/home/$USERNAME/paru"

# Configurare sistem de bază
echo "Configurare sistem..."
timedatectl set-ntp true
hwclock --systohc

# Configurare pacman
echo "Configurare pacman..."
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/' /etc/pacman.conf
sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
# Adăugare ILoveCandy
sed -i '/^Color/a ILoveCandy' /etc/pacman.conf

# Actualizare sistem
pacman -Syyu --noconfirm

# Instalare pachete sistem de bază
pacman -S --noconfirm \
    iwd \
    openssh \
    smartmontools \
    xdg-utils \
    wpa_supplicant \
    wget \
    curl \
    egl-wayland

# Activare servicii de sistem
systemctl enable iwd
systemctl enable sshd
systemctl enable wpa_supplicant

# Instalare KDE Plasma și pachete necesare
echo "Instalare KDE Plasma..."
pacman -S --noconfirm \
    xorg \
    plasma-meta \
    plasma-workspace \
    plasma-wayland-session \
    kde-applications \
    packagekit-qt5 \
    sddm \
    ark \
    kwrite

# Activare servicii necesare
systemctl enable sddm
systemctl enable NetworkManager

# Instalare drivere NVIDIA
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# Instalare și configurare zsh
pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions
chsh -s /bin/zsh $USERNAME

# Configurare zsh pentru user
cat > /home/$USERNAME/.zshrc << 'EOL'
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Configurare basic
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

# Autocompletare
autoload -Uz compinit
compinit

# Syntax highlighting și sugestii
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt personalizat cu git info
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f %F{blue}%~%f ${vcs_info_msg_0_} %# '

# Alias-uri utile
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'

# Completare avansată
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colorare comenzi
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[sudo]='fg=green,underline'
EOL

# Setare permisiuni pentru .zshrc
chown $USERNAME:$USERNAME /home/$USERNAME/.zshrc

# Instalare pachete de bază și utilități
pacman -S --noconfirm \
    firefox konsole dolphin \
    git base-devel cmake \
    zip unzip tar gzip unrar \
    htop fastfetch \
    noto-fonts ttf-font-awesome noto-fonts-extra \
    qt5-tools qt6-tools

# Instalare paru
mkdir -p $PARU_DIR
chown $USERNAME:$USERNAME $PARU_DIR
sudo -u $USERNAME bash << EOF
cd $PARU_DIR
git clone https://aur.archlinux.org/paru-bin.git .
makepkg -si --noconfirm
EOF

# Instalare pachete din AUR și alte aplicații
sudo -u $USERNAME bash << EOF
paru -S --noconfirm \
    librewolf-bin \
    spotify \
    discord \
    steam \
    thunderbird \
    gimp \
    lutris \
    virtualbox \
    linux-headers \
    virtualbox-host-modules-arch \
    intellij-idea-community-edition \
    jdk17-temurin \
    jdk21-temurin \
    jdk8-temurin \
    prismlauncher-git

# Instalare Spicetify
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh

# Instalare Vencord
sh -c "\$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
EOF

# Configurare firewall
pacman -S --noconfirm ufw
systemctl enable ufw
systemctl start ufw
ufw enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 80/tcp
ufw allow 443/tcp

# Configurare permisiuni Spotify pentru Spicetify
chmod a+wr /opt/spotify
chmod a+wr /opt/spotify/Apps -R

# Setare LibreWolf ca browser implicit
xdg-settings set default-web-browser librewolf.desktop

echo "Instalarea s-a terminat cu succes!"
echo "Sistemul se va reporni în 10 secunde..."
sleep 10
reboot
