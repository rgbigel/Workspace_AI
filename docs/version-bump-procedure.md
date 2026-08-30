# version: 6.1.1

Module: version-bump-procedure.md
Purpose: Defines workspace documentation and operational rules for version-bump-procedure and LCM Major Version Alignment.
Path: D:/Git_Repositories/Workspace_AI/docs/version-bump-procedure.md
Authors: Rolf
Version: 7.1.1
Changelog:
- 2026-08-29: Updated to LCM Version 6.1.1 with M.Y.Z Major Version Alignment Invariant (RULE-DOC-005).
- 2026-08-15: Bumped to LCM pre-release Version 4.1.0.
- 2026-07-27: Normalized Markdown metadata header.

BUMP-MAJOR (LCM Workspace Release)
- condition: major lifecycle model release (e.g. v6.0.0, v7.0.0)
- effect: LCM_MAJOR+1
- rule: all contained modules/specs MUST align Major component to M while preserving Minor (Y) and Patch (Z): NewVersion = M.Y.Z
- rule: pre-push actions MUST NOT reset or wipe subversions (Y.Z)

BUMP-MINOR
- condition: new non-breaking feature or component
- condition: new durable-memory file or rule policy
- effect: MINOR+1, PATCH=0

BUMP-PATCH
- condition: revision-cycle
- condition: corrections & bug fixes
- condition: metadata updates
- effect: PATCH+1

REVISION-CYCLE
- rule: patch-only increments
- rule: no MAJOR or MINOR changes during patch cycle

DURABLE-MEMORY
- rule: increment version on any change
- rule: maintain MAJOR parity with global LCM baseline

VARIABLE-MEMORY
- rule: patch-only increments


