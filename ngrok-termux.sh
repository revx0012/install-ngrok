#!/bin/bash

if [[ $PREFIX == "/data/data/com.termux/files/usr" && $(uname -o) == "Android" ]]; then
  echo ""
else
  echo -e "\033[31mNot using Termux on Android. Aborting...\033[0m"
  exit 1
fi

clear

echo "Fixing warning when you install ngrok..."
sleep 2
USERNAME=$(whoami)

if grep -q "export USER=$USERNAME" "$HOME/.zshrc" || grep -q "export USER=$USERNAME" "$HOME/.bashrc"; then
  :
else
  if [[ "$SHELL" == "/data/data/com.termux/files/usr/bin/zsh" ]]; then
    echo "export USER=$USERNAME" >> "$HOME/.zshrc"
    zsh
  elif [[ "$SHELL" == "/data/data/com.termux/files/usr/bin/bash" ]]; then
    echo "export USER=$USERNAME" >> "$HOME/.bashrc"
    bash
  fi
fi

clear
echo "Installing the requirements..."
pkg install tar wget curl resolv-conf proot -y &>/dev/null
clear

while true; do
  echo -e "\033[36m"
  cat << "EOF"
   _   _                 _
  | \ | |               | |
  |  \| | __ _ _ __ ___ | | __
  | . ` |/ _` | '__/ _ \| |/ /
  | |\  | (_| | | | (_) |   <
  |_| \_|\__, |_|  \___/|_|\_\
          __/ |
         |___/

   Coded by Ron144/RevX
EOF
  echo -e "\n\033[0m"

  echo -e "\033[36mPlease choose your architecture:\033[0m"
  echo -e "\033[36m[1]\033[0m arm (armv6, armv7, armv8 and armv71)"
  echo -e "\033[36m[2]\033[0m aarch64"
  echo -e "\033[36m[3]\033[0m x86_64"
  echo -e "\033[36m[4]\033[0m i686 (or i386)"
  echo -e "\033[36m[5]\033[0m Check current architecture"
  echo -e "\033[36m[6]\033[0m Exit"
  echo -e "\033[36m[7]\033[0m Delete ngrok"
  echo -e "\033[36m[8]\033[0m Setup ngrok authtoken"

  read -p "Enter your choice: " choice
  echo ""

  case $choice in
    1)
      architecture="arm"
      break
      ;;
    2)
      architecture="arm64"
      break
      ;;
    3)
      architecture="amd64"
      break
      ;;
    4)
      architecture="386"
      break
      ;;
    5)
      current_arch=$(uname -m)
      echo -e "\033[33mYour current architecture is: $current_arch\033[0m\n"
      read -p "Press enter to continue..."
      ;;
    6)
      exit
      ;;
    7)
      echo -e "\e[33mSearching for ngrok in $PREFIX/bin/\e[0m"
      sleep 1
      echo -e "\e[33mSearching for ngrok in $HOME/\e[0m"
      sleep 1
      if [ -f "$PREFIX/bin/ngrok" ]; then
        rm $PREFIX/bin/ngrok
        echo -e "\e[32mDeleted ngrok file in $PREFIX/bin/\e[0m"
        rm -rf $HOME/.config/ngrok
      elif [ -f "$HOME/ngrok" ]; then
        rm $HOME/ngrok
        echo -e "\e[32mDeleted ngrok file in $HOME/\e[0m"
        rm -rf $HOME/.config/ngrok
      else
        echo -e "\e[31mNgrok not found in Bin folder or Home directory! exiting...\e[0m"
        exit 1
      fi
      ;;
    8)
      if [ -f "$PREFIX/bin/ngrok" ]; then
        read -p "Enter your ngrok authtoken: " authtoken
        ngrok config add-authtoken $authtoken
        echo -e "\033[32mngrok authtoken is set up!\033[0m"
      else
        echo -e "\033[31mYou didn't install ngrok.\033[0m\n"
        read -p "Press enter to continue..."
      fi
      ;;
    *)
      echo -e "\033[31mInvalid choice. Please try again.\033[0m\n"
      ;;
  esac
done

if [ -f "$PREFIX/bin/ngrok" ]; then
  echo -e "\033[33mYou already installed ngrok. Do you want to delete ngrok? (y/n)\033[0m"
  read delete

  if [[ "$delete" == "y" ]]; then
    rm "$PREFIX/bin/ngrok"
    echo -e "\033[32mNgrok has been deleted.\033[0m"
  elif [[ "$delete" == "n" ]]; then
    echo -e "\033[31mSorry, but we can't continue the installation if you don't remove it.\033[0m\n"
    exit 1
  else
    echo -e "\033[31mInvalid choice. Exiting...\033[0m"
    exit 1
  fi
fi

echo -e "\033[33mInstalling ngrok...\033[0m"
link="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-$architecture.tgz"
wget -q --show-progress $link

echo -e "\033[33mSetting up ngrok...\033[0m"

sleep 2

tar -xf ngrok-v3-stable-linux-$architecture.tgz
mv $HOME/ngrok $PREFIX/bin
chmod +x $PREFIX/bin/ngrok
rm ngrok-v3-stable-linux-$architecture.tgz

sleep 1

echo -e "\033[32mngrok has been installed! Use the command 'ngrok' to use it.\033[0m"
echo "Im here to say that if you want to use ngrok with no hotspot, Use command 'termux-chroot' before using ngrok. it will work!"
echo "To get your authtoken, please visit: https://ngrok.com"
echo "Don't worry, it's free!"
echo -e "\033[33mMade by Ron144#1491\033[0m"
