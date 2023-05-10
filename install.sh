#!/bin/bash

# Check if running on Android and Termux
if [[ $(uname -o) == "Android" && $(command -v termux-info) ]]; then
wget https://raw.githubusercontent.com/revx0012/install-ngrok/main/ngrok-termux.sh
bash ngrok-termux.sh

else

wget https://raw.githubusercontent.com/revx0012/install-ngrok/main/ngrok-linux.sh
bash ngrok-linux.sh

fi

