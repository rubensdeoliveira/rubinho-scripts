#!/usr/bin/env bash

set -e

echo "=============================================="
echo "===== [12a] INSTALLING TASK MASTER (MCP) ====="
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
echo "2. 🤖 Get Anthropic API Key (for Claude):"
echo "   - Visit: https://console.anthropic.com/"
echo "   - Sign in or create account"
echo "   - Go to Settings → API Keys"
echo "   - Create a new key and copy it"
echo ""
echo "3. 🔑 Add your API keys to: $MCP_CONFIG_FILE"
echo "   Edit the file and add your keys:"
echo "   - ANTHROPIC_API_KEY (REQUIRED for Claude)"
echo "   - PERPLEXITY_API_KEY (optional, for search)"
echo "   - OPENAI_API_KEY (optional)"
echo "   - GOOGLE_API_KEY (optional)"
echo ""
echo "   Example:"
echo "   nano $MCP_CONFIG_FILE"
echo ""
echo "4. ⚙️  Configure Claude in Cursor:"
echo "   - Open Cursor Settings (Cmd+,)"
echo "   - Go to 'Features' or 'AI' tab"
echo "   - Select Claude/Anthropic as AI provider"
echo "   - Or in AI chat, select 'claude-3-5-sonnet' model"
echo ""
echo "5. 🔌 Enable Task Master in Cursor:"
echo "   - Open Cursor Settings (Cmd+,)"
echo "   - Go to 'MCP' tab"
echo "   - Enable 'taskmaster-ai' toggle"
echo "   - Restart Cursor (recommended)"
echo ""
echo "6. 🚀 Initialize Task Master in your project:"
echo "   - Open Cursor AI chat (Cmd+L)"
echo "   - Make sure Claude model is selected"
echo "   - Type: 'Inicializar taskmaster-ai no meu projeto'"
echo "   - Or: 'Initialize taskmaster-ai in my project'"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📚 Full Guide: See CURSOR_CLAUDE_TASKMASTER.md"
echo "📖 Taskmaster Docs: https://docs.task-master.dev/"
echo "🌐 Taskmaster Website: https://www.task-master.dev/"
echo "🔑 Anthropic Console: https://console.anthropic.com/"
echo ""

echo "=============================================="
echo "============== [12a] DONE ===================="
echo "=============================================="
echo ""
echo "⚠️  IMPORTANT:"
echo "   1. Get your Anthropic API key: https://console.anthropic.com/"
echo "   2. Add it to: $MCP_CONFIG_FILE"
echo "   3. Configure Claude in Cursor Settings"
echo "   4. Enable Task Master in Cursor → MCP tab"
echo ""
echo "📖 For detailed instructions, see: CURSOR_CLAUDE_TASKMASTER.md"
echo ""
echo "▶ Next, run: bash 13-install-docker.sh"

