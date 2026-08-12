# Workspace Location Rules (Corrected)

Module: Workspace-Location.md
Purpose: Defines workspace documentation and operational rules for Workspace-Location.
Path: D:/Git_Repositories/Workspace_GC/docs/Workspace-Location.md
Authors: Rolf
Version: 4.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

All Workspace paths MUST be absolute and MUST reference the canonical root:

`D:/Git_Repositories/Workspace_GC`

The Workspace MUST NOT contain localized folder names. All directory names MUST be ASCII-only.
- D:\Git_Repositories

The `.copilot` directory is the authoritative control directory for Workspace rules, invariants, tools, and agent definitions.
COPILOT-DIRECTORY
- path: D:\Git_Repositories\Workspace_GC\.copilot\
- purpose: authoritative control files
- rule: all profile behavior scoped to workspace-root

All Workspace documentation MUST use deterministic ASCII-only Markdown. UTF-8 without BOM is mandatory.
COPILOT-FILES
- instructions.md
- config.json
- agent.json
- copilot365-agent.json
- MEMORY.md
- macro-definitions.md
- MyTools.md
- InvariantRules.md
- Standards.md
- version-consistency-check.md
- version-bump-procedure.md
- problems.md
- projects.md
- servicing-notes.md

TEST-SUITE
- directory: .copilot/tests\
- file: profile-tests.md

WORKSPACE-RULES
- durable-memory must reside under workspace-root
- variable-memory must reside under workspace-root
- no external paths allowed
- ascii-only filenames
- english-only filenames

VS-CODE-INTEGRATION
- workspace-root must be opened directly in VS Code
- .copilot directory must be at workspace-root level
