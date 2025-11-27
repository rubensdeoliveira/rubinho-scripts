#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [04] CONFIGURING GIT ==============="
echo "=============================================="

echo "Installing Git..."
sudo apt update -y
sudo apt install -y git

echo "Setting up Git identity..."
git config --global user.name "rubinho"
git config --global user.email "rubensojunior6@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto

echo "=============================================="
echo "============== [04] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/05-install-docker.sh)"

