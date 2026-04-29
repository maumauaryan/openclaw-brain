# Auto-Populating Data System

**Purpose:** Make all sub-nodes stay connected and automatically update with new data

---

## Auto-Update Mechanism

### When New Data Arrives
1. **Extract** key points from new information
2. **Route** to appropriate sub-node file
3. **Update** wikilink connections
4. **Commit** to git → push to GitHub
5. **Windows Obsidian** pulls → graph updates automatically

---

## Node Types & Auto-Flow

### **Source Nodes** (Input)
- `agency-core-context` ← Master decisions
- `data-extraction-comprehensive` ← Raw data dumps
- `northfield-operator-kb` ← Operator blueprint
- `content-os-complete` ← Content frameworks

### **Processing Nodes** (Auto-extract)
- `agency-offers` ← Extracts pricing, offers from data-extraction
- `pricing-table` ← Extracts pricing tiers, models
- `agency-content-system` ← Extracts funnel, production, schedule
- `agency-outreach` ← Extracts templates, sequences, lead gen

### **Specialized Nodes** (Auto-refine)
- `content-hooks` ← Extracts 6 archetypes, examples
- `content-scripting` ← Extracts 5-part structure, golden rules
- `content-ideas` ← Extracts viral discovery, ideation pyramid

---

## Connection Architecture

### Hub-and-Spoke Model
```mermaid
INDEX
├── agency-core-context (source)
│   ├── agency-offers (auto)
│   ├── agency-content-system (auto)
│   └── agency-outreach (auto)
├── content-os-complete (source)
│   ├── content-hooks (auto)
│   ├── content-scripting (auto)
│   └── content-ideas (auto)
└── data-extraction-comprehensive (source)
    ├── pricing-table (auto)
    └── [sub-nodes] (auto)
```

### How Links Auto-Form
- Every extract → creates `[[wikilink]]` to source
- Refine operations → create `[[wikilink]]` to specialized nodes
- Cross-references → create bidirectional links

---

## Auto-Population Rules

### Rule 1: Extract Once, Link Forever
- Data extracted → never re-extract manually
- Update source → updates linked node
- Changes ripple through graph automatically

### Rule 2: `[[wikilinks]]` Create Connections
- Every `[[link]]` shows as edge in graph view
- Bidirectional linking (A→B creates B→A realization)
- Disconnected nodes = data isolation

### Rule 3: Memory Logs Pattern
Every update writes to `memory/`:
- What was extracted
- From which source
- Which nodes were created/updated
- Connections made

---

## Auto-Commit Flow

1. **Data inbound:** I receive new information
2. **Process:** Extract, categorize, format
3. **Route:** Create/update appropriate `.md` files
4. **Link:** Add `[[wikilinks]]` to sources and related nodes
5. **Log:** Write entry in `memory/`
6. **Commit:** Git commit with descriptive message
7. **Push:** Push to GitHub
8. **Windows pull:** Obsidian sees updates → graph reflects changes

---

## Data Integrity

### Single Source of Truth
- `agency-core-context` = philosophy, positioning, offers
- `data-extraction-comprehensive` = raw decisions, pricing, services
- `content-os-complete` = frameworks, funnels, systems
- `northfield-operator-kb` = operator vision, advantages

### Trickle-Down Architecture
Source → Sub-nodes (auto-populate)
- Changes to source cascade to children
- But children can also grow independently
- Graph shows lineage and connections

---

**Result:** Every data point is connected, queryable, and visible in the graph. Nothing is isolated.

---

Linked: [[INDEX]] | [[agency-core-context]] | [[content-os-complete]]
