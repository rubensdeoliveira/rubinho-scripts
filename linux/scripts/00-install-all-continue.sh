#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= CONTINUING INSTALLATION ==========="
echo "=============================================="

REPO_BASE="https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts"

scripts=(
  "02-install-prezto.sh"
  "03-install-starship.sh"
  "04-configure-git.sh"
  "05-install-docker.sh"
  "06-install-node-nvm.sh"
  "07-install-yarn.sh"
  "08-install-font-jetbrains.sh"
  "09-install-cursor.sh"
  "10-configure-keyboard.sh"
  "11-configure-terminal.sh"
  "12-configure-ssh.sh"
  "13-configure-inotify.sh"
  "14-install-cursor-extensions.sh"
  "15-configure-cursor.sh"
)

for script in "${scripts[@]}"; do
  echo ""
  echo "=============================================="
  echo "Running: $script"
  echo "=============================================="
  bash <(curl -fsSL "$REPO_BASE/$script")
  
  # Special pause after script 05
  if [ "$script" == "05-install-docker.sh" ]; then
    echo ""
    echo "=============================================="
    echo "⚠️  IMPORTANT: Logout/login now!"
    echo "=============================================="
    echo "Then, continue with:"
    echo "  bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/00-install-all-continue.sh)"
    echo ""
    exit 0
  fi
done

echo ""
echo "=============================================="
echo "🎉 INSTALLATION COMPLETE!"
echo "=============================================="
echo "All scripts have been executed successfully!"
echo "Restart the terminal to apply all changes."

