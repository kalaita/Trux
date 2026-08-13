#!/data/data/com.termux/files/usr/bin/bash

echo
echo "=========================================="
echo "          SETUP STARTED"
echo "=========================================="
echo

set -e

REPO="https://raw.githubusercontent.com/kalaita/Trux/main"
TERMUX_DIR="$HOME/.termux"

touch "$HOME/.hushlogin"

termux-setup-storage

pkg update -y

pkg install -y git gh

curl -fsSL "$REPO/tbashrc" -o "$HOME/.bashrc"

mkdir -p "$TERMUX_DIR"

curl -fsSL "$REPO/colors.properties" \
    -o "$TERMUX_DIR/colors.properties"

curl -fsSL "$REPO/termux.properties" \
    -o "$TERMUX_DIR/termux.properties"

curl -fsSL "$REPO/font.ttf" \
    -o "$TERMUX_DIR/font.ttf"

termux-reload-settings


echo
echo "=========================================="
echo "          SETUP COMPLETE"
echo "=========================================="
echo
