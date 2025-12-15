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
echo "========= [17] INSTALLING INSOMNIA ==========="
echo "=============================================="

echo "Installing Insomnia..."

# Add Insomnia repository
echo "Adding Insomnia repository..."

# Create keyrings directory if it doesn't exist
sudo mkdir -p /etc/apt/keyrings

# Add GPG key (modern method)
echo "Adding GPG key..."
curl -fsSL https://insomnia.rest/keys/debian-public.key.asc | sudo gpg --dearmor -o /etc/apt/keyrings/insomnia.gpg
sudo chmod a+r /etc/apt/keyrings/insomnia.gpg

# Add repository with signed-by
echo "deb [signed-by=/etc/apt/keyrings/insomnia.gpg] https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee /etc/apt/sources.list.d/insomnia.list > /dev/null

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install Insomnia (only if not already installed)
if command -v insomnia &> /dev/null; then
    echo "✓ Insomnia is already installed"
    echo "  Skipping installation"
else
echo "Installing Insomnia..."
    sudo apt-get install -y insomnia
fi

# Verify installation
if command -v insomnia &> /dev/null; then
    echo "✓ Insomnia installed successfully"
else
    echo "⚠️  Insomnia installed but command not found in PATH"
    echo "   Try restarting your terminal or launching from Applications menu"
fi

echo "=============================================="
echo "============== [17] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 18-install-tableplus.sh"
