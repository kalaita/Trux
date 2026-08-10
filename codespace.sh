#!/usr/bin/env bash

set -e

# ==========================================
# Ubuntu Automatic Setup Script
# ==========================================

echo "=========================================="
echo "        Ubuntu Setup Starting..."
echo "=========================================="



HOME_DIR="$HOME"
BIN_DIR="$HOME_DIR/.local/bin"

# ------------------------------------------
# 1. Create ~/.hushlogin
# ------------------------------------------

echo "[1/10] Creating ~/.hushlogin..."
touch "$HOME_DIR/.hushlogin"


# ------------------------------------------
# 2. Go to home directory
# ------------------------------------------

cd "$HOME_DIR"


# ------------------------------------------
# 3. Download bashrc and tmux.conf
# ------------------------------------------

echo "[2/10] Installing custom bash configuration..."

curl -fsSL \
    "https://raw.githubusercontent.com/kalaita/Trux/main/cbashrc" \
    -o "$HOME_DIR/.bashrc"

curl -fsSL \
    "https://raw.githubusercontent.com/kalaita/Trux/main/tmux.conf" \
    -o "$HOME_DIR/.tmux.conf"



# ------------------------------------------
# 5. Install required packages
# ------------------------------------------

echo "[4/10] Installing packages..."

sudo apt update -y
sudo apt install -y \
    p7zip-full \
    aria2 \


# -----------------------------------------

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install miniserve

# ------------------------------------------
# 7. Add ~/.local/bin to PATH
# ------------------------------------------

echo "[6/10] Configuring PATH..."

if ! grep -q 'HOME/.local/bin' "$HOME_DIR/.bashrc"; then
    echo '' >> "$HOME_DIR/.bashrc"
    echo '# ~/.local/bin' >> "$HOME_DIR/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME_DIR/.bashrc"
fi

export PATH="$BIN_DIR:$PATH"


# ------------------------------------------
# 8. Install cloudflared using .deb
# ------------------------------------------

echo "[7/10] Installing cloudflared..."

CLOUDFLARED_DEB="/tmp/cloudflared.deb"

CLOUDFLARED_ARCH="$(dpkg --print-architecture)"

curl -fL \
    "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CLOUDFLARED_ARCH}.deb" \
    -o "$CLOUDFLARED_DEB"

sudo dpkg -i "$CLOUDFLARED_DEB" || {
    sudo apt-get install -f -y
}

rm -f "$CLOUDFLARED_DEB"


# ------------------------------------------
# 9. Upgrade Ubuntu packages
# ------------------------------------------


# ------------------------------------------
# 10. Upgrade pip and npm
# ------------------------------------------

echo "[9/10] Upgrading pip..."

python3 -m pip install --upgrade pip


echo "[10/10] Upgrading npm..."

sudo npm install -g npm@latest


# ------------------------------------------
# Reload bash configuration
# ------------------------------------------

echo ""
echo "Reloading ~/.bashrc..."

source "$HOME_DIR/.bashrc"


# ------------------------------------------
# Check installations
# ------------------------------------------

echo ""
echo "=========================================="
echo "          Installation Complete"
echo "=========================================="

echo ""
echo "Versions:"
echo "------------------------------------------"

echo "miniserve:"
miniserve --version || true

echo ""
echo "cloudflared:"
cloudflared --version || true

echo ""
echo "Python:"
python3 --version

echo ""
echo "pip:"
python3 -m pip --version

echo ""
echo "npm:"
npm --version

echo ""
echo "tmux:"
tmux -V

echo ""
echo "=========================================="
echo "           Ubuntu Setup Done!"
echo "=========================================="

