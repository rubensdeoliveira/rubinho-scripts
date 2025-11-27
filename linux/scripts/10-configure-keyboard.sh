#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [10] CONFIGURING KEYBOARD ========="
echo "=============================================="

echo "Setting US International layout..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+intl')]"

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
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/11-configure-terminal.sh)"

