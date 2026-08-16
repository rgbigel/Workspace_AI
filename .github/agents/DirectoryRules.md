# DirectoryRules

Module: DirectoryRules.md
Purpose: Defines workspace directory structure rules and LCM governance alignment.
Path: D:/Git_Repositories/Workspace_AI/.github/agents/DirectoryRules.md
Authors: Rolf
Version: 1.2.0
Changelog:
- 2026-08-16: Reconciled with LCM v4.2.0; authorized .github/agents/ for agent discovery, root AGENTS.md/GEMINI.md hardlinks, .lcm/ configuration, and governance rule junctions.
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define deterministic directory structure rules for all repositories
and auxiliary containers under D:\Git_Repositories. Ensure alignment
with Workspace-Rules.md, InvariantRules.md, WORKFLOW.md, ElevationPolicy.md,
and LCM v4.2.0 placement standards.

=====================================================================
2. Scope
=====================================================================
Applies to all directories in D:\Git_Repositories.
Defines required directories, governance links, template placement,
and structural constraints.

=====================================================================
3. Directory Classes
=====================================================================
Three primary directory classes exist:

1. LCM-Governed Repositories
2. Auxiliary Containers & Standard Git Repositories
3. Workspace_AI (Governance Workshop & Rule Authority)

=====================================================================
4. LCM-Governed Repositories
=====================================================================
Mandatory Repository Structure:
- must contain .git/
- must contain README.md with mandatory "## System Prerequisites" section
- must contain docs/ with docs/README.md documentation index
- must contain .lcm/ with config.json (including execution_context) and overrides.json
- must contain .vscode/ with settings.json and tasks.json
- must contain .github/agents/RepoAgentIndex.md (for Copilot custom agent discovery)
- must contain AGENTS.md and GEMINI.md (hardlinks to Workspace_AI authority)
- must contain .agents/rules/core (NTFS directory junction to Workspace_AI/.agents/rules)
- must contain .copilot/Rules/core (NTFS directory junction to Workspace_AI/.copilot/Rules)
- must contain tools/Test-RepoReadiness.ps1 and tools/QualityGates/RepoQualityGates.psm1
- if elevation_required is true: must contain tools/Invoke-ElevatedTest.ps1

Allowed contents:
- all repository source code (src/, Source/, Modules/)
- tests/ directory for Pester unit and integration tests
- docs/ directory for DOX tripartite specifications and architectural records
- tools/ directory for local quality gates and elevated runners

=====================================================================
5. Auxiliary Containers & Legacy Repositories
=====================================================================
Characteristics:
- May contain reference code or un-onboarded utilities
- Governed by non-git or standard-git CM inventory tracking
- Must not override Workspace_AI governance rules

=====================================================================
6. Workspace_AI (Governance Authority)
=====================================================================
Directory name: Workspace_AI
Characteristics:
- Canonical root authority for LCM governance rules, tripartite templates, and quality gate definitions
- Contains .agents/rules/ (projected across all repos via junction)
- Contains .copilot/Rules/ (projected across all repos via junction)
- Contains templates/repo-scaffold/ for all repository scaffolding

=====================================================================
7. Enforcement
=====================================================================
- Enforced by Assert-RepoStructure and Assert-RepoGovernanceLinks in RepoQualityGates.psm1.
- Bi-directional validation ensures no repository passes quality gates with structural drift.

=====================================================================
END OF FILE
=====================================================================
