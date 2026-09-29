<!-- Governed by root LCM standard: D:\Git_Repositories\AGENTS.md -->
# Antigravity Workspace Instructions - Workspace_AI

**Workspace**: Workspace_AI
**Root Governance Authority**: [`D:\Git_Repositories\AGENTS.md`](file:///D:/Git_Repositories/AGENTS.md)
**Canonical Source Authority**: `.agents/rules/` (Canonical Physical Hub & Commit Gate)

---

## Active Governance Rules

The following rules govern all code generation, refactoring, and agent behaviors in this workspace (see authoritative matrix in [`.agents/rules/`](.agents/rules/) and [`docs/LCM-Rules-Cross-Reference.md`](docs/LCM-Rules-Cross-Reference.md)):
- [**CMDRules.md**](.agents/rules/CMDRules.md)
- [**DisplayStandardsPolicy.md**](.agents/rules/DisplayStandardsPolicy.md)
- [**DocumentationStandardsPolicy.md**](.agents/rules/DocumentationStandardsPolicy.md)
- [**ElevationPolicy.md**](.agents/rules/ElevationPolicy.md)
- [**InvariantRules.md**](.agents/rules/InvariantRules.md)
- [**JsonRules.md**](.agents/rules/JsonRules.md)
- [**LanguagePolicy.md**](.agents/rules/LanguagePolicy.md)
- [**macro-definitions.md**](.agents/rules/macro-definitions.md)
- [**MethodEfficiencyPolicy.md**](.agents/rules/MethodEfficiencyPolicy.md)
- [**PowerShellRules.md**](.agents/rules/PowerShellRules.md)
- [**PowerShellStandardsPolicy.md**](.agents/rules/PowerShellStandardsPolicy.md)
- [**ProposalReviewFlowPolicy.md**](.agents/rules/ProposalReviewFlowPolicy.md)
- [**PythonRules.md**](.agents/rules/PythonRules.md)
- [**RepositoryContextPolicy.md**](.agents/rules/RepositoryContextPolicy.md)
- [**ReviewCommitGovernancePolicy.md**](.agents/rules/ReviewCommitGovernancePolicy.md)
- [**RuleAuthority.md**](.agents/rules/RuleAuthority.md)
- [**SubsystemGovernancePolicy.md**](.agents/rules/SubsystemGovernancePolicy.md)

---

## Agent Operational Invariants

1. **PowerShell Core Standards**:
   - Use `pwsh` as the primary shell.
   - Text files must use **UTF-8 without BOM** with **CRLF** line endings.
   - Always assign `$_` to an explicit local variable before use in pipeline scriptblocks.
   - Advanced functions must include `[CmdletBinding()]` and explicit parameter blocks.

2. **Quality Gates & Self-Readiness**:
   - Run `./tools/Test-WorkspaceReadiness.ps1` to validate workspace health before and after significant updates.
   - Target repositories under `D:\Git_Repositories\` must be inspected via dry-run before modifications.

3. **Direct Execution & RR Review Gating**:
   - Agents must proceed directly with tool actions, commands, and edits under `always-proceed` / `allow` without generating redundant interactive chat planning blocks or approval pauses.
   - All code review, acceptance, and commit safety gating is handled exclusively via Beyond Compare (`RR.ps1` / `Submit-ReviewResult.ps1` / `Invoke-BeyondCompareReview.ps1`) under `RULE-REV-001`.
   - Single-edit atomic consolidation per user turn under `RULE-LCM-022`.

4. **Customizations Structure**:
   - Rules: `.agents/rules/` (Canonical physical hub)
   - Skills: `.agents/skills/`
   - Tools: `tools/`