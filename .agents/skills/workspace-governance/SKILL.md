---
name: workspace-governance
description: Native governance, quality gates, and dry-run stabilization tools for Workspace repositories. Use when validating readiness, parsing ASTs, advancing governance, or staging changes across sibling repositories.
---

# Workspace Governance Skill

This skill provides direct operational access to the deterministic verification and governance tools maintained in `tools/`.

## Key Commands and Scripts

1. **Readiness Self-Test**:
   - Run: `pwsh ./tools/Test-WorkspaceReadiness.ps1`
   - Purpose: Verifies AST parsing, JSON schemas, and quality gate conformance across all workspace tools.

2. **Sibling Repository Discovery**:
   - Run: `pwsh ./tools/Get-WorkspaceRepositories.ps1`
   - Purpose: Discovers sibling Git repositories read-only for stabilization inspection.

3. **Real-Repository Dry-Run Execution**:
   - Run: `pwsh ./tools/Invoke-RealRepoDryRun.ps1`
   - Contract: Read-only candidate inspection against selected target repositories (e.g. `VolumeInventory`).

4. **Quality Gates Module**:
   - Location: `tools/QualityGates/WorkspaceQualityGates.psm1`
   - Purpose: Enforces UTF-8 without BOM, CRLF line endings, explicit parameter blocks, and variable assignment rules.