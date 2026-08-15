# Workspace Conventions

Module: Workspace Conventions.md
Purpose: Defines workspace documentation and operational rules for Workspace Conventions.
Path: D:/Git_Repositories/Workspace_AI/docs/Workspace Conventions.md
Authors: Rolf
Version: 1.1.0
Changelog:
- 2026-08-15: Added git.ignoredRepositories conventions; removed prefix AI- and updated test suite command.
- 2026-07-27: Normalized Markdown metadata header.

---
title: Workspace Conventions
updated: 2026-08-15T17:26:00
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
GIT-IGNORED-REPOSITORIES
- description: list of child directories under D:\Git_Repositories that do not have a .git directory
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
