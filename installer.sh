#!/bin/bash

# Redundancy to make sure we are not running in the home directory
if [[ "$(pwd)" == "$HOME" ]]; then
  echo "This script should not be run inside of your home directory, lets try it this way..."
  git clone https://github.com/EJxByteTheFox/dotfiles ./edot-installer
  cd ./edot-installer
  ./installer.sh
  cd ..
  exit 0
fi

MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
SWAP=$(swapon -s | grep /dev/zram* | awk '{print $3'})

if [ "$MEM" -lt "10000000" ]; then
  SWAP_FOR_HIBERNATE=$(($MEM * 2))
else 
  SWAP_FOR_HIBERNATE=$(($MEM * 1.2))
fi

HIBERNATE="NO"

TMPDIR=installer-tmp

if [ "$SWAP" -ge "$SWAP_FOR_HIBERNATE" ]; then
  echo "Hibernation supported"
  HIBERNATE="YES"
else
  echo "Hibernation unsupported"
  HIBERNATE="NO"
fi

fetch_package_if_not_installed () {
  if [[ $(pacman -Q | grep -w $1 | awk "\$1 == \"$1\" {print \$1}") == "$1" ]]; then
    echo "Package $1 installed"
  else
    echo "Package $1 not found, installing"
    if [[ $2 == "custom" ]]; then 
      $3
    else
      sudo pacman --noconfirm -S $1
    fi
  fi
}

fetch_swayfx () {
  git clone https://aur.archlinux.org/scenefx0.4.git
  cd scenefx0.4
  makepkg -si
  cd ..
  git clone https://aur.archlinux.org/swayfx.git
  cd swayfx
  makepkg -si
  cd ..
  rm -fr swayfx
}

mkdir_ins () {
  mkdir -p $1 2> /dev/null
}

fetch_swaylock_effects () {
  git clone https://aur.archlinux.org/swaylock-effects-git.git
  cd swaylock-effects-git
  makepkg -si
  cd ..
  rm -fr swaylock-effects-git
}

fetch_wofi_emoji () {
  git clone https://aur.archlinux.org/wofi-emoji.git
  cd wofi-emoji
  makepkg -si
  cd ..
  rm -fr wofi-emoji
}

fetch_vimpc () {
  git clone https://aur.archlinux.org/vimpc-git.git
  cd vimpc-git
  makepkg -si
  cd ..
  rm -fr vimpc-git
}

fetch_package_if_not_installed git
fetch_package_if_not_installed swayfx "custom" fetch_swayfx
fetch_package_if_not_installed swaylock-effects-git "custom" fetch_swaylock_effects
fetch_package_if_not_installed swayidle
fetch_package_if_not_installed neovim
fetch_package_if_not_installed neovide
fetch_package_if_not_installed ly
fetch_package_if_not_installed kanshi
fetch_package_if_not_installed mako
fetch_package_if_not_installed ranger
fetch_package_if_not_installed wofi
fetch_package_if_not_installed wofi-emoji "custom" fetch_wofi_emoji
fetch_package_if_not_installed ranger
fetch_package_if_not_installed mpd
fetch_package_if_not_installed mpc
fetch_package_if_not_installed vimpc-git "custom" fetch_vimpc
fetch_package_if_not_installed brightnessctl
fetch_package_if_not_installed wayland
fetch_package_if_not_installed wl-clipboard
fetch_package_if_not_installed grim
fetch_package_if_not_installed slurp
fetch_package_if_not_installed btop
fetch_package_if_not_installed zsh

mkdir_ins ~/.config
mkdir_ins ~/.local
mkdir_ins ~/.config/sway

cp -ru ./.config/* ~/.config
cp -ru ./.local/* ~/.local

sudo systemctl enable ly
sudo systemctl enable mpd

chmod -R +x ~/.local/bin