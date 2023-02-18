#!/bin/bash
webserver_url="http://hyperv-host-ip:8000"
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

wget "$webserver_url/secret.key"
wget "$webserver_url/ServiceTier.zip"
wget https://download.visualstudio.microsoft.com/download/pr/321a2352-a7aa-492a-bd0d-491a963de7cc/6d17be7b07b8bc22db898db0ff37a5cc/dotnet-hosting-6.0.14-win.exe

7z e ServiceTier.zip

./install-winetricks.sh
update_winetricks

winetricks prefix=bc1 -q dotnet48
winetricks prefix=bc1 -q dotnetdesktop60

wget https://github.com/PietJankbal/Chocolatey-for-wine/releases/download/v0.5q.703/Chocolatey-for-wine.7z
7z e Chocolatey-for-wine.7z
cd Chocolatey-for-wine
WINEPREFIX=~/.local/share/wineprefixes/bc1 wine ChoCinstaller_0.5g.703.exe
