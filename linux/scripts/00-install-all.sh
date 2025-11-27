#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= COMPLETE INSTALLATION =============="
echo "=============================================="
echo ""
echo "This script will run all installation scripts"
echo "in sequence (01 → 15)."
echo ""
echo "⚠️  ATTENTION:"
echo "   - After script 01, you will need to close"
echo "     and reopen the terminal."
echo "   - After script 05, you will need to"
echo "     logout/login to use Docker without sudo."
echo ""
read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Installation cancelled."
  exit 1
fi

echo ""
echo "=============================================="
echo "Running script 01: install-zsh.sh"
echo "=============================================="
bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/01-install-zsh.sh)

echo ""
echo "=============================================="
echo "⚠️  IMPORTANT: Close and reopen the terminal now!"
echo "=============================================="
echo "Then, continue with:"
echo "  bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/00-install-all-continue.sh)"
echo ""
exit 0

