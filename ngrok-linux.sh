#!/bin/bash

clear

DISTRO=$(awk -F= '/^NAME/{print $2}' /etc/os-release | tr -d '"')

if [[ "$DISTRO" == "Ubuntu" || "$DISTRO" == "Debian" || "$DISTRO" == "Linux Mint" ]]; then
  echo "Detected Debian-based distribution. Installing Ngrok..."
  sudo apt-get update
  sudo apt-get install -y curl unzip
elif [[ "$DISTRO" == "CentOS Linux" ]]; then
  echo "Detected CentOS distribution. Installing Ngrok..."
  sudo yum update
  sudo yum install -y curl unzip
elif [[ "$DISTRO" == "Fedora" ]]; then
  echo "Detected Fedora distribution. Installing Ngrok..."
  sudo dnf update
  sudo dnf install -y curl unzip
elif [[ "$DISTRO" == "Arch Linux" ]]; then
  echo "Detected Arch Linux distribution. Installing Ngrok..."
  sudo pacman -Syy
  sudo pacman -S --noconfirm curl unzip
else
  echo "Unsupported distribution. Please install Ngrok manually."
  exit 1
fi

ARCH=$(uname -m)
NGROK_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-$ARCH.zip"
echo -e "\033[36mYour architecture is $ARCH. Downloading Ngrok for $ARCH...\033[0m"
curl -sL $NGROK_URL -o ngrok.zip

if [ -f ngrok.zip ]; then
  echo -e "\033[32mNgrok downloaded successfully.\033[0m"
else
  echo -e "\033[33mDownload failed. Exiting...\033[0m"
  exit 1
fi

unzip ngrok.zip
sudo mv ngrok /bin
sudo chmod +x /bin/ngrok
rm ngrok.zip
echo -e "\033[32mNgrok has been successfully installed! Type 'ngrok' to use it.\033[0m"
