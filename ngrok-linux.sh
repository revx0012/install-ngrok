#!/bin/bash

clear

# Check system architecture
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-amd64"
elif [ "$ARCH" = "armv7l" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-arm"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-arm64"
elif [ "$ARCH" = "ppc64le" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-ppc64le.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-ppc64le"
elif [ "$ARCH" = "s390x" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-s390x.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-s390x"
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
rm -rf ngrok.zip $NGROK_DIR

echo "Ngrok has been successfully installed! Type 'ngrok' to use it."
