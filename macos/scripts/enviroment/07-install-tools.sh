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
echo "========= [07] INSTALLING TOOLS ============"
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

echo "Installing productivity tools..."

# Install tools via Homebrew
brew install zoxide
brew install fzf
brew install fd
brew install bat
brew install lsd
brew install lazygit

# Install FZF keybindings
echo ""
echo "Installing FZF keybindings..."
$(brew --prefix)/opt/fzf/install --all

echo ""
echo "Installed tools:"
echo "  ✓ zoxide - smart cd"
echo "  ✓ fzf - fuzzy finder"
echo "  ✓ fd - fast find"
echo "  ✓ bat - better cat"
echo "  ✓ lsd - better ls"
echo "  ✓ lazygit - git TUI"

echo "=============================================="
echo "============== [07] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 08-install-font-jetbrains.sh"

