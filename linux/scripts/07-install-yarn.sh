#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [07] INSTALLING YARN =============="
echo "=============================================="

# Load NVM if not already loaded
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Enabling Corepack + Yarn 1..."
corepack enable
corepack prepare yarn@1 --activate

echo "Yarn  -> $(yarn -v)"

echo "=============================================="
echo "============== [07] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/08-install-font-jetbrains.sh)"

