#!/bin/bash

clear

# Check system architecture
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
  NGROK_DIR="ngrok-stable-linux-amd64"
elif [ "$ARCH" = "armv7l" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip"
  NGROK_DIR="ngrok-stable-linux-arm"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip"
  NGROK_DIR="ngrok-stable-linux-arm64"
elif [ "$ARCH" = "ppc64le" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-ppc64le.zip"
  NGROK_DIR="ngrok-stable-linux-ppc64le"
elif [ "$ARCH" = "s390x" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-s390x.zip"
  NGROK_DIR="ngrok-stable-linux-s390x"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

# Check for package manager
if [ -x "$(command -v pacman)" ]; then
  sudo pacman -S unzip wget
elif [ -x "$(command -v yum)" ]; then
  sudo yum install unzip wget
elif [ -x "$(command -v dnf)" ]; then
  sudo dnf install unzip wget
elif [ -x "$(command -v apt)" ]; then
  sudo apt install wget unzip -y
elif [ -x "$(command -v pkg)" ]; then
  sudo pkg install wget unzip
else
  echo "Unsupported package manager"
  exit 1
fi

# Download and install ngrok
wget $DOWNLOAD_URL -O ngrok.zip
unzip ngrok.zip
sudo mv $NGROK_DIR/ngrok /bin
sudo chmod +x /bin/ngrok
rm -rf ngrok.zip $NGROK_DIR

echo "Ngrok has been successfully installed! Type 'ngrok' to use it."
