# WORKFLOW

Module: WORKFLOW.md
Purpose: Defines workspace documentation and operational rules for WORKFLOW.
Path: D:/Git_Repositories/Workspace_GC/.github/agents/WORKFLOW.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define deterministic workspace-wide operational flow. Specify how
agents perform regeneration, evaluation, patching, and consistency
checks. Ensure alignment with Workspace-Rules.md and InvariantRules.md.

=====================================================================
2. Scope
=====================================================================
WORKFLOW.md applies to all repositories under D:\Git_Repositories.
Defines regeneration behavior, patch rules, evaluation rules, and
agent invocation order. Documentation remains authoritative.

=====================================================================
3. Deterministic Principles
=====================================================================
- documentation is authoritative
- no automatic documentation modification
- no invention of missing behavior
- no fallback to outdated repository truth
- identical input → identical output
- no randomness
- no speculation
- no assumptions

=====================================================================
4. Regeneration Workflow
=====================================================================
Regeneration is patch-based.

Steps:
1. evaluate documentation
2. evaluate repository structure
3. identify missing directories
4. identify missing module stubs
5. identify header misalignment
6. identify parameter block misalignment
7. identify logging/trace misalignment
8. generate patch plan
9. output patch plan
10. apply patches only with explicit approval

Constraints:
- must not modify documentation
- must align implementation with documentation
- must follow InvariantRules.md

=====================================================================
5. Agent Invocation Order
=====================================================================
1. Workspace-Rules Agent
2. InvariantRules Agent
3. WorkspaceAgentIndex Agents
4. ToolsList Agents
5. Repository-local Agents
6. CopilotRules (VS Code only)

Agents must not:
- override documentation
- invent behavior
- modify documentation automatically

=====================================================================
6. Patch Rules
=====================================================================
Allowed patches:
- create missing directories
- create missing module stubs
- update script headers
- align parameter blocks
- align logging/trace behavior
- align module structure

Forbidden patches:
- modify documentation
- rewrite documentation
- normalize documentation lists
- remove documentation sections

=====================================================================
7. Evaluation Rules
=====================================================================
Evaluation must include:
- directory consistency
- module header consistency
- parameter block consistency
- logging/trace consistency
- rule compliance
- regeneration feasibility

Evaluation must not:
- modify documentation
- invent missing rules

=====================================================================
8. Audit Workflow
=====================================================================
Audit logs must contain:
- timestamp
- assumptions
- regeneration plan
- dryRun status
- consistency evaluation

Audit logs must not modify documentation.

=====================================================================
9. Workspace Directory Rules
=====================================================================
Workspace root:
D:\Git_Repositories\

Required directories:
- .github\
- .github\agents\
- .copilot\
- repository directories

Forbidden directories:
- undocumented directories
- undocumented agent paths

=====================================================================
10. Script Header Rules
=====================================================================
Script headers must contain:
- Module
- Purpose
- Path
- Authors
- Version
- Changelog

Placement:
- if param() exists → header immediately after param()
- if no param() → header at top of file

Constraints:
- must not use backticks
- must assign $_ before use
- must follow PowerShellRules

=====================================================================
11. Consistency Rules
=====================================================================
Consistency requires:
- documentation alignment
- module alignment
- header alignment
- parameter alignment
- logging alignment
- rule alignment

No agent may override consistency rules.

=====================================================================
12. Versioning
=====================================================================
Version: 1.0.0
- MAJOR: structural change to workflow definition
- MINOR: non-breaking workflow addition
- PATCH: revision cycle

=====================================================================
END OF FILE
=====================================================================
