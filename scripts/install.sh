#!/bin/sh
sudo apt update && sudo apt upgrade
sudo apt install winbind p7zip-full net-tools linux-azure slim cabextract
sudo apt install ubuntu-desktop
wget https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/22.04/install.sh
sudo chmod +x install.sh
sudo ./install.sh
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources
sudo apt update
sudo apt install --install-recommends winehq-stable
sudo apt install --install-recommends wine-staging

./install-winetricks.sh
update_winetricks