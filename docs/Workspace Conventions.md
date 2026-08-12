# Workspace Conventions

Module: Workspace Conventions.md
Purpose: Defines workspace documentation and operational rules for Workspace Conventions.
Path: D:/Git_Repositories/Workspace_GC/docs/Workspace Conventions.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

---
title: ? Workspace Conventions
updated: 2026-07-11T14:50:45
created: 2026-07-11T14:47:33
---

\# SECTION: workspace-location
\# FORMAT: ascii-only, copyable, no-prose
WORKSPACE-ROOT
- D:\Git_Repositories\Workspace_GC
WORKSPACE-RULES
- all copilot control files stored under ".copilot" directory
- authoritative path: D:\Git_Repositories\Workspace_GC\.copilot\
- instructions.md stored at: D:\Git_Repositories\Workspace_GC\.copilot\instructions.md
- MEMORY.md stored at: D:\Git_Repositories\Workspace_GC\.copilot\MEMORY.md
- macro-definitions.md stored at: D:\Git_Repositories\Workspace_GC\.copilot\Rules\macro-definitions.md
- test suite command: D:\Git_Repositories\Workspace_GC\tools\Test-WorkspaceGCReadiness.ps1
WORKSPACE-CONVENTIONS
- workspace root defines authoritative context
- all profile behavior is scoped to workspace root
- all durable memory files must reside under workspace root
