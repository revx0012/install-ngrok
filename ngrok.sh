#!/bin/bash

clear
echo "installing the requirements"
pkg install wget tar
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
EOF
  echo -e "\n\033[0m"
  
  echo -e "\033[36mPlease choose your architecture:\033[0m"
  echo -e "\033[36m[1]\033[0m arm (armv6, armv7, and armv8.)"
  echo -e "\033[36m[2]\033[0m aarch64"
  echo -e "\033[36m[3]\033[0m x86_64"
  echo -e "\033[36m[4]\033[0m i386"
  echo -e "\033[36m[5]\033[0m Check current architecture"
  echo -e "\033[36m[6]\033[0m Exit"
  echo -e "\033[36m[7]\033[0m Delete ngrok"
  
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
      echo -e "\e[33mSearching for ngrok in $PREFIX/bin/ngrok\e[0m"
      if [ -f "$PREFIX/bin/ngrok" ]; then
        rm "$PREFIX/bin/ngrok"
        echo -e "\e[32mDeleted ngrok file in $PREFIX/bin/\e[0m"
      else
        echo -e "\e[31mNgrok not found in $PREFIX/bin/ngrok! exiting...\e[0m"
        exit
      fi
      ;;
    *)
      echo -e "\033[31mInvalid choice. Please try again.\033[0m\n"
      ;;
  esac
done

echo -e "\033[33mInstalling ngrok...\033[0m"
link="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-$architecture.tgz"
wget -q --show-progress $link
echo -e "\033[33mSetting up the ngrok...\033[0m"
tar -xf ngrok-v3-stable-linux-$architecture.tgz
mv $HOME/ngrok $PREFIX/bin
chmod +x $PREFIX/bin/ngrok
rm ngrok-v3-stable-linux-$architecture.tgz
echo -e "\033[32mngrok has been installed!\033[0m"
