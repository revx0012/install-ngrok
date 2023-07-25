#!/bin/bash


# Check if running on Android and Termux
if [[ $(uname -o) == "Android" && $(command -v termux-info) ]]; then
echo -e "\033[31mMust be in linux. Aborting...\033[0m" 
   exit 1

clear

# Check system architecture
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-amd64.tgz"
elif [ "$ARCH" = "armv7l" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-arm.tgz"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-arm64"
elif [ "$ARCH" = "ppc64le" ]; then
  DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-ppc64le.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-ppc64le"
elif [ "$ARCH" = "s390x" ]; then
 DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-s390x.tgz"
  NGROK_DIR="ngrok-v3-stable-linux-s390x.tgz"
elif [ "$ARCH" = "mips" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-mips.tgz"
NGROK_DIR="ngrok-v3-stable-linux-mips.tgz"
elif [ "$ARCH" = "mips64" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-mips64.tgz"
NGROK_DIR="ngrok-v3-stable-linux-mips64.tgz"
elif [ "$ARCH" = "mips64le" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-mips64le.tgz"
NGROK_DIR="ngrok-v3-stable-linux-mips64le.tgz"
elif [ "$ARCH" = "386" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz"
NGROK_DIR="ngrok-v3-stable-linux-386.tgz"
elif [ "$ARCH" = "mipsle" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-mipsle.tgz"
NGROK_DIR="ngrok-v3-stable-linux-mipsle.tgz"
elif [ "$ARCH" = "ppc64" ]; then
DOWNLOAD_URL="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-ppc64.tgz"
NGROK_DIR="ngrok-v3-stable-linux-ppc64.tgz"

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
elif [ -x "$(command -v snap)" ]; then
snap install unzip
snap install wget
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
