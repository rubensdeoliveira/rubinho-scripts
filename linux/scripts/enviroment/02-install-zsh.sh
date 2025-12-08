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
    echo "The script '$SCRIPT_NAME' is a module and should only be"
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
echo "========= [02] INSTALLING ZSH ================"
echo "=============================================="

sudo apt update -y
sudo apt install -y zsh curl git

ZSH_BIN=$(which zsh)

echo "=============================================="
echo "===== [02] SETTING DEFAULT SHELL ============"
echo "=============================================="

if [ "$SHELL" != "$ZSH_BIN" ]; then
  chsh -s "$ZSH_BIN"
  echo "✔ Default shell changed to ZSH"
else
  echo "✔ ZSH is already the default shell"
fi

echo "=============================================="
echo "===== [02] CREATING MINIMAL .zshrc ==========="
echo "=============================================="

cat > ~/.zshrc << 'EOF'
# ==========================================
#  Minimal ZSH bootstrap configuration file
# ==========================================

# Initialize completion system
autoload -Uz compinit
compinit

# Additional helper configurations will be appended below
# --------------------------------------------
EOF

echo "=============================================="
echo "===== [02] MINIMAL CONFIG CREATED ============"
echo "=============================================="
echo "Full ZSH configuration will be added by script 04"

echo "=============================================="
echo "============== [02] DONE ===================="
echo "=============================================="
echo "⚠️  Please close the terminal and open it again."
echo "▶ Next, run: bash 03-install-zinit.sh"

