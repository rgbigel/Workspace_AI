# version: 5.0.0

Module: Standards.md
Purpose: Defines workspace documentation and operational rules for Standards.
Path: D:/Git_Repositories/Workspace_AI/docs/Standards.md
Authors: Rolf
Version: 5.0.0
Changelog:
- 2026-08-20: Bumped to LCM Version 5.0.0.
- 2026-08-15: Added linking standards and designated Junction Link Magic tool.
- 2026-07-27: Normalized Markdown metadata header.

STANDARDS
- naming: ascii-only, deterministic
- structure: sections, lists, code blocks
- documentation: reproducible, rule-driven
- modules: versioned, deterministic headers
- durable-memory: strict versioning required
- variable-memory: patch-only versioning

LINKING-AND-JUNCTION-STANDARDS
- directory-junctions: used for immutable rule directories (.agents/rules/core, .copilot/Rules/core)
- file-hardlinks: used for top-level entrypoints (AGENTS.md, GEMINI.md, .copilot/instructions.md)
- visual-tool: Junction Link Magic is the designated interactive GUI utility for scanning, inspecting, and managing NTFS junctions and hardlinks across repositories

VERSIONING-STANDARDS
- MAJOR: breaking change, structural change
- MINOR: new feature, new durable-memory file
- PATCH: corrections, additions, revision-cycle
- durable-memory: increment on any change
- variable-memory: increment PATCH only
- version-parity: all control files share MAJOR
- version-format: MAJOR.MINOR.PATCH
