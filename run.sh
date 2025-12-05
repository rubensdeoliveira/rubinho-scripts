#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         🚀 Rubinho Scripts - Interactive Launcher 🚀         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# ────────────────────────────────
# Choose Environment
# ────────────────────────────────

echo "Select environment:"
echo "  1) 👤 Personal - Base development setup"
echo "  2) 🏢 Work - Company-specific tools"
echo ""
read -p "Choice [1-2]: " ENV_CHOICE

case $ENV_CHOICE in
    1)
        ENV_TYPE="personal"
        ENV_NAME="Personal"
        ENV_ICON="👤"
        ;;
    2)
        ENV_TYPE="work"
        ENV_NAME="Work"
        ENV_ICON="🏢"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$ENV_ICON $ENV_NAME Environment Selected"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ────────────────────────────────
# Check .env for work environment
# ────────────────────────────────

if [ "$ENV_TYPE" = "work" ]; then
    if [ ! -f "$SCRIPT_DIR/work/.env" ]; then
        echo "⚠️  WARNING: work/.env not found!"
        echo ""
        echo "Work scripts require configuration. Create .env file:"
        echo "  cd work"
        echo "  cp .env.example .env"
        echo "  nano .env"
        echo ""
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cancelled."
            exit 0
        fi
    fi
fi

# ────────────────────────────────
# Choose Platform
# ────────────────────────────────

echo "Select platform:"
echo "  1) 🐧 Linux"
echo "  2) 🍎 macOS"
echo ""
read -p "Choice [1-2]: " PLATFORM_CHOICE

case $PLATFORM_CHOICE in
    1)
        PLATFORM="linux"
        PLATFORM_NAME="Linux"
        ;;
    2)
        PLATFORM="macos"
        PLATFORM_NAME="macOS"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "Platform: $PLATFORM_NAME"
echo ""

# ────────────────────────────────
# List Available Scripts
# ────────────────────────────────

BASE_PATH="$SCRIPT_DIR/$ENV_TYPE/$PLATFORM/scripts"

if [ ! -d "$BASE_PATH" ]; then
    echo "❌ Error: $BASE_PATH not found"
    exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Available Scripts"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Find all .sh files and create menu
declare -a SCRIPTS
declare -a SCRIPT_PATHS
INDEX=1

# Environment setup scripts
if [ -d "$BASE_PATH/enviroment" ]; then
    echo "📦 Environment Setup:"
    for script in "$BASE_PATH/enviroment"/*.sh; do
        if [ -f "$script" ]; then
            SCRIPT_NAME=$(basename "$script")
            SCRIPTS[$INDEX]="$SCRIPT_NAME"
            SCRIPT_PATHS[$INDEX]="$script"
            echo "  $INDEX) $SCRIPT_NAME"
            INDEX=$((INDEX + 1))
        fi
    done
    echo ""
fi

# Utility scripts
if [ -d "$BASE_PATH/utils" ]; then
    echo "🛠️  Utilities:"
    for script in "$BASE_PATH/utils"/*.sh; do
        if [ -f "$script" ]; then
            SCRIPT_NAME=$(basename "$script")
            SCRIPTS[$INDEX]="$SCRIPT_NAME"
            SCRIPT_PATHS[$INDEX]="$script"
            echo "  $INDEX) $SCRIPT_NAME"
            INDEX=$((INDEX + 1))
        fi
    done
    echo ""
fi

# Other scripts in root
echo "📄 Other Scripts:"
for script in "$BASE_PATH"/*.sh; do
    if [ -f "$script" ]; then
        SCRIPT_NAME=$(basename "$script")
        # Skip if already listed
        if [[ ! " ${SCRIPTS[@]} " =~ " ${SCRIPT_NAME} " ]]; then
            SCRIPTS[$INDEX]="$SCRIPT_NAME"
            SCRIPT_PATHS[$INDEX]="$script"
            echo "  $INDEX) $SCRIPT_NAME"
            INDEX=$((INDEX + 1))
        fi
    fi
done

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "❌ No scripts found in $BASE_PATH"
    exit 1
fi

echo ""
echo "  0) ❌ Cancel"
echo ""
read -p "Select script to run [0-$((INDEX-1))]: " SCRIPT_CHOICE

if [ "$SCRIPT_CHOICE" = "0" ]; then
    echo "Cancelled."
    exit 0
fi

if [ -z "${SCRIPT_PATHS[$SCRIPT_CHOICE]}" ]; then
    echo "❌ Invalid choice"
    exit 1
fi

SELECTED_SCRIPT="${SCRIPT_PATHS[$SCRIPT_CHOICE]}"
SELECTED_NAME="${SCRIPTS[$SCRIPT_CHOICE]}"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Running: $SELECTED_NAME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ────────────────────────────────
# Run Selected Script
# ────────────────────────────────

cd "$(dirname "$SELECTED_SCRIPT")"
bash "$SELECTED_SCRIPT"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Script completed!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
