# Workspace-Rules

Module: Workspace-Rules.md
Purpose: Defines workspace documentation and operational rules for Workspace-Rules.
Path: D:/Git_Repositories/Workspace_GC/.github/agents/Workspace-Rules.md
Authors: Rolf
Version: 1.2.0
Changelog:
- 2026-07-31: Consolidated Workspace-Rules authority, canonical Workspace_GC paths, agent registry requirements, and WorkspaceLog governance logging.
- 2026-07-31: Resolved DOX unification follow-ups; confirmed explicit documentation-work and custom-agent discovery rules are complete.
- 2026-07-31: Aligned documentation editing rules with explicit DOX invocation and custom-agent frontmatter preservation.
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define workspace-level rules governing documentation immutability,
regeneration boundaries, agent behavior, deterministic output, and
global constraints for Workspace_GC.

=====================================================================
2. Scope
=====================================================================
Workspace rules apply to Workspace_GC and to workspace-level control
operations performed from Workspace_GC.

Canonical workspace root:
- D:\Git_Repositories\Workspace_GC

Canonical workspace control directories:
- D:\Git_Repositories\Workspace_GC\.github\agents
- D:\Git_Repositories\Workspace_GC\.copilot

Authority order:
1. Workspace-Rules.md
2. WorkspaceAgentIndex.md
3. Agent-specific .agent.md files
4. .copilot control files
5. docs/ files

Workspace rules override repository-local rules unless explicitly
stated otherwise.

=====================================================================
3. Documentation Authority
=====================================================================
- Documentation under any /docs directory is authoritative.
- Documentation defines architecture, behavior, workflows,
  evaluation rules, reporting rules, and implementation constraints.
- Documentation must not be regenerated.
- Documentation must not be rewritten.
- Documentation must not be patched.
- Code must follow documentation.

=====================================================================
4. Documentation Editing Rules
=====================================================================
- Documentation is read-only except during Reconciliation Phase.
- Reconciliation Phase:
  - Code is frozen except trivial fixes.
  - Documentation is editable.
  - All edits require manual review.
  - Small diffs reviewed in VS Code.
  - Large diffs reviewed in Beyond Compare.
- DOX agent may edit documentation only with explicit user approval.
- DOX agent outputs complete updated files when proposing changes.
- DOX unification tasks count as explicit documentation work when the user invokes DOX or requests documentation unification.
- DOX.agent.md custom-agent frontmatter must remain valid and must start at the first line of the file.

=====================================================================
5. Regeneration Boundaries
=====================================================================
Regeneration may modify:
- /Source
- /Modules

Regeneration must not modify:
- /docs
- README.md
- nested documentation directories

Regeneration constraints:
- must align implementation with documentation
- must not invent behavior
- must not rewrite conventions

=====================================================================
6. Determinism Rules
=====================================================================
- identical input ? identical output
- no randomness
- ASCII-only unless explicit exception applies
- CRLF endings for Windows-native files
- UTF-8 without BOM for scripts
- indent-2 for generated text
- no assumptions
- no inference
- no speculation
- no filler
- no repetition
- no restating user facts
- address current question only

=====================================================================
7. Workspace Agents
=====================================================================
Workspace agents:
- Workspace-Rules Agent
- DOX Agent
- MIGRATION Agent
- ATOM Agent
- SharedModulesRule Agent
- WorkspaceLog Agent

Workspace agents must:
- enforce workspace rules
- respect documentation immutability
- respect regeneration boundaries
- respect deterministic behavior
- preserve VS Code custom-agent discovery requirements for .agent.md files
- be listed in WorkspaceAgentIndex.md when they are user-invocable or govern workspace control behavior

Workspace agents must not:
- modify documentation outside Reconciliation Phase
- invent behavior
- guess missing documentation
- normalize documentation lists
- revert documentation files
- fallback to outdated repository truth
- apply changes automatically

=====================================================================
8. Review Workflow Integration
=====================================================================
- all workspace-level changes require manual review
- small diffs reviewed in VS Code
- large diffs reviewed in Beyond Compare
- no automatic merges
- no auto-formatting
- no auto-save during agent operations

=====================================================================
9. Path Rules
=====================================================================
Workspace-level files:
- must use absolute Windows paths
- example:
  D:\Git_Repositories\Workspace_GC\.github\agents\Workspace-Rules.md

Repository-level files:
- must use repo-relative paths
- example:
  /Docs/Architecture.md

VS Code must display real folder names, not localized names.

=====================================================================
10. Enforcement
=====================================================================
- workspace rules override repository-local rules
- agents must apply workspace rules to all repositories
- agents must not bypass workspace rules through local configuration
- all workspace-level files must follow @technical format
- WorkspaceAgentIndex.md is the agent registry and must list all active workspace agents
- .agent.md frontmatter must start at line 1 and remain valid for VS Code discovery
- WorkspaceLog.agent.md writes the canonical governance log to .copilot\Logs\Workspace_GC.log

Override detection:
- any repository-local rule that explicitly overrides a workspace rule
  must trigger a workspace-level warning
- warning must include:
  - repository name
  - file path
  - rule identifier
  - override reason
- warning must be logged in the workspace audit log
- override requires manual review
- override does not take effect until review is completed

=====================================================================
11. Versioning
=====================================================================
Version: 1.2.0
- MAJOR: structural change to workspace methodology
- MINOR: non-breaking workspace rule clarification or agent behavior alignment
- PATCH: revision cycle

=====================================================================
END OF FILE
=====================================================================
