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
echo "========= [14] INSTALLING DOCKER ============="
echo "=============================================="

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew is required. Please install it first."
  exit 1
fi

echo "Installing Docker Desktop via Homebrew..."
if ! brew list --cask docker &> /dev/null; then
  brew install --cask docker
  echo "✓ Docker Desktop installed"
else
  echo "✓ Docker Desktop already installed"
fi

echo "Starting Docker Desktop..."
open -a Docker

echo "Waiting for Docker to start..."
sleep 5

echo "Testing Docker..."
if docker ps &> /dev/null; then
  echo "✓ Docker is running"
  docker run hello-world || true
else
  echo "⚠️  Docker Desktop is starting. Please wait for it to fully start."
  echo "   You can check the status in the Docker Desktop app."
fi

echo "=============================================="
echo "============== [14] DONE ===================="
echo "=============================================="
echo "⚠️  Make sure Docker Desktop is running"
echo ""
echo "▶ Next, run: bash 14-configure-terminal.sh (final step)"

