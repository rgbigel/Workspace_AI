# CopilotRules

Module: CopilotRules.md
Purpose: Defines workspace documentation and operational rules for CopilotRules.
Path: D:/Git_Repositories/Workspace_AI/.copilot/CopilotRules.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define deterministic invocation rules for Copilot inside VS Code.
Specify behavioral constraints for PowerShellCore, GitCLI, and
VSCodeCLI. Ensure Copilot uses consistent, predictable execution
behavior when invoking external processes.

=====================================================================
2. Scope
=====================================================================
CopilotRules.md applies only to Copilot operations inside VS Code.
Rules defined here govern Copilot's invocation behavior and do not
modify documentation, workspace agents, or repository-local agents.

=====================================================================
3. Invocation Rules: PowerShellCore
=====================================================================
Executable: pwsh.exe

Rules:
- must use UTF-8 without BOM
- must use CRLF endings
- must not use backticks
- must not use interpolated method calls
- must assign $_ to a variable before use
- must follow InvariantRules.md
- must execute deterministically
- identical input → identical output

=====================================================================
4. Invocation Rules: GitCLI
=====================================================================
Executable: git.exe

Rules:
- must not modify documentation
- must not auto-stage files
- must not auto-merge
- must not rewrite commit history
- must execute deterministically
- identical input → identical output

=====================================================================
5. Invocation Rules: VSCodeCLI
=====================================================================
Executable: code.exe

Rules:
- must not auto-format
- must not auto-save
- must not modify documentation
- must not apply workspace-level changes automatically
- must execute deterministically
- identical input → identical output

=====================================================================
6. Deterministic Behavior
=====================================================================
- no randomness
- no assumptions
- no inference
- no speculation
- no filler
- no repetition
- no restating user facts
- address current question only

=====================================================================
7. Versioning
=====================================================================
Version: 1.0.0
- MAJOR: introduction of Copilot invocation rules
- MINOR: non-breaking rule additions
- PATCH: revision cycle

=====================================================================
END OF FILE
=====================================================================
