#!/usr/bin/env bash

set -e

echo "=============================================="
echo "===== [12] INSTALLING TASK MASTER (MCP) ====="
echo "=============================================="

# ────────────────────────────────
# Check Cursor Installation
# ────────────────────────────────

CURSOR_MCP_DIR="$HOME/.cursor"
MCP_CONFIG_FILE="$CURSOR_MCP_DIR/mcp.json"

if [ ! -d "$CURSOR_MCP_DIR" ]; then
    echo "Creating Cursor MCP directory..."
    mkdir -p "$CURSOR_MCP_DIR"
fi

# ────────────────────────────────
# Install Task Master via One-Click
# ────────────────────────────────

echo ""
echo "📦 Installing Task Master MCP Server..."
echo ""
echo "⚠️  IMPORTANT: This will open Task Master installation page"
echo "   Follow the one-click installation in Cursor"
echo ""
echo "Opening: https://www.task-master.dev/"
echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    open "https://www.task-master.dev/"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "https://www.task-master.dev/" 2>/dev/null || \
    sensible-browser "https://www.task-master.dev/" 2>/dev/null || \
    echo "Please open: https://www.task-master.dev/"
fi

echo ""
read -p "Press Enter after completing the one-click installation in Cursor..."

# ────────────────────────────────
# Create/Update MCP Configuration
# ────────────────────────────────

echo ""
echo "📝 Configuring MCP settings..."

if [ -f "$MCP_CONFIG_FILE" ]; then
    echo "→ Found existing mcp.json, backing up..."
    cp "$MCP_CONFIG_FILE" "$MCP_CONFIG_FILE.backup"
fi

# ────────────────────────────────
# Create MCP Config Template
# ────────────────────────────────

cat > "$MCP_CONFIG_FILE" << 'EOF'
{
  "mcpServers": {
    "taskmaster-ai": {
      "command": "npx",
      "args": ["-y", "task-master-ai"],
      "env": {
        "ANTHROPIC_API_KEY": "",
        "PERPLEXITY_API_KEY": "",
        "OPENAI_API_KEY": "",
        "GOOGLE_API_KEY": ""
      }
    }
  }
}
EOF

echo "→ Created mcp.json template at: $MCP_CONFIG_FILE"
echo ""

# ────────────────────────────────
# Instructions
# ────────────────────────────────

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Next Steps:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. ✅ Complete one-click installation in Cursor (if not done)"
echo ""
echo "2. 🔑 Add your API keys to: $MCP_CONFIG_FILE"
echo "   Edit the file and add your keys:"
echo "   - ANTHROPIC_API_KEY (required for Claude)"
echo "   - PERPLEXITY_API_KEY (optional, for search)"
echo "   - OPENAI_API_KEY (optional)"
echo "   - GOOGLE_API_KEY (optional)"
echo ""
echo "3. ⚙️  Enable Task Master in Cursor:"
echo "   - Open Cursor Settings (Cmd+,)"
echo "   - Go to 'MCP' tab"
echo "   - Enable 'taskmaster-ai' toggle"
echo ""
echo "4. 🚀 Initialize Task Master in your project:"
echo "   - Open Cursor AI chat"
echo "   - Type: 'Inicializar taskmaster-ai no meu projeto'"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Documentation: https://docs.task-master.dev/"
echo "🌐 Website: https://www.task-master.dev/"
echo ""

echo "=============================================="
echo "============== [12] DONE ===================="
echo "=============================================="
echo "▶ Next, run: bash 13-configure-cursor.sh"


