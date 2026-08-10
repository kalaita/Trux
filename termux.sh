#!/data/data/com.termux/files/usr/bin/bash

set -e

REPO="https://raw.githubusercontent.com/kalaita/Trux/main"
TERMUX_DIR="$HOME/.termux"

echo
echo "=========================================="
echo "        Trux Termux Setup"
echo "=========================================="
echo
echo "Shell script fetched via curl."
echo "Do you want to start the setup?"
printf "Reply with y to continue: "
read -r answer

if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 0
fi

echo
echo "[1/6] Setting up .hushlogin..."
touch "$HOME/.hushlogin"
echo "✓ .hushlogin configured."

echo
echo "[2/6] Storage setup"
printf "Do you want to setup Termux storage? [y/N]: "
read -r answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    termux-setup-storage
    echo "✓ Storage setup requested."
else
    echo "→ Storage setup skipped."
fi

echo
echo "[3/6] Repository setup"
printf "Do you want to change the Termux package repository? [y/N]: "
read -r answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    termux-change-repo
    echo "✓ Repository configuration completed."
else
    echo "→ Repository change skipped."
fi

echo
echo "[4/6] Updating package lists..."
pkg update -y
echo "✓ Package lists updated."

echo
echo "[5/6] Installing required packages..."
pkg install -y git gh
echo "✓ Required packages installed."

echo
echo "[6/6] Downloading Trux configuration files..."

echo "→ Copying .bashrc..."
curl -fsSL "$REPO/tbashrc" -o "$HOME/.bashrc"

mkdir -p "$TERMUX_DIR"

echo "→ Copying colors.properties..."
curl -fsSL "$REPO/colors.properties" \
    -o "$TERMUX_DIR/colors.properties"

echo "→ Copying termux.properties..."
curl -fsSL "$REPO/termux.properties" \
    -o "$TERMUX_DIR/termux.properties"

echo "→ Copying font.ttf..."
curl -fsSL "$REPO/font.ttf" \
    -o "$TERMUX_DIR/font.ttf"

echo "✓ Termux files copied successfully."

echo
echo "→ Applying Termux settings..."
termux-reload-settings

echo "→ Loading new shell configuration..."
source "$HOME/.bashrc"

echo
echo "=========================================="
echo "          SETUP COMPLETE ✓"
echo "=========================================="
echo
echo "Everything is good."
echo "Termux setup completed successfully!"
echo
