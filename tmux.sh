#!/bin/bash

sudo apt update -y &&
sudo apt install -y tmux &&
tmux new-session -s ksi "curl -fsSL https://raw.githubusercontent.com/kalaita/Trux/main/codespace.sh | bash"
