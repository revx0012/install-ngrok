#!/bin/bash

clear

ARCH=$(uname -m)

echo -e "\033[36mYour architecture is $ARCH. Ngrok for $ARCH will be installed.\033[0m"
read -rp "Are you sure you want to continue? [Y/n] " confirm

if [[ "$confirm" == "" || "$confirm" == "y" || "$confirm" == "Y" ]]; then
  if [[ "$ARCH" == "x86_64" ]]; then
    URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip"
  elif [[ "$ARCH" == "armv7l" ]]; then
    URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip"
  elif [[ "$ARCH" == "aarch64" ]]; then
    URL="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.zip"
  else
    echo -e "\033[31mUnsupported architecture: $ARCH\033[0m"
    exit 1
  fi

  echo "Downloading Ngrok for $ARCH..."
  pkg install curl zip unzip -y
  curl -L $URL -o ngrok.zip
  unzip ngrok.zip
  rm ngrok.zip
  
  # moving ngrok to use it anywhere

  mv ngrok /data/data/com.termux/files/usr/bin/
  chmod +x /data/data/com.termux/files/usr/bin/ngrok
  
else
  echo -e "\033[33mNgrok installation cancelled.\033[0m"
  exit 1
fi

