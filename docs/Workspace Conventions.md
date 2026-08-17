# Workspace Conventions

Module: Workspace Conventions.md
Purpose: Defines workspace documentation and operational rules for Workspace Conventions.
Path: D:/Git_Repositories/Workspace_AI/docs/Workspace Conventions.md
Authors: Rolf
Version: 1.2.1
Changelog:
- 2026-08-17: Decoupled git.ignoredRepositories from Workspace_AI; scoped to root container and Workspace_Inventory.
- 2026-08-15: Codified Working directory scratchpad convention and .agents/skills packaging.
- 2026-08-15: Added git.ignoredRepositories conventions; removed prefix AI- and updated test suite command.
- 2026-07-27: Normalized Markdown metadata header.

---
title: Workspace Conventions
updated: 2026-08-17T20:46:00
created: 2026-07-11T14:47:33
---

# SECTION: workspace-location
# FORMAT: ascii-only, copyable, no-prose
WORKSPACE-ROOT
- D:\Git_Repositories\Workspace_AI
WORKSPACE-RULES
- all copilot control files stored under ".copilot" directory
- authoritative path: D:\Git_Repositories\Workspace_AI\.copilot\
- instructions.md stored at: D:\Git_Repositories\Workspace_AI\.copilot\instructions.md
- MEMORY.md stored at: D:\Git_Repositories\Workspace_AI\.copilot\MEMORY.md
- macro-definitions.md stored at: D:\Git_Repositories\Workspace_AI\.copilot\Rules\macro-definitions.md
- test suite command: D:\Git_Repositories\Workspace_AI\tools\Test-WorkspaceReadiness.ps1
WORKSPACE-CONVENTIONS
- workspace root defines authoritative context
- all profile behavior is scoped to workspace root
- all durable memory files must reside under workspace root
WORKING-DIRECTORY-CONVENTIONS
- path: D:\Git_Repositories\Workspace_AI\Working\
- purpose: designated workspace scratchpad for working notes, exploratory scripts, and temporary analysis files
- rule: files inside Working/ are not bound to strict governance schema but must respect UTF-8 CRLF encoding
AGENT-SKILLS-CONVENTIONS
- path: D:\Git_Repositories\Workspace_AI\.agents\skills\
- purpose: modular packaging for domain workflows, templates, and operational procedures (e.g. workspace-governance, real-repo-dry-run)
- rule: each skill must reside in a dedicated directory with a normative SKILL.md containing YAML frontmatter
GIT-IGNORED-REPOSITORIES
- description: maintained authoritatively by Workspace_Inventory and root container D:\Git_Repositories\.vscode\settings.json for non-git child directories
- entries:
  - D:\Git_Repositories\AuthorizeMasterUser
  - D:\Git_Repositories\BootOpsHub
  - D:\Git_Repositories\CommandHub
  - D:\Git_Repositories\DeviceInventory
  - D:\Git_Repositories\DiskAssignmentStatus_AC
  - D:\Git_Repositories\DiskAssignmentStatus_S1
  - D:\Git_Repositories\EnvironmentTools
  - D:\Git_Repositories\FileUtilities
  - D:\Git_Repositories\GitTools
  - D:\Git_Repositories\SystemConfiguration
