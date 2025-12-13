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
echo "===== [14] INSTALLING TASK MASTER ==========="
echo "=============================================="

# Load NVM if available
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || true

# Check if Node.js/npm is available
if ! command -v npm &> /dev/null; then
    echo "⚠️  npm not found. Task Master requires Node.js/npm."
    echo "   Please install Node.js first (script 05-install-node-nvm.sh)"
    echo "   Task Master will be installed when Node.js is available."
    exit 0
fi

echo "Installing Task Master globally..."

# Reinstall if already installed
if npm list -g task-master-ai &> /dev/null; then
    echo "→ Reinstalling task-master-ai..."
    npm install -g task-master-ai --force
else
    echo "→ Installing task-master-ai..."
    npm install -g task-master-ai
fi

if npm list -g task-master-ai &> /dev/null; then
    echo "✓ Task Master installed successfully"

    # Verify installation
    if command -v task-master-ai &> /dev/null; then
        echo "✓ Task Master command is available"
        # Skip version check to avoid MCP connection timeout
        echo "✓ Task Master installation verified"
    else
        echo "⚠️  Task Master command not found in PATH"
        echo "   You may need to restart your terminal or add npm global bin to PATH"
    fi
else
    echo "❌ Failed to install Task Master"
    exit 1
fi

echo "=============================================="
echo "============== [14] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 15-configure-cursor.sh"
