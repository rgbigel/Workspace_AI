# Module: Workspace_AI/GEMINI_INBOX_SPECIFICATION
# Purpose: Authoritative specification for Google Gemini Cloud & Gem inbox message formatting and intake security.
# Path: Workspace_AI/docs/GEMINI_INBOX_SPECIFICATION.md
# Authors: Rolf, Workspace_AI Engine
Version: 7.0.0
# Date: 2026-08-30

# Gemini Cloud to LCM Inbox Specification

This document defines the authoritative protocol, timestamping invariant, and message schemas for files placed into `D:\GDrive\LCM\INBOX/` by Google Gemini (Cloud, Gems, or Web).

---

## 1. Security & Lifecycle Governance Invariant

1. **Controlled Ingestion Only**: Any file dropped into `D:\GDrive\LCM\INBOX/` is treated as **untrusted suggested input**. It is **NEVER** executed immediately or allowed to mutate source files without operator authorization.
2. **Proposal & BUG Queue Routing**: The automated intake watcher (`Sync-GeminiInbox.ps1`) ingests each file into the standard LCM Proposal Ledger (`Workspace_Inventory/data/proposals/proposals.json`).
3. **Operator Control**: The user reviews all ingested items via standard tools (`GetOpenProposals.cmd`, `ProposalAction.cmd do <id>`, `defer <id>`, `delete <id>`).
4. **Clean Inbox Invariant**: Once absorbed, the intake watcher safely archives the raw item into `D:\GDrive\LCM\INBOX/archive/` and clears the active inbox.
5. **Mandatory Timestamping**: Every item submitted by Gemini `MUST` contain an explicit timestamp in ISO 8601 or standard local datetime format. Items lacking a timestamp will be flagged during intake audit logging.

---

## 2. File Naming Conventions

Files placed in `D:\GDrive\LCM\INBOX/` must follow one of these naming patterns:
- **BUG Reports**: `BUG-YYYYMMDD_HHMMSS-<short_topic>.md` (or `.txt`, `.json`)
- **Task Proposals**: `TASK-YYYYMMDD_HHMMSS-<short_topic>.md` (or `.txt`, `.json`)
- **General Inquiries / Notes**: `NOTE-YYYYMMDD_HHMMSS-<short_topic>.md`

---

## 3. Standard Markdown Template for Gemini Cloud / Gems

When configuring a Gemini Gem or prompting Gemini to output to Google Drive, use this template:

```markdown
# [TYPE: BUG | TASK | PROPOSAL]: <Concise Title>

- **Timestamp**: YYYY-MM-DD HH:MM:SS (or ISO 8601: YYYY-MM-DDTHH:MM:SS+02:00)
- **Author**: Google Gemini (Cloud Gem)
- **Target Repository**: <e.g., Workspace_AI | SystemConfiguration | tools | HaSSD06>
- **Classification**: <BUG | ENHANCEMENT | REFACTOR | AUDIT>
- **Criticality**: <LOW | MEDIUM | HIGH | CRITICAL>

---

## 1. Summary / Problem Description
<Clear and concise description of the observed issue or proposed work>

## 2. Root Cause / Technical Analysis (for BUG reports)
<Superficial root cause assessment and observed unwanted behavior>

## 3. Proposed Steps / Action Plan
- Step 1: <Description>
- Step 2: <Description>
- Step 3: <Description>

## 4. Specific Code / Configuration Snippets
```powershell
# Optional code suggestions or commands for Antigravity review
```
```

---

## 4. Alternative JSON Template

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "BUG",
  "timestamp": "2026-08-30T11:15:00+02:00",
  "author": "Google Gemini",
  "title": "Fix target path resolution in tool launcher",
  "target_repo": "tools",
  "criticality": "MEDIUM",
  "summary": "Short summary of the bug or task",
  "root_cause": "Superficial cause analysis",
  "proposed_steps": [
    "Verify path resolution",
    "Update launcher script"
  ],
  "details": "Full description and notes..."
}
```

---

## 5. Intake Watcher Mechanics (`Sync-GeminiInbox.ps1`)

1. **Detection**: Scans `D:\GDrive\LCM\INBOX/` for pending `*.md`, `*.txt`, and `*.json` files.
2. **Validation**: Validates presence of valid timestamp and parses title/classification.
3. **Queue Creation**: Invokes `New-WorkspaceProposal` to register a `suggested` proposal in `proposals.json`.
4. **Plan Preservation**: Copies full detailed analysis into `Workspace_Inventory/data/proposals/plans/`.
5. **Inbox Archiving**: Moves the processed input to `INBOX/archive/` and deletes the active inbox copy.
6. **Telemetry**: Records intake event in `.lcd/logs/Sync-GeminiInbox-*.log`.

