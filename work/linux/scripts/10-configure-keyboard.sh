#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [10] CONFIGURING KEYBOARD ========="
echo "=============================================="

# Check if running in GNOME
if ! command -v gsettings &> /dev/null; then
  echo "⚠️  gsettings not found. This script requires GNOME desktop environment."
  echo "   Skipping keyboard configuration."
  exit 0
fi

echo "Setting keyboard layouts (US International + Portuguese BR)..."
# Set US International as primary and Portuguese BR as secondary
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl'), ('xkb', 'br')]"

echo "Enabling cedilla (ç) fix..."
gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"

# Additional fix for cedilla if needed
if ! grep -q "GTK_IM_MODULE=cedilla" /etc/environment 2>/dev/null; then
  echo "Adding GTK_IM_MODULE=cedilla to /etc/environment..."
  sudo sh -c "echo 'GTK_IM_MODULE=cedilla' >> /etc/environment"
fi

echo "=============================================="
echo "============== [10] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 11-configure-terminal.sh"

