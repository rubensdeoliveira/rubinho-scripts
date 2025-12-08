#!/usr/bin/env bash

# ────────────────────────────────────────────────────────────────
# Module Guard - Prevent Direct Execution
# ────────────────────────────────────────────────────────────────
# This script should only be executed by 00-install-all.sh
if [ -z "$INSTALL_ALL_RUNNING" ]; then
    SCRIPT_NAME=$(basename "$0")
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    INSTALL_SCRIPT="$SCRIPT_DIR/00-install-all.sh"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⚠️  This script should not be executed directly"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "The script \"$SCRIPT_NAME\" is a module and should only be"
    echo "executed as part of the complete installation process."
    echo ""
    echo "To run the complete installation, use:"
    echo "  bash $INSTALL_SCRIPT"
    echo ""
    echo "Or from the project root:"
    echo "  bash run.sh"
    echo ""
    exit 1
fi


set -e

echo "=============================================="
echo "========= [16] CONFIGURING CURSOR ============"
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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_PATH="$CURSOR_USER_DIR/settings.json"
KEYBINDINGS_PATH="$CURSOR_USER_DIR/keybindings.json"
TASKS_PATH="$CURSOR_USER_DIR/tasks.json"

echo "Detected Cursor directory: $CURSOR_USER_DIR"
echo ""

echo "Copying settings.json..."
cp "$SCRIPT_DIR/../config/user-settings.json" "$SETTINGS_PATH"
echo "→ settings.json updated successfully!"

echo "Copying keybindings.json..."
cp "$SCRIPT_DIR/../config/cursor-keyboard.json" "$KEYBINDINGS_PATH"
echo "→ keybindings.json updated successfully!"

echo "Copying tasks.json..."
cp "$SCRIPT_DIR/../config/tasks.json" "$TASKS_PATH"
echo "→ tasks.json updated successfully!"

echo "=============================================="
echo "============== [16] DONE ===================="
echo "=============================================="
echo "🎉 Cursor configured successfully!"
echo "   Open Cursor again to apply everything."
echo ""
echo "▶ Next, run: bash 15-install-docker.sh"

