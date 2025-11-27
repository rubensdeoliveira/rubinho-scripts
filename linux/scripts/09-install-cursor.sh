#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [09] INSTALLING CURSOR ============"
echo "=============================================="

echo "Downloading Cursor Editor..."
wget "https://cursor.sh/download?platform=linux-deb" -O cursor.deb

echo "Installing Cursor..."
sudo dpkg -i cursor.deb || true
sudo apt --fix-broken install -y

echo "Cursor installed!"
cursor --version || echo "Cursor version could not be displayed."

echo "=============================================="
echo "============== [09] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/10-configure-keyboard.sh)"

