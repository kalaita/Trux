#!/data/data/com.termux/files/usr/bin/bash

touch ~/.hushlogin

termux-change-repo

pkg update -y
pkg install -y git gh curl

curl -L "https://raw.githubusercontent.com/kalaita/Trux/main/tbashrc" -o "$HOME/.bashrc"

mkdir -p "$HOME/.termux"

curl -L "https://raw.githubusercontent.com/kalaita/Trux/main/colors.properties" -o "$HOME/.termux/colors.properties"
curl -L "https://raw.githubusercontent.com/kalaita/Trux/main/termux.properties" -o "$HOME/.termux/termux.properties"
curl -L "https://raw.githubusercontent.com/kalaita/Trux/main/font.ttf" -o "$HOME/.termux/font.ttf"

source "$HOME/.bashrc"

termux-reload-settings
