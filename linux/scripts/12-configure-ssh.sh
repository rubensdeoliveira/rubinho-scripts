#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [12] CONFIGURING SSH =============="
echo "=============================================="

echo "Installing Git and OpenSSH..."
sudo apt update
sudo apt install -y git openssh-client

echo "Generating SSH key..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -C "rubensojunior6@gmail.com" -f ~/.ssh/id_ed25519 -N ""
else
  echo "SSH key already exists."
fi

echo "Starting SSH agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Setting correct permissions..."
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub

echo "Installing xclip and copying public key to clipboard..."
sudo apt install -y xclip
cat ~/.ssh/id_ed25519.pub | xclip -sel clip

echo "=============================================="
echo "============== [12] DONE ===================="
echo "=============================================="
echo "✅ SSH public key copied to clipboard!"
echo "   Go to GitHub/GitLab Settings → SSH Keys and paste it."
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/13-configure-inotify.sh)"

