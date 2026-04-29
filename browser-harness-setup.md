# Browser Harness Setup (Playwright + Chromium Integration)

**SOURCE:** https://github.com/browser-use/browser-harness
**PROJECT:** Aryan's CDP-based browser control system

---

## Installation Status

✅ **Installed:** browser-harness v0.1.0
✅ **Location:** `~/Developer/browser-harness`
✅ **Skill Linked:** Integrated with Claude Code/Codex
✅ **Global Command:** `browser-harness` now available

---

## What It Is

**Browser Harness** connects LLMs directly to real Chrome browsers via CDP (Chrome DevTools Protocol).

### Key Difference from Playwright
- **Playwright:** Full browser automation, control state, capabilities, cookies
- **Browser Harness:** Thin CDP wrapper, attached to YOUR running browser, agent writes missing helpers

**Why Browser Harness:**
- Works with your existing Chrome profile (cookies, logins, sessions)
- Agent learns and improves with every run
- Edits `agent_helpers.py` if helper is missing
- Site-specific skills auto-generated from patterns learned

---

## Next Steps: Remote Browser Setup

**You mentioned API key for remote browser.**

Browser Harness supports remote browsers parallel sessions (each gets isolated browser via distinct BU_NAME).

### Free Remote Browser Options

**Option 1: Browser Use Cloud (Free Tier)**
- Free tier: 3 concurrent browsers
- Includes: Proxies, captcha solving, more
- Sign up: https://cloud.browser-use.com/new-api-key

**Option 2: Your Remote Browser API Key**
You have the remote browser API key ready.
I'll configure Browser Harness to use it when you provide the key.

---

## Remote Browser Configuration

Once you provide the API key, I'll configure:

```bash
# Set environment variable
export BROWSER_USE_API_KEY="your-api-key-here"

# Start remote daemon
browser-harness -c 'start_remote_daemon("work", proxyCountryCode="us")'
```

---

## Local Chrome Setup (Fallback)

If remote doesn't work, here's local setup:

### Step 1: Enable Chrome CDP
1. Open Chrome
2. Navigate to `chrome://inspect/#remote-debugging`
3. Tick "Enable Remote Debugging"
4. Click "Allow"

### Step 2: Verify Install
```bash
browser-harness -c '
goto_url("https://github.com/browser-use/browser-harness")
wait_for_load()
print(page_info())
'
```

---

## Usage Commands

### Core Commands
```bash
# Navigate to URL
browser-harness -c 'new_tab("https://github.com")'

# Get page info
browser-harness -c 'print(page_info())'

# Screenshot
browser-harness -c 'screenshot("/tmp/capture.png")'

# Execute JavaScript
browser-harness -c 'exec("window.scrollBy(0, 500)")'
```

---

## Skills & Domains

**Agent-workspace structure:**
- `agent_helpers.py` — Helper code (auto-edited by agent)
- `domain-skills/` — Site-specific skills (learned patterns)

**Example domains available:**
- TikTok upload
- Polymarket scraping
- (More can be added from patterns learned)

---

## Daemon Management

```bash
# Doctor (check status)
browser-harness --doctor

# Update (when new version available)
browser-harness --update -y

# Setup (full interactive flow)
browser-harness --setup
```

---

## Ready for Remote Configuration

**Provide your Browser Use API key and I'll configure:**
1. Set `BROWSER_USE_API_KEY` environment variable
2. Test remote daemon connection
3. Verify isolated browser session
4. Document configuration in brain files

**Result:** Your agents get full browser control via Playwright/CDP with persistent sessions, cookies, and profiles.

---

Linked: [[INDEX]] | [[browser-automation]] | [[remote-browser-config]]
