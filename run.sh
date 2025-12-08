#!/usr/bin/env bash

#
# Rubinho Scripts - Main Entry Point
#
# Simplified interface for managing development environment and system resources.
# Automatically detects platform and provides three core options:
#   1. Install development tools
#   2. Analyze disk space
#   3. Clean up unnecessary files
#

set -eo pipefail

# ────────────────────────────────────────────────────────────────
# Script Directory and Initialization
# ────────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse command-line arguments
FORCE_MODE=false
VERBOSE_MODE=false

for arg in "$@"; do
    case $arg in
        --force)
            FORCE_MODE=true
            shift
            ;;
        --verbose|-v)
            VERBOSE_MODE=true
            export LOG_LEVEL="DEBUG"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--force] [--verbose]"
            echo ""
            echo "Options:"
            echo "  --force       Skip all confirmation prompts"
            echo "  --verbose, -v Enable verbose logging (DEBUG level)"
            echo "  --help        Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Export modes for use in other scripts
export FORCE_MODE
export VERBOSE_MODE

# ────────────────────────────────────────────────────────────────
# Platform Detection
# ────────────────────────────────────────────────────────────────

# Source platform detection module
if [ ! -f "$SCRIPT_DIR/lib/platform.sh" ]; then
    echo "ERROR: Platform detection module not found at $SCRIPT_DIR/lib/platform.sh"
    exit 1
fi

# shellcheck source=lib/platform.sh
source "$SCRIPT_DIR/lib/platform.sh"

# ────────────────────────────────────────────────────────────────
# Logging Initialization
# ────────────────────────────────────────────────────────────────

# Source logging module
if [ ! -f "$SCRIPT_DIR/lib/logging.sh" ]; then
    echo "WARNING: Logging module not found at $SCRIPT_DIR/lib/logging.sh" >&2
else
    # shellcheck source=lib/logging.sh
    source "$SCRIPT_DIR/lib/logging.sh"
    init_logging
    log_info "Rubinho Scripts started"
    log_info "Platform: $PLATFORM_NAME"
    log_info "Force mode: $FORCE_MODE"
    log_info "Verbose mode: $VERBOSE_MODE"
fi

# Source disk analysis module
if [ ! -f "$SCRIPT_DIR/lib/disk_analysis.sh" ]; then
    echo "WARNING: Disk analysis module not found at $SCRIPT_DIR/lib/disk_analysis.sh" >&2
else
    # shellcheck source=lib/disk_analysis.sh
    source "$SCRIPT_DIR/lib/disk_analysis.sh"
fi

# Source cleanup preview module
if [ ! -f "$SCRIPT_DIR/lib/cleanup_preview.sh" ]; then
    echo "WARNING: Cleanup preview module not found at $SCRIPT_DIR/lib/cleanup_preview.sh" >&2
else
    # shellcheck source=lib/cleanup_preview.sh
    source "$SCRIPT_DIR/lib/cleanup_preview.sh"
fi

# ────────────────────────────────────────────────────────────────
# Welcome Banner
# ────────────────────────────────────────────────────────────────

clear
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         🚀 Rubinho Scripts - System Manager 🚀                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
print_platform_info
echo ""

# ────────────────────────────────────────────────────────────────
# Handler Functions
# ────────────────────────────────────────────────────────────────

install_tools() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📦 Install Development Environment"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "This will install and configure your complete development environment:"
    echo "  • Git configuration"
    echo "  • Zsh shell with Zinit and Starship prompt"
    echo "  • Node.js (via NVM) and Yarn"
    echo "  • Development tools and utilities"
    echo "  • Cursor IDE and extensions"
    echo "  • Docker"
    echo "  • And more..."
    echo ""
    echo "Platform: $PLATFORM_NAME"
    echo ""

    if [ "$FORCE_MODE" = false ]; then
        read -p "Continue with installation? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            log_info "User cancelled installation"
            return 0
        fi
    fi

    # Determine platform-specific script path
    local install_script
    if is_macos; then
        install_script="$SCRIPT_DIR/macos/scripts/enviroment/00-install-all.sh"
    elif is_linux; then
        install_script="$SCRIPT_DIR/linux/scripts/enviroment/00-install-all.sh"
    else
        echo "❌ Error: Unsupported platform: $PLATFORM_NAME"
        log_error "Unsupported platform: $PLATFORM_NAME"
        return 1
    fi

    # Validate script exists
    if [ ! -f "$install_script" ]; then
        echo "❌ Error: Installation script not found at: $install_script"
        log_error "Installation script not found: $install_script"
        return 1
    fi

    # Make script executable
    chmod +x "$install_script" 2>/dev/null || true

    echo ""
    echo "🚀 Starting installation..."
    echo ""
    log_info "Starting installation: $install_script"

    # Execute installation script
    if bash "$install_script"; then
        echo ""
        echo "✅ Installation completed successfully!"
        log_info "Installation completed successfully"
    else
        echo ""
        echo "❌ Installation failed. Check the logs for details."
        log_error "Installation failed"
        return 1
    fi
}

analyze_disk() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📊 Analyze Disk Space"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "This will analyze your disk usage and show:"
    echo "  • Top 100 largest folders"
    echo "  • Top 100 largest files"
    echo "  • Per-user breakdown (caches, trash, logs, etc.)"
    echo "  • Disk space summary"
    echo ""

    # Determine platform-specific script path
    local analyze_script
    if is_macos; then
        analyze_script="$SCRIPT_DIR/macos/scripts/utils/analyze_space.sh"
    elif is_linux; then
        analyze_script="$SCRIPT_DIR/linux/scripts/utils/analyze_space.sh"
    else
        echo "❌ Error: Unsupported platform: $PLATFORM_NAME"
        log_error "Unsupported platform: $PLATFORM_NAME"
        return 1
    fi

    # Validate script exists
    if [ ! -f "$analyze_script" ]; then
        echo "❌ Error: Analysis script not found at: $analyze_script"
        log_error "Analysis script not found: $analyze_script"
        return 1
    fi

    # Make script executable
    chmod +x "$analyze_script" 2>/dev/null || true

    echo "🔍 Starting disk analysis..."
    echo ""
    log_info "Starting disk analysis: $analyze_script"

    # Execute analysis script
    if bash "$analyze_script"; then
        log_info "Disk analysis completed"
    else
        echo ""
        echo "❌ Disk analysis failed. Check the logs for details."
        log_error "Disk analysis failed"
        return 1
    fi
}

cleanup_files() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🧹 Clean Up Disk Space"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "This will clean up unnecessary files:"
    echo "  • Docker containers, images, volumes"
    echo "  • Development artifacts (node_modules, build files, etc.)"
    echo "  • Application caches"
    echo "  • Trash contents"
    echo "  • Old logs and temporary files"
    echo ""
    echo "⚠️  WARNING: This will remove development files!"
    echo "   Projects will need to reinstall dependencies after cleanup."
    echo ""

    if [ "$FORCE_MODE" = false ]; then
        read -p "Continue with cleanup? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cleanup cancelled."
            log_info "User cancelled cleanup"
            return 0
        fi
    fi

    # Determine platform-specific script path
    local cleanup_script
    if is_macos; then
        cleanup_script="$SCRIPT_DIR/macos/scripts/utils/clean_space.sh"
    elif is_linux; then
        cleanup_script="$SCRIPT_DIR/linux/scripts/utils/clean_space.sh"
    else
        echo "❌ Error: Unsupported platform: $PLATFORM_NAME"
        log_error "Unsupported platform: $PLATFORM_NAME"
        return 1
    fi

    # Validate script exists
    if [ ! -f "$cleanup_script" ]; then
        echo "❌ Error: Cleanup script not found at: $cleanup_script"
        log_error "Cleanup script not found: $cleanup_script"
        return 1
    fi

    # Make script executable
    chmod +x "$cleanup_script" 2>/dev/null || true

    echo ""
    echo "🧹 Starting cleanup..."
    echo ""
    log_info "Starting cleanup: $cleanup_script"

    # Execute cleanup script
    if bash "$cleanup_script"; then
        echo ""
        echo "✅ Cleanup completed successfully!"
        log_info "Cleanup completed successfully"
    else
        echo ""
        echo "❌ Cleanup failed. Check the logs for details."
        log_error "Cleanup failed"
        return 1
    fi
}

# ────────────────────────────────────────────────────────────────
# Main Menu
# ────────────────────────────────────────────────────────────────

main_menu() {
    while true; do
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "What would you like to do?"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "  1) 📦 Install development tools"
        echo "  2) 📊 Analyze disk space"
        echo "  3) 🧹 Clean up unnecessary files"
        echo ""
        echo "  0) ❌ Exit"
        echo ""

        # Read user choice
        read -p "Enter your choice [0-3]: " choice
        echo ""

        case $choice in
            1)
                install_tools
                ;;
            2)
                analyze_disk
                ;;
            3)
                cleanup_files
                ;;
            0)
                echo "Goodbye!"
                log_info "User selected exit"
                finalize_logging
                print_log_location
                exit 0
                ;;
            *)
                echo "❌ Invalid choice. Please enter a number between 0 and 3."
                log_warning "Invalid menu choice: $choice"
                echo ""
                ;;
        esac

        # Ask if user wants to do something else
        if [ "$FORCE_MODE" = false ]; then
            echo ""
            read -p "Do you want to perform another action? [Y/n]: " -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                echo "Goodbye!"
                log_info "User chose not to continue"
                finalize_logging
                print_log_location
                exit 0
            fi
            echo ""
        else
            # In force mode, exit after completing one action
            echo "Force mode: Exiting after completing action."
            log_info "Force mode: exiting after action"
            finalize_logging
            print_log_location
            exit 0
        fi
    done
}

# ────────────────────────────────────────────────────────────────
# Cleanup Handler
# ────────────────────────────────────────────────────────────────

cleanup_and_exit() {
    local exit_code=$?
    echo ""
    log_info "Script exiting with code: $exit_code"
    finalize_logging
    print_log_location
    exit "$exit_code"
}

# ────────────────────────────────────────────────────────────────
# Entry Point
# ────────────────────────────────────────────────────────────────

# Trap signals for graceful exit
trap 'echo ""; echo "Interrupted by user. Exiting..."; log_warning "Script interrupted by user (Ctrl+C)"; cleanup_and_exit' INT
trap cleanup_and_exit EXIT

# Start main menu
main_menu
