# WorkspaceAgentIndex

Module: WorkspaceAgentIndex.md
Purpose: Defines workspace documentation and operational rules for WorkspaceAgentIndex.
Path: D:/Git_Repositories/Workspace_AI/.github/agents/WorkspaceAgentIndex.md
Authors: Rolf
Version: 1.2.0
Changelog:
- 2026-07-31: Consolidated Workspace-Rules authority, canonical Workspace_AI paths, and WorkspaceLog agent registration.
- 2026-07-31: Resolved DOX unification follow-ups; marked DOX role, constraints, and discovery requirements complete.
- 2026-07-31: Aligned DOX Agent definition with unified documentation behavior.
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define all workspace-level agents active across D:\Git_Repositories.
Specify roles, responsibilities, constraints, and activation rules.
Ensure deterministic, machine-readable agent definitions aligned with
Workspace-Rules.md, InvariantRules.md, Tools.md, WORKFLOW.md, and
RepoAgentIndex.Template.md.

=====================================================================
2. Scope
=====================================================================
Workspace agents apply to all repositories under
D:\Git_Repositories. Workspace agents override repository-local
agents unless explicitly stated otherwise. Repository-local agents
must conform to workspace rules and treat documentation as
authoritative.

=====================================================================
3. Documentation Plane
=====================================================================
- documentation under any /docs directory is authoritative
- documentation defines architecture, behavior, evaluation rules,
  reporting rules, and implementation constraints
- documentation must not be regenerated
- documentation must not be rewritten
- documentation must not be patched
- code must follow documentation

=====================================================================
4. Global Constraints
=====================================================================
Workspace agents must not:
- modify documentation
- invent behavior
- guess missing documentation
- normalize documentation lists
- revert documentation files
- fallback to outdated repository truth
- apply changes automatically

=====================================================================
5. Workspace-Rules Agent
=====================================================================
Purpose:
- enforce Workspace-Rules.md across all repositories

Responsibilities:
- enforce documentation immutability
- enforce regeneration boundaries
- enforce forbidden paths
- enforce deterministic behavior
- validate workspace-level rule compliance

Activation:
- implicit for all workspace-level operations

=====================================================================
6. DOX Agent
=====================================================================
Purpose:
- provide unified documentation behavior for documentation writing,
  review, revision, and documentation/code alignment

Responsibilities:
- improve technical writing, usage guidance, install instructions,
  and operator-facing explanations
- unify documentation terms, source-of-truth references, and usage
  descriptions across Workspace_AI documentation surfaces
- modify code only when documentation tasks require updates to help
  comments or usage strings
- output complete updated files when proposing changes

Constraints:
- must not invent behavior
- must not rewrite conventions
- must not modify documentation without explicit user approval
- must not modify README.md outside documentation tasks
- must keep VS Code custom-agent frontmatter valid in DOX.agent.md

Activation:
- explicit user invocation

=====================================================================
7. MIGRATION Agent
=====================================================================
Purpose:
- assist in migration of documentation, modules, or structure during
  redesign or consolidation phases

Responsibilities:
- identify obsolete structures
- propose migration steps

Constraints:
- must not modify documentation automatically
- must not invent missing behavior

Activation:
- explicit user invocation

=====================================================================
8. ATOM Agent
=====================================================================
Purpose:
- assist in atomic restructuring of modules, source files, or
  documentation segments

Responsibilities:
- propose atomic changes
- ensure atomicity and determinism

Constraints:
- must not modify documentation automatically

Activation:
- explicit user invocation

=====================================================================
9. SharedModulesRule Agent
=====================================================================
Purpose:
- govern rules for shared modules across repositories

Responsibilities:
- validate shared module references
- enforce deterministic module structure

Activation:
- implicit when shared modules are referenced

=====================================================================
10. WorkspaceLog Agent
=====================================================================
Purpose:
- generate the Workspace_AI governance log

Responsibilities:
- summarize FIX, DOX, APPLY, RULE, and AGENT operations
- write .copilot\Logs\Workspace.log as the unified governance log
- keep governance log output ASCII-only, CRLF-normalized, and deterministic

Constraints:
- must not include VS Code internal workspaceStorage logs
- must not include partial diffs or code snippets
- must not alter files outside .copilot\Logs\Workspace.log when invoked

Activation:
- explicit user invocation

=====================================================================
11. Regeneration Behavior
=====================================================================
Workspace regeneration:
- is patch-based
- must align implementation with documentation
- may propose patches to:
  - create missing directories
  - create missing module stubs
  - update module headers
  - align script headers with documentation
  - align parameter blocks with documentation
  - align logging and trace behavior with documentation

Workspace regeneration must not modify documentation.

=====================================================================
12. Audit Behavior
=====================================================================
Workspace agents may require audit logs containing:
- timestamp
- assumptions
- regeneration plan
- dryRun status
- consistency evaluation

Audit logs must not modify documentation.

=====================================================================
13. Agent Metadata
=====================================================================
- all workspace agents reside in:
  D:\Git_Repositories\Workspace_AI\.github\agents\
- all workspace agents follow @technical format
- all workspace agents must comply with:
  - Workspace-Rules.md
  - InvariantRules.md
  - Tools.md
  - WORKFLOW.md

=====================================================================
14. Versioning
=====================================================================
Version: 1.2.0
- MAJOR: structural change to agent indexing
- MINOR: non-breaking agent role clarification or addition
- PATCH: revision cycle

=====================================================================
END OF FILE
=====================================================================
