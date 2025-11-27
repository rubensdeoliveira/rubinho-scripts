#!/usr/bin/env bash

set -e

echo "=============================================="
echo "========= [14] INSTALLING CURSOR EXTENSIONS ==="
echo "=============================================="

EXTS=(
  "naumovs.color-highlight"
  "mikestead.dotenv"
  "dbaeumer.vscode-eslint"
  "eamodio.gitlens"
  "shd101wyy.markdown-preview-enhanced"
  "Prisma.prisma"
  "cipchk.px2rem"
  "natqe.reload"
  "bradlc.vscode-tailwindcss"
  "oderwat.indent-rainbow"
  "symbol-icons.vscode-symbols"
  "catppuccin.catppuccin-vsc"
)

for ext in "${EXTS[@]}"; do
  echo "→ Installing: $ext"
  cursor --install-extension "$ext" || echo "⚠ Failed to install $ext (ignoring)"
done

echo "All extensions attempted."

echo "=============================================="
echo "============== [14] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash <(curl -fsSL https://raw.githubusercontent.com/rubensdeoliveira/rubinho-env/master/linux/scripts/15-configure-cursor.sh)"

