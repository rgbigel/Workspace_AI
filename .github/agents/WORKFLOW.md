# WORKFLOW

Module: WORKFLOW.md
Purpose: Defines workspace operational workflow and LCM v4.2.0 change governance.
Path: D:/Git_Repositories/Workspace_AI/.github/agents/WORKFLOW.md
Authors: Rolf
Version: 1.2.0
Changelog:
- 2026-08-16: Reconciled with LCM v4.2.0; codified 1-File-Per-CR architecture (CR-yyyyMMdd_HHmmss.md), proposal-first dry-run simulation, quality gates, and automated elevated testing.
- 2026-07-27: Normalized Markdown metadata header.

=====================================================================
1. Purpose
=====================================================================
Define deterministic workspace-wide operational flow and change
governance under LCM v4.2.0. Specify how changes are proposed, reviewed,
simulated, verified, and baseline-committed.

=====================================================================
2. Scope
=====================================================================
WORKFLOW.md applies to all repositories under D:\Git_Repositories.
Defines Change Request governance, dry-run simulation, quality gates,
and verification sequences.

=====================================================================
3. Core Governance Invariants
=====================================================================
- Documentation is authoritative (docs/ defines requirements & architecture)
- 1-File-Per-CR Architecture: every proposal is a standalone file
- Proposal-First: no direct code mutation without an approved proposal
- Dry-Run Simulation: every change must be previewed before execution
- Bi-directional Consistency: code and configuration must match
- Strict Non-Interactive Gates: automated tests must never hang on GUI prompts

=====================================================================
4. Governed 4-Phase Lifecycle Flow
=====================================================================

Phase 1: Discovery & Pre-Flight Audit
- Inspects repository structure, git status, and parameters.
- Validates pre-flight requirements and verifies clean baseline.

Phase 2: Proposal Generation & Dry-Run Simulation
- Generates single-file Change Request in Docs/Methods/Proposals/CR-yyyyMMdd_HHmmss.md.
- Simulates rule junctions, template instantiation, and script updates in dry-run mode.
- Pauses for human operator review and explicit acceptance.

Phase 3: Governed Execution
- Executes approved changes under operator consent (-Execute -Force).
- Creates/updates configuration files and governance links.
- Deploys test runners and quality gates.

Phase 4: Verification & Baseline Commit
- Runs Test-RepoReadiness.ps1 across all quality gates:
  * Assert-RepoStructure
  * Assert-RepoFormatting (UTF-8 without BOM)
  * Assert-RepoGovernanceLinks (Junctions & Hardlinks)
  * Assert-RepoElevationConsistency (RULE-ELEV-001..004)
  * Assert-RepoDocumentationFabric (Prerequisites & DOX)
- Executes elevated test runner (Invoke-ElevatedTest.ps1) emitting out/test_results.json.
- Creates clean baseline commit with standard LCM tag.

=====================================================================
5. Change Request Bundles
=====================================================================
- Related micro-changes may be batched into named bundles (Workspace_Inventory/data/bundles/).
- Bundles allow multi-step verification in a single coherent test pass.

=====================================================================
6. Review & Approval Integration
=====================================================================
- All workspace-level governance updates require explicit operator acceptance.
- Diffs reviewed in VS Code or Beyond Compare.
- Configuration Management dashboard (INVENTORY_DASHBOARD.md) updated upon baseline commit.

=====================================================================
END OF FILE
=====================================================================
