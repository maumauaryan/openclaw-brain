#!/bin/bash
# config.sh - Set up all required API keys for Hermès System
# README: Fill in YOUR keys below, then run: source config.sh

# ═══════════════════════════════════════════════════════════════
# TELEGRAM (REQUIRED - Content Queue Agent)
# ═══════════════════════════════════════════════════════════════
# How to get:
#   1. In Telegram, message @BotFather: /newbot
#   2. Choose name: Clarity Content Bot
#   3. Choose username: clarity_content_bot (must end in 'bot')
#   4. BotFather gives you token like: bot123456789:ABCdefGHI...
#   5. Message @userinfobot to get your Chat ID (number)
# Put in:

export TELEGRAM_BOT_TOKEN="botYOUR_BOT_TOKEN_HERE"
export TELEGRAM_CHAT_ID="YOUR_CHAT_ID_HERE"

# ═══════════════════════════════════════════════════════════════
# NOTION (REQUIRED - Content Queue Agent)
# ═══════════════════════════════════════════════════════════════
# How to get:
#   1. Go to https://www.notion.so/my-integrations
#   2. Create integration: "Clarity Content Pipeline"
#   3. Enable: Read content, Update content, Insert content
#   4. Copy Internal Integration Token (starts with secret_)
#   5. In Notion, create database: Content Pipeline
#   6. Add properties: Title, Status, Pillar, Hook Type, etc.
#   7. Share database with your integration (Add connections)
#   8. Get database ID from URL (32 characters between / and ?)
# Put in:

export NOTION_API_KEY="secret_YOUR_NOTION_TOKEN_HERE"
export NOTION_DATABASE_ID="YOUR_DATABASE_ID_HERE"

# ═══════════════════════════════════════════════════════════════
# OPTIONAL: Instagram API (Competitor Hunter Agent - POSTPONE)
# ═══════════════════════════════════════════════════════════════
# Only needed if you want automatic competitor pool expansion
# Start with manual pool (Matt Gray, Alex Berman, etc.)

# export INSTAGRAM_APP_ID="YOUR_APP_ID"
# export INSTAGRAM_APP_SECRET="YOUR_APP_SECRET"
# export INSTAGRAM_ACCESS_TOKEN="YOUR_ACCESS_TOKEN"

# ═══════════════════════════════════════════════════════════════
# OPTIONAL: Transcript API (Video Transcriber Agent - POSTPONE)
# ═══════════════════════════════════════════════════════════════
# Only needed for automatic video transcription
# Start with manual transcription or captions
# Options: Tactiq (tactiq.io) or OpenAI Whisper

# export OPENAI_API_KEY="sk-YOUR_OPENAI_KEY_HERE"
# OR
# export TACTIQ_API_KEY="YOUR_TACTIQ_KEY_HERE"

# ═══════════════════════════════════════════════════════════════
# write keys to /home/ubuntu/.openclaw/config/api-keys.sh
# ═══════════════════════════════════════════════════════════════

mkdir -p /home/ubuntu/.openclaw/config

cat > /home/ubuntu/.openclaw/config/api-keys.sh << 'EOF'
export TELEGRAM_BOT_TOKEN="$TELEGRAM_BOT_TOKEN"
export TELEGRAM_CHAT_ID="$TELEGRAM_CHAT_ID"
export NOTION_API_KEY="$NOTION_API_KEY"
export NOTION_DATABASE_ID="$NOTION_DATABASE_ID"
EOF

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  API Keys Setup Complete                                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Keys saved to: /home/ubuntu/.openclaw/config/api-keys.sh"
echo ""
echo "ALLEL MORE NOW:"
echo "  1. Add keys to /home/ubuntu/.openclaw/config/api-keys.sh manually"
echo "  2. Or edit this script and re-run: source config.sh"
echo ""
echo "TEST TELEGRAM:"
echo "  curl -X POST \"https://api.telegram.org/bot\\$TELEGRAM_BOT_TOKEN/sendMessage\" \\\"
echo "    -d chat_id=\\$TELEGRAM_CHAT_ID \\\"
echo "    -d text=\"Clarity Hermès: Telegram connected!\""
echo ""
echo "TEST NOTION:"
echo "  Wake 'content-queue' agent in Mission Control (http://localhost:3000)"
echo ""
