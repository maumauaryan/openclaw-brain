# Hermes Content Orchestrator Skills — Full Specification

## Overview

An autonomous content intelligence pipeline that:
1. Hunts competitor posts (punching above weight)
2. Transcripts + extracts insights
3. Filters for brand alignment
4. Generates production-ready scripts
5. Queues for review in Notion
6. Self-rewrites weekly (compounding intelligence)

---

## Skill Files Breakdown

### 1. ORCHESTRATOR.md
- **Type**: Core Engine
- **Badge**: CORE ENGINE
- **Execution**: Pipeline (master loop)
- **Trigger**: Daily 6AM IST + on-demand
- **Purpose**: Coordinates all phases, no human input required

**Pipeline Flow**:
```
competitor-hunter (HUNT)
  ↓ Find 3-5 competitor posts (punching above weight)
  
video-ingester (INGEST)
  ↓ Download transcripts, spoken hooks, visual data
  
insight-extractor (EXTRACT)
  ↓ Hook anatomy, story structure, retention patterns, root cause
  
brand-filter (FILTER)
  ↓ Test against brand rules, transform to Aryan's voice
  
script-generator (CREATE)
  ↓ 6-part structure, 3 hooks, b-roll shots, VO notes
  
content-queue (QUEUE)
  ↓ Stage in Notion, notify Aryan, manage workflow
```

**Daily Output**:
- Telegram message with: posts analysed, patterns extracted, scripts queued
- Link to Notion Content Pipeline
- Top pattern summary

---

### 2. competitor-hunter/SKILL.md
- **Type**: Phase 1
- **Badge**: PHASE 1
- **Browser**: Local chromium (public) | Cloud (gated)
- **Purpose**: Find posts punching above follower weight

**Target Pool** (seed list, expands weekly):
- @mattgray (content systems, operator positioning)
- @alxberman (agency outreach, cold DM)
- @iamgeorgebryant (relationship-first marketing)
- @codyaskins (sales, DM conversion)
- @hormozi (value framing, offer architecture)
- @chrisdo (freelance → agency)
- @nathanbarry (audience building, newsletter)
- @justinwelsh (linkedin → IG systems)
- @contentcreatorpro (content strategy teaching)
- @dakotalrobertson (ghostwriting, thought leadership)

**Selection Criteria**:
- Punch score = views / followers
- > 3x average = HIGH priority
- Posted < 48 hours
- Skip: dance/trend audio, lifestyle-only, < 50K views
- Keep: talking-head, b-roll+VO, educational, framework-reveal

**Output Per Post**:
- Handle, URL, views, followers, punch score, posted time, format, topic signal
- Pass to: video-ingester

---

### 3. video-ingester/SKILL.md
- **Type**: Phase 2
- **Badge**: PHASE 2
- **Browser**: Cloud (video platforms)
- **Purpose**: Extract maximum data from each post

**Transcript Extraction** (priority order):
1. Tactiq / Speak AI (preferred)
2. DownloadHelper + Whisper API
3. Manual frame analysis (fallback)

**Data Extracted**:
```yaml
post_id, source, url, duration_seconds
spoken_hook: first full sentence
hook_duration_seconds
full_transcript: complete word-for-word
key_timestamps: hook, reframe, CTA
visual_data: frame_0s, frame_3s, overlay_text, b_roll_types
audio_data: music, pacing, tone
performance: views, punch_score, posted
```

**Storage**: `D:\openclaw-obsidian\memory\ingested\[handle]-[date].yaml`
**Pass to**: insight-extractor

---

### 4. insight-extractor/SKILL.md
- **Type**: Phase 3
- **Badge**: PHASE 3
- **Purpose**: Identify WHY a post performed (root cause analysis)

**Analysis Framework**:

**Layer 1 - Hook Anatomy**:
- Which of 8 types (contrarian, curiosity gap, bold claim, question, story, number, warning, observation)
- Implicit promise
- Pattern interrupt
- Hook score 1-10

**Layer 2 - Story Structure**:
Map to 6-part structure:
- 01 HOOK (0–3s)
- 02 TENSION (3–10s)
- 03 STAKES (10–20s)
- 04 REFRAME (20–40s) - belief shift
- 05 PROOF (40–60s)
- 06 CTA (final)

**Layer 3 - Retention Engineering**:
- Pacing: cut frequency, music drops, overlay timing
- Curiosity loops: open + resolved?
- Pattern interrupts: camera, b-roll, music, text (8-12/60s = high retention)

**Layer 4 - Root Cause**:
ONE primary driver (hook, pattern interrupt, reframe, specificity, tension, pacing, visual+spoken contradiction)

**Output**:
- Hook type, score, implicit promise, pattern interrupt
- Structure parts present/missing
- Reframe line + timestamp
- Retention patterns found (N/12)
- Root cause (one sentence)
- Usable for Aryan? YES/PARTIAL/NO
- Pass to: brand-filter

---

### 5. brand-filter/SKILL.md
- **Type**: Phase 3B
- **Badge**: PHASE 3B
- **Purpose**: Translate competitor insights to brand-aligned opportunities

**Hard Filter - REJECT if**:
- Hustle culture language ("grind", "wake up at 4am")
- Fake urgency ("you MUST do this NOW")
- Tips/tricks account positioning
- Bro-marketing energy
- Results without mechanism
- Generic opener ("most people don't know")
- Emojis in voiceover
- Talking AT viewer vs. thinking WITH

**KEEP if**:
- Creates clarity on confusing concepts
- Challenges widely-held assumption with evidence
- Names specific founder type (not generic "entrepreneurs")
- Positions as thinking partner
- Restraint in language
- Believable from $10K/month agency founder

**Translation Framework**:
```
Competitor: "3 ways to grow your Instagram"
→ Aryan: "Why the founders I work with had 50K followers and zero clients"

Competitor: "How I made $100K in 60 days"
→ Aryan: "The one positioning shift that changed how founders look online—without posting more"
```

**Output**:
- Original angle vs. Translated angle
- Hook opportunity, Reframe to use
- Target founder type (specific)
- Content pillar: clarity/restraint/authority/systems/outreach
- Confidence score 1-10
- Pass to: script-generator

---

### 6. script-generator/SKILL.md
- **Type**: Phase 4
- **Badge**: PHASE 4
- **Purpose**: Generate production-ready scripts (max 80 words)

**Input Required**:
- Translated angle from brand-filter
- Hook opportunity line
- Target founder type
- Content pillar

**6-Part Structure** (mandatory):
1. HOOK (max 10 words) - pattern interrupt + implicit promise
2. TENSION (10-15 words) - name specific problem for specific founder
3. STAKES (10-15 words) - concrete consequence
4. REFRAME (15-20 words) - belief shift (MOST IMPORTANT LINE)
5. PROOF (10-15 words) - example, number, observation
6. CTA (5-8 words) - soft, not pushy

**TOTAL: max 80 words spoken**

**Hook Generation**: 3 variants (contrarian, curiosity, warning), score 1-10, pick strongest

**B-Roll Shot List** (from 40-shot library):
- Hook shot (0s): most pattern-interrupting
- Tension shot (3-8s): visualizes problem
- Reframe shot (main): thinking/depth/authority
- Proof shot: execution (not performance)
- CTA shot: natural end

**Voiceover Notes**:
- Tone: calm/precise/slightly direct (never hyped)
- Pace: slow at hook, pause before reframe, faster through proof
- Pause markers: 0.5s after hook, 1s before reframe, 0.5s after reframe
- Recording: Boya BY-M1, 3 takes, export WAV

**Output Format**:
- 3 hook options with scores
- Full 6-part script
- Word count (max 80)
- B-roll shots with timings
- VO notes (tone, key line, pauses)
- Pass to: content-queue

---

### 7. content-queue/SKILL.md
- **Type**: Phase 5
- **Badge**: PHASE 5
- **Purpose**: Stage scripts in Notion, notify Aryan, manage workflow

**Notion Content Pipeline Schema**:
```
Database: Content Pipeline
Fields:
- Title, Status (QUEUED→REVIEWED→APPROVED→SCHEDULED→POSTED→ANALYSED)
- Pillar, Hook type, Source, Insight score
- Hook options, Script, B-roll, VO notes
- Scheduled date, Post time, Views (7 day), Notes
```

**Staging Flow**:
1. Create page in Content Pipeline database
2. Populate all fields
3. Status: QUEUED
4. Tag: "HERMES-GENERATED"
5. Update MEMORY
6. Send Telegram notification

**Telegram Format**:
```
🎬 [N] script(s) queued — [Date]
Top pick: "[selected hook]"
Type: [type] | Pillar: [pillar]
Source: @[handle]
Review in Notion → [link]
```

**Post-Approval Actions**:
- Move to SCHEDULED
- Auto-assign slot: weekdays 7-9AM or 6-8PM US EST (ICP priority)
- Send confirmation

**Post-Performance Tracking** (7 days after posting):
- Pull view count
- Note comments, saves, DMs
- Update Notion: views, punch score
- Log to MEMORY
- Flag high-performers (> 50K views) → weekly-synthesis

---

### 8. self-rewriter/SKILL.md
- **Type**: Meta
- **Badge**: META
- **Execution**: Sunday 20:00 IST only
- **Purpose**: Analyse performance → rewrite SKILL files → compounding intelligence

**Execution**:
```
PASS 1 — Read performance data
→ MEMORY entries from this week
→ Notion entries with status: ANALYSED
→ Top hook types, weakest elements, best competitors

PASS 2 — Pattern extraction
→ Top hook type
→ Top competitor account
→ Weakest script element (from reviews)
→ Most-rejected insight type
→ Fastest-growing topic

PASS 3 — Rewrite SKILL files
  - competitor-hunter: add new accounts, remove zeros
  - insight-extractor: update scoring benchmarks
  - script-generator: update hook examples
  - brand-filter: tighten translation examples

PASS 4 — Write weekly synthesis to MEMORY

PASS 5 — Telegram weekly report
```

---

## Setup Requirements

### Dependencies
```bash
npm install -g @openai/whisper-api yt-dlp-wrap playwright
pip install openai-whisper yt-dlp --break-system-packages
playwright install chromium
```

### Directory Structure
```
D:\openclaw-obsidian\
├── skills\
│   ├── competitor-hunter\
│   ├── video-ingester\
│   ├── insight-extractor\
│   ├── brand-filter\
│   ├── script-generator\
│   ├── content-queue\
│   └── self-rewriter\
├── memory\
│   ├── ingested\
│   ├── performance\
│   └── competitor-pool.json
├── orchestrator.config.json
└── orchestrator\
```

### Configuration
- Vault path: `D:\openclaw-obsidian`
- Schedule: Daily 6AM IST, Weekly Synthesis Sunday 8PM IST
- Competitor pool: 8 seed accounts (expands weekly)
- Notion database ID: (paste your DB ID)
- Transcript method: Whisper

---

## Cost & Limits

- Daily limit: $3.00 USD
- Alert at: $2.50 USD
- Models: Claude Sonnet (hunt/queue), Claude Opus (extract/generate/synthesis)

---

## Memory Integration

All skills read/write MEMORY.md and memory/YYYY-MM-DD.md:
- Daily logs of performance
- Competitor pool updates
- Pattern extraction results
- Weekly synthesis reports

---

## Zapier MCP Integration

**Connection URL**: https://mcp.zapier.com/api/v1/connect

**Setup**:
1. `npx -y mcporter`
2. `mcporter config add zapier --url "https://mcp.zapier.com/api/v1/connect" --header "Authorization=Bearer [token]" --client-name "openclaw"`
3. `mcporter list zapier --schema`

**Purpose**: 
- Trigger workflows from content queue (new script → send to Slack)
- Send Telegram notifications programmatically
- Track performance data in external systems

---

## Ready for Mission Control Setup

- ✅ 8 skill files defined
- ✅ Pipeline flow mapped
- ✅ Dependencies listed
- ✅ Configuration requirements documented
- ✅ Memory integration points identified
- ✅ Zapier MCP connection details provided

Next Step: Mission Control integration (cron jobs, subagents, workflows)
