# version: 4.0.0

Module: version-bump-procedure.md
Purpose: Defines workspace documentation and operational rules for version-bump-procedure.
Path: D:/Git_Repositories/Workspace_GC/docs/version-bump-procedure.md
Authors: Rolf
Version: 4.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

BUMP-MAJOR
- condition: breaking structural change
- effect: MAJOR+1, MINOR=0, PATCH=0

BUMP-MINOR
- condition: new non-breaking feature
- condition: new durable-memory file
- effect: MINOR+1, PATCH=0

BUMP-PATCH
- condition: revision-cycle
- condition: corrections
- condition: metadata updates
- effect: PATCH+1

REVISION-CYCLE
- rule: patch-only increments
- rule: no MAJOR or MINOR changes

DURABLE-MEMORY
- rule: increment version on any change
- rule: maintain MAJOR parity with instructions.md

VARIABLE-MEMORY
- rule: patch-only increments
