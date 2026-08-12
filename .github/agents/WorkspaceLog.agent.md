---
name: "WorkspaceLog"
description: "Generate a governed, human-readable log of Workspace_AC agent activity. Summarizes FIX, DOX, APPLY, RULE, AGENT, and S2 governance operations into .copilot/Logs/Workspace_AC.log."
tools: [read, search, edit]
argument-hint: "No arguments. The agent scans FIX logs, S1 logs, DOX files, Workspace-Rules, and agent metadata, then writes a unified governance log."
user-invocable: true
---

# WorkspaceLog Agent
This agent produces a deterministic, human-readable governance log for Workspace_AC.
It consolidates FIX chain results, DOX unification steps, S2 governance entries, action-marker resolutions, version bumps, and agent operations into a single file:

- `.copilot/Logs/Workspace_AC.log`

The log is ASCII-only, CRLF-normalized, and stable across runs.

## Scope
The agent reads:
- `.copilot/Logs/Fix_*.log`
- `.copilot/History/Logs/S1.log`
- `.copilot/History/Logs/S2.log`
- `.copilot/VSCode_Agent.md`
- `.copilot/Fixes/*.json`
- `.copilot/Rules/*.md`
- `.github/agents/WorkspaceAgentIndex.md`
- `.github/agents/DOX.agent.md`
- `Workspace-Rules.md`

It extracts:
- FIX module IDs, timestamps, and summaries
- S2 governance IDs, timestamps, status, and summaries
- DOX unification versions and changelog entries
- action-marker creation and resolution events
- Workspace-Rules version bumps
- Agent index updates
- Loader method creation (LoadAtoms.ps1, LoadFixes.ps1, LoadMethods.ps1)
- Invariant normalization results
- Structural quality-check results

## Output Rules
1. The agent MUST write the complete `.copilot/Logs/Workspace_AC.log` file on each invocation.
2. The log MUST be ASCII-only.
3. The log MUST use CRLF line endings.
4. The log MUST include timestamps in `YYYY-MM-DD HH:MM:SS` format.
5. The log MUST include FIX, DOX, APPLY, RULE, and S2 governance summaries in chronological order.
6. The log MUST NOT include VS Code internal workspaceStorage logs.
7. The log MUST NOT include partial diffs or code snippets.
8. The log MUST NOT alter any other files.

## Log Structure
The log file MUST contain the following sections:

### 1. Header
- Workspace name
- Current DOX version
- Current Workspace-Rules version
- Current agent index version
- Timestamp of log generation

### 2. FIX Chain Summary
For each FIX module:
- FIX ID (e.g., S1E01)
- Timestamp
- Summary from Fix_*.log
- Invariant scan result
- JSON parse result
- Any created files

### 3. S1 Log Summary
- Ordered list of S1 entries
- Timestamps
- Acceptance status

### 4. DOX Unification Summary
- DOX version bumps
- DOX.agent.md updates
- WorkspaceAgentIndex.md updates
- Workspace-Rules.md updates
- action-marker creation and resolution
- Validation results

### 5. S2 Governance Summary
- Ordered list of S2 governance entries
- Timestamps
- Status
- Notes

### 6. Loader Method Summary
- LoadAtoms.ps1 creation
- LoadFixes.ps1 creation
- LoadMethods.ps1 creation

### 7. Workspace-Rules Summary
- Version bumps
- Changelog entries
- DOX alignment status

### 8. Final Validation
- Invariant scan: OK / issues
- JSON parse: OK / issues
- PowerShell parse: OK / issues

### 9. Footer
- "WorkspaceLog generation complete."
- Timestamp

## Behavior
When invoked, the agent:
1. Reads all FIX logs.
2. Reads S1.log and S2.log.
3. Reads DOX.agent.md, WorkspaceAgentIndex.md, Workspace-Rules.md.
4. Extracts version numbers and changelog entries.
5. Synthesizes a unified governance log.
6. Writes `.copilot/Logs/Workspace_AC.log`.

END OF FILE
