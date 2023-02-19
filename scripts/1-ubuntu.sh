#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install winbind p7zip-full net-tools linux-azure slim cabextract -y
sudo apt install ubuntu-desktop -y
wget https://raw.githubusercontent.com/Hinara/linux-vm-tools/ubuntu20-04/ubuntu/22.04/install.sh
sudo chmod +x install.sh
sudo ./install.sh
sudo reboot