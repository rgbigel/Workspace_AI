# DirectoryRules

Module: DirectoryRules.md
Purpose: Defines workspace documentation and operational rules for DirectoryRules.
Path: D:/Git_Repositories/Workspace_GC/.github/agents/DirectoryRules.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define deterministic directory structure rules for all repositories
and auxiliary containers under D:\Git_Repositories. Ensure alignment
with Workspace-Rules.md, InvariantRules.md, WORKFLOW.md, and all
template Placement rules.

=====================================================================
2. Scope
=====================================================================
Applies to all directories in D:\Git_Repositories.
Defines required directories, auxiliary containers, exceptions,
template placement, instance placement, and alignment constraints.

=====================================================================
3. DirectoryClasses
=====================================================================
Three directory classes exist:

1. RepositoryDirectories
2. AuxiliaryContainers (AC)
3. Workspace_GC (governance repository exception)

=====================================================================
4. RepositoryDirectories
=====================================================================
Characteristics:
- must contain .git/
- must contain RepoAgentIndex.md
- must contain agents\.AGENTS.md
- must NOT contain .github\

Allowed contents:
- all repository files and directories
- agents\ directory
- docs\ directory

Forbidden contents:
- .github\ (any depth)

ForbiddenActionBehavior:
- WARNING ONLY
- no deletions
- no automatic cleanup

=====================================================================
5. AuxiliaryContainers (AC)
=====================================================================
Directory name pattern:
repo_*

Characteristics:
- must NOT contain .git/
- must contain full repository contents
- used for verification and reconstruction

Allowed contents:
- all files and directories present in the original repository

Forbidden contents:
- .git/

ForbiddenActionBehavior:
- WARNING ONLY
- no deletions
- no automatic cleanup

=====================================================================
6. Workspace_GC (Governance Repository Exception)
=====================================================================
Directory name:
Workspace_GC

Characteristics:
- must contain .git/
- behaves like AC but is versioned in GitHub
- used for workspace-level reconstruction and verification

Allowed contents:
- all workspace reconstruction logic
- all verification logic
- cross-repo analysis artifacts

Forbidden contents:
- none (warnings only if undocumented)

ForbiddenActionBehavior:
- WARNING ONLY
- no deletions
- no automatic cleanup

=====================================================================
7. Template Placement Rules
=====================================================================
Workspace-level templates must define:

Fields:
- Name: <TEMPLATE-FILENAME>
- Location: <WORKSPACE-PATH>
- Placement: <REPO-ROOT>\agents\<INSTANCE-FILENAME>

Rules:
- Location specifies where the template lives.
- Placement specifies where the instance must be generated.
- Placement must NOT contain "_Template".
- Placement must NOT contain ".github".
- Placement must use "<REPO-ROOT>" placeholder.
- Placement is mandatory for all templates.

=====================================================================
8. Instance Placement Rules
=====================================================================
Repo-local instances must follow template Placement:

Required repo-local files:
- <REPO-ROOT>\RepoAgentIndex.md
- <REPO-ROOT>\agents\.AGENTS.md

Rules:
- instances must NOT contain "_Template"
- instances must NOT live under ".github"
- instances must use absolute paths
- instances must match Placement exactly

=====================================================================
9. Workspace Root Rules
=====================================================================
Workspace root:
D:\Git_Repositories\

Allowed items:
- RepositoryDirectories
- AuxiliaryContainers (AC)
- Workspace_GC
- .github\
- .github\agents\
- .copilot\

Forbidden items:
- undocumented directories
- undocumented files

ForbiddenActionBehavior:
- WARNING ONLY
- no deletions
- no automatic cleanup

=====================================================================
10. Required Workspace Directories
=====================================================================
Required:
- .github\
- .github\agents\
- .copilot\

Rules:
- must exist
- must not be renamed

=====================================================================
11. Documentation Directory Rules
=====================================================================
Documentation must reside in:
<REPO-ROOT>\docs\

Rules:
- must not place documentation in src\
- must not place documentation in tools/
- must not place documentation in workspace root
- must not modify documentation automatically

ForbiddenActionBehavior:
- WARNING ONLY
- no deletions
- no automatic cleanup

=====================================================================
12. Directory Consistency Rules
=====================================================================
Consistency requires:
- required directories exist
- forbidden directories produce warnings only
- directory names match documentation
- directory structure matches RepoAgentIndex.md
- Placement rules are respected

Rules:
- no assumptions
- no undocumented directories
- no fallback to outdated repository truth

=====================================================================
13. Versioning
=====================================================================
Version: 1.0.0
MAJOR: reserved until workspace stabilization
MINOR: reserved until workspace stabilization
PATCH: reserved until workspace stabilization

=====================================================================
END OF FILE
=====================================================================
