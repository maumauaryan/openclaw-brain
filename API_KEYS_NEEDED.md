# API Keys Required — Complete List for All Agents

## ✅ Already Configured & Working

### 1. Amazon Bedrock (LLM Provider)
- **Status:** ✅ Working
- **Provider:** OpenClaw Gateway
- **Model:** amazon-bedrock/zai.glm-4.7 (default)
- **Endpoint:** https://bedrock-runtime.us-east-1.amazonaws.com
- **Used by:** All agents (orchestrator, analyzer, generator, etc.)
- **No action needed** - Already in OpenClaw config

### 2. OpenClaw Gateway
- **Status:** ✅ Working
- **Port:** 18789
- **Token:** 0c7e5fc…3c33
- **URL:** http://127.0.0.1:18789
- **Used by:** Mission Control for agent dispatch
- **No action needed** - Already running

### 3. Mission Control
- **Status:** ✅ Working
- **Port:** 3000
- **API Key:** ebb89775…f938a
- **URL:** http://localhost:3000
- **Used by:** All internal task management
- **No action needed** - Already running

### 4. Zapier MCP
- **Status:** ✅ Connected
- **Configuration:** `mcporter config add zapier --url https://mcp.zapier.com/api/v1/connect --header Authorization=Bearer MGMyNDMyNjIwMDY2MTkzMTc...`
- **Used by:** External workflow integrations
- **Single auth token provided** - Already configured

---

## ⚠️ API Keys You Need to Provide

### 1. Telegram Bot (CRITICAL - Content Queue Agent)

**Why needed:**
- Content Queue agent sends Telegram notifications when scripts are queued
- Users get instant alerts with script drafts for approval
- Part of the real-time feedback loop

**What you need:**
1. **Telegram Bot Token** (format: `bot123456789:ABCdefGHIjklMNOpqrsTUVwxyz`)
2. **Telegram Chat ID** (format: `123456789` or group ID like `-1001234567890`)

**How to get:**

**Step 1: Create Telegram Bot**
```
1. Open Telegram app
2. Search for @BotFather
3. Send: /newbot
4. BotFather asks: Choose a name
   - Response: Clarity Content Bot
5. BotFather asks: Choose a username
   - Response: clarity_content_bot (must end in 'bot')
6. BotFather sends you API token: bot123456:ABC...
   - COPY THIS TOKEN
```

**Step 2: Get Your Chat ID**
```
1. Open Telegram app
2. Search for @userinfobot
3. Send any message (e.g., "hello")
4. UserInfobot replies with your Chat ID (e.g., 123456789)
   - COPY THIS NUMBER
```

**Where to add:**
```bash
# In HOME/ubuntu/.openclaw/workspace/config/hermes-config.yaml:
telegram:
  bot_token: "YOUR_BOT_TOKEN_HERE"
  chat_id: "YOUR_CHAT_ID_HERE"

# Or set as env vars:
export TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
export TELEGRAM_CHAT_ID="YOUR_CHAT_ID_HERE"
```

**Optional: Create a group for content team**
```
1. Create new Telegram group: "Clarity Content Queue"
2. Invite @userinfobot to group
3. Send message to group to get group Chat ID (format: -1001234567890)
4. Invite your bot to group
5. Use group Chat ID instead of personal Chat ID
```

---

### 2. Notion API (CRITICAL - Content Queue Agent)

**Why needed:**
- Content Queue agent creates Notion pages for each generated script
- Kanban-style workflow for script management (QUEUED → REVIEWED → APPROVED)
- Stores all structured data: hooks, B-roll, VO notes, scripts

**What you need:**
1. **Notion Internal Integration Token** (Secret)
2. **Notion Integration ID** (Not needed - it's the same as token)
3. **Your Content Pipeline Database ID**

**How to get:**

**Step 1: Create a Notion Integration**
```
1. Go to https://www.notion.so/my-integrations
2. Click "New integration"
3. Fill in:
   - Name: Clarity Content Pipeline
   - Associated workspace: [Select your workspace]
   - Type: Internal
   - Capabilities: Enable "Read content", "Update content", "Insert content"
4. Click "Submit"
5. Notion shows:
   - Internal Integration Token (starts with secret_...)
   - COPY THIS - it starts with secret_...
```

**Step 2: Create Content Pipeline Database in Notion**
```
1. Create a new page in Notion: "Content Pipeline"
2. Add a database: "Content Queue" (Table view recommended)
3. Add properties:
   Title → Title
   Status → Select (options: QUEUED, REVIEWED, APPROVED, SCHEDULED, POSTED, ANALYSED)
   Pillar → Select (options: POSITIONING, OUTREACH, AUTHORITY, GROWTH)
   Hook Type → Select (options according to your 8-type framework)
   Source → Text
   Insight Score → Number (1-10)
   Hook Options → Text (store all 3 variants)
   Script → Text
   B-roll Shots → Text
   VO Notes → Text
   Scheduled Date → Date
   Post Time → Text
   Created At → Date (created time formula)
   Performance → Text (metrics: views, engagement)
4. Add a column: Status (default view by this)
```

**Step 3: Get Database ID**
```
1. Open your Content Pipeline database
2. Copy the URL from browser bar
3. Example URL: https://www.notion.so/workspace/Content-Pipeline-1234567890abcdef?v=...
4. Extract the 32-character ID between slashes:
   Database ID: 1234567890abcdef1234567890abcdef
   - COPY THIS ID
```

**Step 4: Share Database with Integration**
```
1. Open your Content Pipeline database
2. Click "..." (three dots) in top-right
3. Click "Add connections"
4. Search for "Clarity Content Pipeline" (your integration name)
5. Click on it to connect
```

**Where to add:**
```bash
# In /home/ubuntu/.hermes/config.yaml or /home/ubuntu/.openclaw/workspace/config/notion-config.yaml:
notion:
  api_key: "secret_YOUR_INTEGRATION_TOKEN_HERE"  # Starts with secret_
  database_id: "YOUR_DATABASE_ID_HERE"          # 32 characters
```

---

### 3. Instagram Basic Display API (OPTIONAL - Competitor Hunter Agent)

**Why needed:**
- Competitor Hunter scrapes Instagram posts for trending content
- Extracts post data: views, likes, timestamps, content
- Required for automatic competitor pool expansion

**What you need:**
1. **Instagram Basic Display App ID** (or Professional/Creator)
2. **Instagram App Secret**
3. **Instagram Access Token**

**How to get (simplified):**

**Step 1: Create Instagram Developer Account**
```
1. Go to https://developers.facebook.com/
2. Create Meta for Developers account (free)
3. Go to Apps → Create App → Business type
4. Fill in app details → Create
```

**Step 2: Add Instagram Product**
```
1. In your app dashboard, click "Add Product"
2. Select "Instagram Basic Display"
3. Configure product settings
```

**Step 3: Get Access Token**
```
1. In Instagram Basic Display settings
2. Click "Generate Token"
3. Authorize your account
4. Copy generated token
```

**Note:** Instagram has strict rate limits and API restrictions.
**Recommended:** Start with manual competitor pool and add Instagram API later if needed.

**Where to add:**
```bash
# Export as env vars:
export INSTAGRAM_APP_ID="YOUR_APP_ID"
export INSTAGRAM_APP_SECRET="YOUR_APP_SECRET"
export INSTAGRAM_ACCESS_TOKEN="YOUR_ACCESS_TOKEN"

# Or add to config:
instagram:
  app_id: "YOUR_APP_ID"
  app_secret: "YOUR_APP_SECRET"
  access_token: "YOUR_ACCESS_TOKEN"
```

---

### 4. Tactiq / Transcript API (OPTIONAL - Video Transcriber Agent)

**Why needed:**
- Phase 2 (INGEST) requires video transcripts from Instagram/YouTube
- Tactiq can extract spoken hooks, full transcripts, timestamps
- Alternative: Use OpenAI Whisper API

**Option A: Tactiq API**

```
1. Go to https://www.tactiq.io/ (Chrome extension)
2. Install Tactiq Chrome extension
3. Sign up for Tactiq account (free tier available)
4. Get API key from account dashboard
```

**Option B: OpenAI Whisper API (Recommended)**

```
1. Go to https://platform.openai.com/api-keys
2. Create new API key
3. Scope: All models (Whisper-specific)
4. Copy key

Note: Requires OpenAI account with billing enabled
```

**Option C: Manual Fallback (Start Here)**

```
No API needed initially:
- Use video transcriptions if available on platform
- Manual transcription for high-value posts
- Prioritize content with automatic captions
```

**Where to add:**
```bash
# For Whisper API:
export OPENAI_API_KEY="sk-YOUR_OPENAI_KEY_HERE"

# For Tactiq:
export TACTIQ_API_KEY="YOUR_TACTIQ_KEY_HERE"
```

---

## 🎯 Priority Setup Order (Do This First)

### Phase 1: Immediate (Today)

1. **Telegram Bot** (5 min, free)
   - Get bot token from @BotFather
   - Get chat ID from @userinfobot
   - Add to config
   - Test: Send message to bot

2. **Notion Integration** (15 min, free)
   - Create integration at https://www.notion.so/my-integrations
   - Create Content Pipeline database in Notion
   - Connect integration to database
   - Get database ID
   - Add to config

**After Phase 1:**
- Content Queue agent will start working
- Scripts will be queued in Notion
- You'll get Telegram notifications

---

### Phase 2: Week 1-2 (Optional)

3. **Instagram API** (30 min, optional)
   - Start with manual competitor pool (Matt Gray, Alex Berman, etc.)
   - Add Instagram API if you want full automation
   - Consider rate limits and API cost

4. **Transcript API** (15 min, optional)
   - Start with manual transcription or free captions
   - Add Tactiq or Whisper API later for scale
   - Prioritize content with automatic transcriptions

---

### Phase 3: Ongoing (Optional Integration)

5. **Zapier Apps Configuration** (Configure Zapier MCP)
   - Already have MCP token
   - Run: `npx mcporter call zapier.get_configuration_url()`
   - Open URL → Add apps:
     - Slack (notifications)
     - Google Calendar (content scheduling)
     - Email (outreach automation)

---

## 📝 Quick Setup Script

After you get Telegram and Notion keys, save this to `config.sh`:

```bash
#!/bin/bash
# config.sh - Set up all required API keys

# Telegram ( REQUIRED - Content Queue )
export TELEGRAM_BOT_TOKEN="bot123456789:ABCdefGHIjklMNOpqrsTUVwxyz"
export TELEGRAM_CHAT_ID="123456789"

# Notion ( REQUIRED - Content Queue )
export NOTION_API_KEY="secret_YOUR_NOTION_TOKEN_HERE"
export NOTION_DATABASE_ID="1234567890abcdef1234567890abcdef"

# Optional - Instagram ( Competitor Hunter - OPTIONAL )
export INSTAGRAM_APP_ID="YOUR_APP_ID"
export INSTAGRAM_APP_SECRET="YOUR_APP_SECRET"
export INSTAGRAM_ACCESS_TOKEN="YOUR_ACCESS_TOKEN"

# Optional - Transcript API ( Video Transcriber - OPTIONAL )
export OPENAI_API_KEY="sk-YOUR_OPENAI_KEY_HERE"
# OR
export TACTIQ_API_KEY="YOUR_TACTIQ_KEY_HERE"

echo "All environment variables set!"
echo "Terminate with Ctrl+C, then run: source config.sh"
```

**Usage:**
```bash
# 1. Edit config.sh with your keys
vim config.sh

# 2. Source it to activate in current shell
source config.sh

# 3. Test Telegram
curl -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
  -d chat_id=$TELEGRAM_CHAT_ID \
  -d text="Clarity Content System: Telegram connected!"

# 4. Test Notion (via agent runs)
# Wake content-queue agent in Mission Control → John runs
```

---

## ✅ Summary: Minimum Required for Full Automation

### Must Have (Today):
1. ✅ Telegram Bot Token + Chat ID
2. ✅ Notion Integration Token + Database ID

That's it! With just these 2 integrations, the full Hermès automates:
- Scripts queued in Notion (Content Queue agent)
- Telegram notifications on new scripts
- Full 6-phase pipeline execution
- Weekly synthesis reports

### Nice to Have (Later):
- Instagram API for automatic competitor pool expansion
- Transcript API for video ingestion
- Zapier for Slack/Calendar/Email integration

---

## 🔗 Quick Links

- **Notion Integration:** https://www.notion.so/my-integrations
- **Telegram BotFather:** @BotFather in Telegram
- **Telegram Chat ID:** @userinfobot in Telegram
- **Instagram Developers:** https://developers.facebook.com/
- **OpenAI API Keys:** https://platform.openai.com/api-keys
- **Tactiq:** https://www.tactiq.io/

---

## 🚀 What Happens After Setup

After you add Telegram + Notion keys:

1. **Daily at 6AM IST:** Pipeline runs automatically
2. **Competitor Hunter** finds high-punch posts (manual or automatic)
3. **Video Transcriber** extracts transcripts (manual or automatic)
4. **Insight Analyzer** applies brand filters
5. **Script Generator** creates production scripts
6. **Content Queue** creates Notion page → Sends Telegram notification

**You get:**
- Email/Telegram: "3 scripts queued. Here's the top one..."
- Notion database: All scripts in organized pipeline
- Weekly report: Performance patterns + updated SKILL files

Everything automated with just 2 API keys! 🎯
