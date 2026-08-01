# version: 3.0.0

Module: Standards.md
Purpose: Defines workspace documentation and operational rules for Standards.
Path: D:/Git_Repositories/Workspace_AC/docs/Standards.md
Authors: Rolf
Version: 3.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

STANDARDS
- naming: ascii-only, deterministic
- structure: sections, lists, code blocks
- documentation: reproducible, rule-driven
- modules: versioned, deterministic headers
- durable-memory: strict versioning required
- variable-memory: patch-only versioning

VERSIONING-STANDARDS
- MAJOR: breaking change, structural change
- MINOR: new feature, new durable-memory file
- PATCH: corrections, additions, revision-cycle
- durable-memory: increment on any change
- variable-memory: increment PATCH only
- version-parity: all control files share MAJOR
- version-format: MAJOR.MINOR.PATCH
