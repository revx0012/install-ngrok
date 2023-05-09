#!/data/data/com.termux/files/usr/bin/bash

# ANSI escape codes for red text
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if the operating system is Android
if [[ "$(uname -o)" == "Android" ]]; then
  # Check if the Termux app is installed
  if [[ -d "$HOME/.termux" ]]; then
    echo "Android and Termux detected."
    # Install required packages
    pkg install wget unzip -y

  # Checks the Architecture to install the correct ngrok

  if [ "$(uname -m)" = "aarch64" ]; then
    arch="arm64"
  elif [ "$(uname -m)" = "armv7l" ]; then
    arch="arm"
 elif [ "$(uname -m)" = "aarch32" ]; then
    arch="armhf"
 elif [ "$(uname -m)" = "x86_64" ]; then
    arch="amd64"
 elif [ "$(uname -m)" = "i686" ]; then
    arch="386"
else
    echo "Unsupported architecture: $(uname -m)"
    exit 1
fi

echo "Your architecture is $arch. It will install ngrok $arch."
read -p "Are you sure you want to continue? [Y/n]: " confirm
if [[ $confirm =~ ^[nN]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

# Download and extract ngrok
url="https://bin.equinox.io/c/4VmDzA7iaHb/$arch/ngrok-stable-linux-$arch.zip"
echo "Downloading ngrok from $url ..."
wget $url -P $HOME
echo "Extracting ngrok ..."
unzip $HOME/ngrok-stable-linux-$arch.zip -d $HOME
rm $HOME/ngrok-stable-linux-$arch.zip

# Move ngrok to /data/data/com.termux/files/usr/bin and make it executable
mv $HOME/ngrok /data/data/com.termux/files/usr/bin
chmod +x /data/data/com.termux/files/usr/bin/ngrok

echo "Ngrok has been successfully installed! Type 'ngrok' to use it."

  else
    echo -e "${RED}The Termux app is not installed.${NC}"
    exit 1
  fi

else
  echo -e "${RED}This script is meant to be run on Android with Termux.${NC}"
  exit 1
fi
