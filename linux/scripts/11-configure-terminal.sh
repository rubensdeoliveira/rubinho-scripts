#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [11] CONFIGURING TERMINAL ========="
echo "=============================================="

echo "Installing dconf-cli..."
sudo apt-get install -y dconf-cli

echo "Creating new GNOME Terminal profile: rubinho..."
NEW_PROFILE_ID=$(uuidgen)

# Add to GNOME Terminal list
OLD_LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)
NEW_LIST=$(echo "$OLD_LIST" | sed "s/]/, '$NEW_PROFILE_ID']/")
gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"

PROFILE_KEY="/org/gnome/terminal/legacy/profiles:/:$NEW_PROFILE_ID/"

dconf write "${PROFILE_KEY}visible-name" "'rubinho'"
dconf write "${PROFILE_KEY}use-system-font" "false"
dconf write "${PROFILE_KEY}font" "'JetBrainsMono Nerd Font 13'"
dconf write "${PROFILE_KEY}use-theme-colors" "false"
dconf write "${PROFILE_KEY}foreground-color" "'#f8f8f2'"
dconf write "${PROFILE_KEY}background-color" "'#282a36'"
dconf write "${PROFILE_KEY}palette" "['#000000', '#ff5555', '#50fa7b', '#f1fa8c', '#bd93f9', '#ff79c6', '#8be9fd', '#bbbbbb', '#44475a', '#ff6e6e', '#69ff94', '#ffffa5', '#d6caff', '#ff92df', '#a6f0ff', '#ffffff']"

echo "Setting rubinho as default profile..."
gsettings set org.gnome.Terminal.ProfilesList default "'$NEW_PROFILE_ID'"

echo "Cleaning up old profiles..."
ALL_PROFILES=$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[],'")

for PID in $ALL_PROFILES; do
  if [ "$PID" != "$NEW_PROFILE_ID" ]; then
    echo "Removing old profile: $PID"
    dconf reset -f "/org/gnome/terminal/legacy/profiles:/:$PID/"
  fi
done

gsettings set org.gnome.Terminal.ProfilesList list "['$NEW_PROFILE_ID']"

echo "Profile successfully applied."

echo "=============================================="
echo "============== [11] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/12-configure-ssh.sh)"

