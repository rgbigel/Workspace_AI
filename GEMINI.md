# Antigravity Workspace Instructions

**Workspace**: $targetName  
**Canonical Source Authority**: .copilot/Rules/  
**Generated**: 2026-08-13 21:31:26  

---

## Active Governance Rules

The following rules govern all code generation, refactoring, and agent behaviors in this workspace:
- [**CMDRules.md**](.agents/rules/CMDRules.md)
- [**InvariantRules.md**](.agents/rules/InvariantRules.md)
- [**JsonRules.md**](.agents/rules/JsonRules.md)
- [**LanguagePolicy.md**](.agents/rules/LanguagePolicy.md)
- [**macro-definitions.md**](.agents/rules/macro-definitions.md)
- [**MethodEfficiencyPolicy.md**](.agents/rules/MethodEfficiencyPolicy.md)
- [**PowerShellRules.md**](.agents/rules/PowerShellRules.md)
- [**ReviewCommitGovernancePolicy.md**](.agents/rules/ReviewCommitGovernancePolicy.md)
- [**RuleAuthority.md**](.agents/rules/RuleAuthority.md)


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
   - All code review, acceptance, and commit safety gating is handled exclusively via Beyond Compare (`RR.ps1` / `Submit-ReviewResult.ps1`) under `RULE-REV-001`.

4. **Customizations Structure**:
   - Rules: `.agents/rules/`
   - Skills: `.agents/skills/`
   - Tools: `tools/`