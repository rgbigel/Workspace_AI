# RepoAgentIndex_Template

Module: RepoAgentIndex_Template.md
Purpose: Defines workspace documentation and operational rules for RepoAgentIndex_Template.
Path: D:/Git_Repositories/Workspace_AC/.github/agents/RepoAgentIndex_Template.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define required structure for repository-level agent index files.
Specify mandatory sections, fields, and deterministic rules for
RepoAgentIndex.md generation in each repository.

=====================================================================
2. Scope
=====================================================================
Applies to all real repositories under D:\Git_Repositories.
Template defines structure only; no repository-specific content.
Generation must follow Workspace-Rules.md, WORKFLOW.md,
InvariantRules.md, DirectoryRules.md.

=====================================================================
3. Required Sections
=====================================================================
Each RepoAgentIndex.md must contain:

1. RepositoryIdentification
2. AgentDefinitions
3. AgentResponsibilities
4. AgentInvocationRules
5. AgentFileLocations
6. DeterministicBehaviorRules
7. Versioning

=====================================================================
4. Section: RepositoryIdentification
=====================================================================
Fields:
- RepositoryName: <REPO-NAME>
- RepositoryPath: <ABSOLUTE-PATH>
- RepositoryVersion: 1.0.0

Rules:
- must use absolute path
- must not invent repository name
- must match DirectoryRules classification

=====================================================================
5. Section: AgentDefinitions
=====================================================================
Each agent must define:

- AgentName
- AgentClass (DocumentationAgent | CodeAgent)
- AgentType
- AgentPurpose
- AgentVersion

AgentClass rules:
- DocumentationAgent: workspace-level, read-only
- CodeAgent: repo-level, code-modifying

AgentType values:
- analysis
- regeneration
- validation
- patch-planning
- documentation-check
- code-modification
- code-analysis

Constraints:
- must not invent agent types
- must not omit required fields
- AgentVersion must be 1.0.0 until workspace stabilization

=====================================================================
6. Section: AgentResponsibilities
=====================================================================
Each agent must define:

- Inputs
- Outputs
- Responsibilities
- ForbiddenActions

DocumentationAgents ForbiddenActions:
- must NOT modify code
- must NOT modify documentation
- exception: reconciliation loop

CodeAgents ForbiddenActions:
- must NOT modify documentation
- exception: reconciliation loop

Constraints:
- must follow Workspace-Rules.md
- must follow InvariantRules.md
- must not invent behavior

=====================================================================
7. Section: AgentInvocationRules
=====================================================================
Rules:
- invocation order must follow WORKFLOW.md
- identical input ? identical output
- no randomness
- no speculation

Invocation fields:
- InvocationOrder
- InvocationTrigger
- InvocationConstraints

=====================================================================
8. Section: AgentFileLocations
=====================================================================
Fields:
- AgentFile: <ABSOLUTE-PATH>
- AgentDirectory: <ABSOLUTE-PATH>

Rules:
- must use absolute paths
- must not use undocumented directories
- must not use workspace root

=====================================================================
9. Section: DeterministicBehaviorRules
=====================================================================
Rules:
- no assumptions
- no inference
- no undocumented behavior
- no fallback to outdated repository truth
- must follow InvariantRules.md

=====================================================================
10. Section: Versioning
=====================================================================
Fields:
- Version
- MAJOR
- MINOR
- PATCH

Rules:
- Version must be 1.0.0 until workspace stabilization
- MAJOR: reserved
- MINOR: reserved
- PATCH: reserved

=====================================================================
END OF TEMPLATE
=====================================================================
