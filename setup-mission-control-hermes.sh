#!/bin/bash
# Mission Control - Hermes Orchestrator Complete Setup
# This script creates agents and cron jobs in Mission Control

set -e

MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
MC_URL="http://localhost:3000"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  Hermes Orchestrator - Mission Control Setup              ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# ═══════════════════════════════════════════════════════════════
# AGENTS
# ═══════════════════════════════════════════════════════════════

echo "📋 Creating Agents..."
echo ""

# Agent 1: Orchestrator
echo "  [1/4] Creating orchestrator..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name":"orchestrator",
    "role":"coordinator",
    "soul":"Hermes Content Orchestrator -Master loop. 6-phase pipeline: HUNT→INGEST→EXTRACT→FILTER→CREATE→QUEUE. Runs daily 6AM IST. No human input required. Read HERMES_ORCHESTRATOR_SKILLS.md for pipeline spec. Uses memory_search() to read skill definitions before execution. Coordinates all agents in sequence."
  }' \
  "$MC_URL/api/agents/create" > /tmp/agent-orchestrator.json

if grep -q "id" /tmp/agent-orchestrator.json; then
  echo "      ✅ Done (ID: $(jq -r .agent.id /tmp/agent-orchestrator.json))"
else
  echo "      ⚠ Failed or already exists"
fi

# Agent 2: Competitor Hunter
echo "  [2/4] Creating competitor-hunter..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name":"competitor-hunter",
    "role":"research",
    "soul":"Competitor Hunter -Find high-punch competitor posts. Pool: @mattgray @alxberman @iamgeorgebryant @codyaskins @hormozi @chrisdo @nathanbarry @justinwelsh @contentcreatorpro @dakotalroberton. Selection: punch score > 3x average, < 48h posted, > 50K views. Skip: dance/trend, lifestyle-only. Keep: talking-head, b-roll+VO, educational, framework-reveal. Output passes to video-ingester."
  }' \
  "$MC_URL/api/agents/create" > /tmp/agent-hunter.json

if grep -q "id" /tmp/agent-hunter.json; then
  echo "      ✅ Done (ID: $(jq -r .agent.id /tmp/agent-hunter.json))"
else
  echo "      ⚠ Failed or already exists"
fi

# Agent 3: Script Generator
echo "  [3/4] Creating script-generator..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name":"script-generator",
    "role":"content",
    "soul":"Script Generator -Production-ready script generator. 6-part structure (max 80 words): HOOK→TENSION→STAKES→REFRAME→PROOF→CTA. Generates 3 hook variants, B-roll shot list (40-shot library), VO notes. Target voice: Aryan (calm, precise, founder-to-founder). Promise-free. Max 12 words per sentence. Specific > generic always."
  }' \
  "$MC_URL/api/agents/create" > /tmp/agent-script.json

if grep -q "id" /tmp/agent-script.json; then
  echo "      ✅ Done (ID: $(jq -r .agent.id /tmp/agent-script.json))"
else
  echo "      ⚠ Failed or already exists"
fi

# Agent 4: Insight Analyzer
echo "  [4/4] Creating insight-analyzer..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name":"insight-analyzer",
    "role":"analysis",
    "soul":"Insight Analyst -Root cause analysis for content performance. 4 layers: Hook anatomy (8-type framework), Story structure (6-part), Retention engineering (patterns < =12- per minute), Root cause identification. Brand rules: REJECT hustle culture, fake urgency, bro energy, tips-creator. YES to clarity, challenging assumptions, specific founder types, thinking partner positioning. Translate competitor angle to Aryan voice."
  }' \
  "$MC_URL/api/agents/create" > /tmp/agent-analyst.json

if grep -q "id" /tmp/agent-analyst.json; then
  echo "      ✅ Done (ID: $(jq -r .agent.id /tmp/agent-analyst.json))"
else
  echo "      ⚠ Failed or already exists"
fi

echo ""
echo "✅ Agents created (or already existed)"
echo ""

# ═══════════════════════════════════════════════════════════════
# CRON JOBS
# ═══════════════════════════════════════════════════════════════

echo "🕐 Creating Cron Jobs..."
echo ""

# Job 1: Daily Content Pipeline
echo "  [1/4] Creating Daily Content Pipeline (6AM IST)..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title":"Daily Content Pipeline",
    "description":"Execute full Hermes content intelligence pipeline: HUNT competitor posts → INGEST transcripts → EXTRACT insights → FILTER for brand → CREATE scripts → QUEUE for review",
    "schedule":"every morning at 6am",
    "assigned_to":"orchestrator",
    "priority":"high",
    "timezone":"Asia/Kolkata"
  }' \
  "$MC_URL/api/cron" > /tmp/cron-daily.json

if grep -q "id" /tmp/cron-daily.json; then
  echo "      ✅ Done"
else
  echo "      ⚠ Failed or already exists"
fi

# Job 2: Weekly Synthesis
echo "  [2/4] Creating Weekly Synthesis (Sunday 8PM IST)..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title":"Weekly Content Synthesis",
    "description":"Analyze weekly performance, identify patterns, rewrite SKILL files to compound intelligence. The self-improvement loop.",
    "schedule":"every Sunday at 8pm",
    "assigned_to":"orchestrator",
    "priority":"medium",
    "timezone":"Asia/Kolkata"
  }' \
  "$MC_URL/api/cron" > /tmp/cron-weekly.json

if grep -q "id" /tmp/cron-weekly.json; then
  echo "      ✅ Done"
else
  echo "      ⚠ Failed or already exists"
fi

# Job 3: Expand Competitor Pool
echo "  [3/4] Creating Competitor Pool Expansion (9AM IST)..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title":"Expand Competitor Pool",
    "description":"Search trending content space, identify new accounts punching above weight, add to competitor pool for monitoring",
    "schedule":"every morning at 9am",
    "assigned_to":"competitor-hunter",
    "priority":"low",
    "timezone":"Asia/Kolkata"
  }' \
  "$MC_URL/api/cron" > /tmp/cron-pool.json

if grep -q "id" /tmp/cron-pool.json; then
  echo "      ✅ Done"
else
  echo "      ⚠ Failed or already exists"
fi

# Job 4: Memory Sync
echo "  [4/4] Creating Memory Sync (every 30 min)..."
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title":"Memory Sync",
    "description":"Sync OpenClaw MEMORY.md and memory/YYYY-MM-DD.md to Mission Control, Hermes, and shared memory",
    "schedule":"every 30 minutes",
    "priority":"medium"
  }' \
  "$MC_URL/api/cron" > /tmp/cron-memory.json

if grep -q "id" /tmp/cron-memory.json; then
  echo "      ✅ Done"
else
  echo "      ⚠ Failed or already exists"
fi

echo ""
echo "✅ Cron jobs created (or already existed)"
echo ""

# ═══════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    SETUP COMPLETE                             ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "🎯 What Was Created:"
echo "  └─ 4 Agents: orchestrator, competitor-hunter, script-generator, insight-analyzer"
echo "  └─ 4 Cron Jobs: Daily Pipeline, Weekly Synthesis, Pool Expansion, Memory Sync"
echo ""
echo "📊 View in Mission Control:"
echo "  └─ Agents Panel: http://localhost:3000 (Agents tab)"
echo "  └─ Cron Panel: http://localhost:3000 (Cron tab)"
echo ""
echo "🔄 Next Steps:"
echo "  1. Configure Zapier apps: npx mcporter call zapier.get_configuration_url()"
echo "  2. Set up Notion Content Pipeline database ID in orchestrator config"
echo "  3. Test agents manually: Agents panel → Wake agent with test message"
echo "  4. Review cron jobs: Cron panel → Check schedules"
echo ""
echo "📚 Documentation:"
echo "  └─ HERMES_ORCHESTRATOR_SKILLS.md: Full pipeline specification"
echo "  └─ MISSION_CONTROL_SETUP.md: Complete integration guide"
echo ""
echo "✅ Ready to automate!"
echo ""
