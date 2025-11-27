#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [06] INSTALLING NODE + NVM ========="
echo "=============================================="

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "NVM already installed."
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node 22..."
nvm install 22
nvm alias default 22

echo "Node  -> $(node -v)"
echo "NPM   -> $(npm -v)"

echo "=============================================="
echo "============== [06] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/07-install-yarn.sh)"

