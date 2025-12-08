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
echo "========= [18] INSTALLING HEIDISQL ==========="
echo "=============================================="

# Check if HeidiSQL is already installed
if command -v heidisql &> /dev/null || [ -f /usr/bin/heidisql ]; then
    echo "✓ HeidiSQL is already installed"
    echo "Skipping installation..."
else
    echo "Installing HeidiSQL for Linux..."
    echo ""
    echo "📥 Downloading HeidiSQL .deb package..."
    echo ""
    echo "HeidiSQL Linux version is available from:"
    echo "  https://www.heidisql.com/download.php"
    echo ""
    echo "Please download the Linux 64 bit (.deb package) version"
    echo ""
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    # Detect architecture
    ARCH=$(uname -m)
    if [ "$ARCH" = "x86_64" ]; then
        echo "Detected architecture: x86_64"
        echo "Temporary directory: $TEMP_DIR"
        echo ""
        read -p "Press Enter after you have downloaded the .deb file to $TEMP_DIR/, or type 'skip' to exit: " response
        
        if [ "$response" = "skip" ]; then
            echo "⚠️  Installation skipped"
            cd -
            rm -rf "$TEMP_DIR"
            exit 0
        fi
        
        # Find the downloaded .deb file
        DEB_FILE=$(find "$TEMP_DIR" -maxdepth 1 -name "*.deb" -type f | head -n 1)
        
        if [ -z "$DEB_FILE" ]; then
            echo "⚠️  No .deb file found in $TEMP_DIR"
            echo "    Please download the HeidiSQL .deb file and run this script again"
            cd -
            rm -rf "$TEMP_DIR"
            exit 1
        fi
        
        echo ""
        echo "Found package: $(basename "$DEB_FILE")"
        echo "Installing HeidiSQL..."
        
        # Install the package
        sudo dpkg -i "$DEB_FILE" || {
            echo "Fixing dependencies..."
            sudo apt-get install -f -y
        }
        
        # Verify installation
        if command -v heidisql &> /dev/null || [ -f /usr/bin/heidisql ]; then
            echo "✓ HeidiSQL installed successfully"
        else
            echo "⚠️  HeidiSQL installed but command not found"
            echo "   Try launching from Applications menu or: /usr/bin/heidisql"
        fi
        
        # Ask if user wants to keep or delete the downloaded file
        echo ""
        read -p "Do you want to delete the downloaded .deb file? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -f "$DEB_FILE"
            echo "✓ Downloaded file removed"
        else
            echo "✓ Downloaded file kept at: $DEB_FILE"
        fi
        
        # Cleanup
        cd -
        rm -rf "$TEMP_DIR"
    else
        echo "❌ Unsupported architecture: $ARCH"
        echo "   HeidiSQL Linux version is only available for x86_64"
        cd -
        rm -rf "$TEMP_DIR"
        exit 1
    fi
fi

echo "=============================================="
echo "============== [18] DONE ===================="
echo "=============================================="
echo ""
echo "📝 HeidiSQL is a powerful database management tool for:"
echo "   - MySQL, MariaDB, PostgreSQL, SQLite, and more"
echo ""
echo "🎉 All development tools installation complete!"

