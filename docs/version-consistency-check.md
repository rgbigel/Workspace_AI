# version: 4.1.0

Module: version-consistency-check.md
Purpose: Defines workspace documentation and operational rules for version-consistency-check.
Path: D:/Git_Repositories/Workspace_AI/docs/version-consistency-check.md
Authors: Rolf
Version: 4.1.0
Changelog:
- 2026-08-15: Bumped to LCM pre-release Version 4.1.0.
- 2026-07-27: Normalized Markdown metadata header.

CHECK: MAJOR-VERSION
- instructions.md
- config.json
- agent.json
- copilot365-agent.json
- macro-definitions.md
- MyTools.md
EXPECT: identical MAJOR

CHECK: MINOR-VERSION
- durable-memory: may differ
EXPECT: non-breaking differences allowed

CHECK: PATCH-VERSION
- revision-cycle: patch-only increments
EXPECT: patch increments only

CHECK: VARIABLE-MEMORY
- problems.md
- projects.md
- servicing-notes.md
EXPECT: patch-only versioning

CHECK: VERSION-FORMAT
EXPECT: MAJOR.MINOR.PATCH

CHECK: VERSION-ORDER
EXPECT: no skipped numbers
