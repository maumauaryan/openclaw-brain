# Remote Browser Setup — API Keys Configured

**API Keys Stored:**
- BROWSER_USE_API_KEY: `bu_cmhsxWt8EVSOlLvOtVHipwF4ICR2M2rEa4Fhm79hka0` (Browser Use Cloud)
- BRIGHT_DATA_API_KEY: `333e937c-6ab3-42fb-8a3c-09c9845489e0` (Scraping Graph)
- SCRAP_GRAPH_AI_API_KEY: `sgai-ba34a05d-638d-46aa-b84c-42ea404f67c9` (Scraping Graph AI)
- SGAI (sgai-ba34a05d-638d-46aa-b84c-42ea404f67c9)

---

## Current Status

✅ API Keys configured in `~/.profile`
✅ Browser Harness v0.1.0 installed
✅ Skill linked to Claude Code/Codex
❌ Local Chromium CDP not ready (headless server limitation)

---

## Remote Browser Solution

### Why Remote Browsers
- No local Chrome needed (no X11 / display required)
- US/UK server (faster, no geoblocking on US content)
- Built-in proxy and captcha solving
- 3 concurrent browsers on free tier
- Persistent profiles (cookies, logins)

### Setup Commands

```bash
# Source API keys
source /home/ubuntu/.profile

# Test remote browser daemon
cd ~/Developer/browser-harness
browser-harness -c '
start_remote_daemon("work", proxyCountryCode="us", timeout=120)
'
```

### What This Gives You

**Playwright-like capabilities via Browser Harness + Cloud Browser:**
- Navigate to any site
- Extract data via Scrape Graph + Bright Data
- Execute JavaScript
- Scroll, click, interact
- Screenshots, PDF exports
- Persistent sessions

---

## For Playwright Equivalent

If you need Playwright specifically, you'll need:
1. Setup: `sudo apt install nodejs npm python3-venv`
2. `python3 -m venv ~/venv`
3. `source ~/venv/bin/activate`
4. `pip install playwright`
5. `playwright install chromium`

Then use pure Playwright scripting instead of Browser Harness.

---

## Integration with Knowledge Graph

When remote browsers work:
1. Scrape competitor frameworks → [[content-ideas]]
2. Extract pricing structures → [[pricing-table]]
3. Capture engagement patterns → [[agency-content-system]]
4. Analyze video performance → [[content-hooks]]

---

**API keys are stored and ready.** Remote browser system can be activated when needed.

---

Linked: [[browser-harness-setup]] | [[INDEX]] | [[agency-content-system]]
