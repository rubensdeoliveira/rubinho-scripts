#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [15] CONFIGURING CURSOR ============"
echo "=============================================="

# Determine Cursor user directory based on OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  CURSOR_USER_DIR="$HOME/.config/Cursor/User"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
else
  echo "❌ Operating system not automatically supported."
  exit 1
fi

mkdir -p "$CURSOR_USER_DIR"

SETTINGS_PATH="$CURSOR_USER_DIR/settings.json"
KEYBINDINGS_PATH="$CURSOR_USER_DIR/keybindings.json"

echo "Detected Cursor directory: $CURSOR_USER_DIR"
echo ""

echo "Downloading settings.json..."
curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/config/user-settings.json -o "$SETTINGS_PATH"
echo "→ settings.json updated successfully!"

echo "Downloading keybindings.json..."
curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/config/cursor-keyboard.json -o "$KEYBINDINGS_PATH"
echo "→ keybindings.json updated successfully!"

echo "=============================================="
echo "============== [15] DONE ===================="
echo "=============================================="
echo "🎉 Cursor configured successfully!"
echo "   Open Cursor again to apply everything."

