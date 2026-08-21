# Workspace_AI Lifecycle Model (LCM) Implementation & Tooling Mapping

Module: docs/Implementation.md  
Authors: Rolf, Workspace_AI Engine  
Version: 5.0.2  
Status: Authoritative Implementation  
Date: 2026-08-21  

---

## 1. Tooling & Script Inventory

Under LCM v5.0.2, the governance and execution tooling is organized into functional categories across [`Workspace_AI`](file:///D:/Git_Repositories/Workspace_AI) (Governance Authority & Baseline Source) and [`Workspace_Inventory`](file:///D:/Git_Repositories/Workspace_Inventory) (Configuration Management Engine).

### A. PowerShell CLI Tools

| Repository | Tool Path | Version | Purpose |
| :--- | :--- | :---: | :--- |
| **`Workspace_AI`** | [`tools/Test-WorkspaceReadiness.ps1`](file:///D:/Git_Repositories/Workspace_AI/tools/Test-WorkspaceReadiness.ps1) | `1.0.0` | Comprehensive readiness runner and quality gate validator for `Workspace_AI`. |
| **`Workspace_AI`** | [`tools/Invoke-LCMOnboardRepo.ps1`](file:///D:/Git_Repositories/Workspace_AI/tools/Invoke-LCMOnboardRepo.ps1) | `1.1.0` | 4-phase onboarding and update engine for onboarding target repositories into LCM. |
| **`Workspace_Inventory`** | [`tools/Invoke-BeyondCompareReview.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Invoke-BeyondCompareReview.ps1) | `1.0.0` | Isolated visual comparison launcher comparing baseline commit snapshot against live repo. |
| **`Workspace_Inventory`** | [`tools/Submit-ReviewResult.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Submit-ReviewResult.ps1) | `1.0.0` | Interactive review outcome recorder (`Accepted`, `AcceptedWithEdits`, `Rejected`, `Deferred`). |
| **`Workspace_Inventory`** | [`tools/Invoke-WorkspaceAudit.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Invoke-WorkspaceAudit.ps1) | `1.0.0` | Multi-repository CM audit scanner; generates inventory JSON and dashboard markdown. |
| **`Workspace_Inventory`** | [`tools/Invoke-LCMUpdate.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Invoke-LCMUpdate.ps1) | `1.0.0` | Governed LCM update tool; enforces proposal-first dry-run before live execution. |
| **`Workspace_Inventory`** | [`tools/Find-ChangeRequest.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Find-ChangeRequest.ps1) | `1.0.0` | Query tool for searching Change Requests by text, repo, bundle, or status. |
| **`Workspace_Inventory`** | [`tools/New-WorkspaceBaseline.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/New-WorkspaceBaseline.ps1) | `1.0.0` | Snapshot tool capturing full workspace state into versioned JSON baselines. |
| **`Workspace_Inventory`** | [`tools/Test-WorkspaceDrift.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Test-WorkspaceDrift.ps1) | `1.0.0` | Drift detection tool evaluating dirty copies, unpushed commits, and outdated LCM versions. |
| **`Workspace_Inventory`** | [`tools/Clear-BCReviewTemp.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Clear-BCReviewTemp.ps1) | `1.5.0` | User command to inspect, list, and purge Beyond Compare temp review directories (`%TEMP%\BC_Review`). |
| **`Workspace_Inventory`** | [`tools/Sync-IgnoredRepositories.ps1`](file:///D:/Git_Repositories/Workspace_Inventory/tools/Sync-IgnoredRepositories.ps1) | `1.0.0` | Reconciles `git.ignoredRepositories` in `.vscode/settings.json` against workspace non-git directories. |

---

### B. Beyond Compare Review Architecture & Session Metadata

Each review session launched via `Invoke-BeyondCompareReview.ps1` produces an isolated, read-only baseline export in `%TEMP%\BC_Review\<RepoName>-<SHA>\` with a session metadata token (`.lcm_review.json`):

```json
{
  "RepositoryName": "Workspace_AI",
  "RepositoryPath": "D:\\Git_Repositories\\Workspace_AI",
  "BaseCommit": "3ae7621",
  "CommitMessage": "feat(docs): implement CR-2026-014 tripartite templates...",
  "CommitDate": "2026-08-20T19:00:00+02:00",
  "SessionStartedAt": "2026-08-20T22:12:00+02:00"
}
```

* **Session Folder Deletion as User Consent**: Deletion of `%TEMP%\BC_Review\<RepoName>-<SHA>\` by the operator signals review completion and consent.
* **Right-Side Edit Detection**: Compares working tree status against pre-review state; if modified, classifies disposition as `AcceptedWithEdits` and runs `Test-WorkspaceReadiness.ps1` before committing.
* **Maintenance Purge**: `Clear-BCReviewTemp.ps1 -All` purges all temp session directories and is excluded from triggering review acceptance.

---

### C. PowerShell Modules

| Repository | Module Path | Version | Exported Functions & Scope |
| :--- | :--- | :---: | :--- |
| **`Workspace_AI`** | [`tools/Onboarding/LCMOnboarding.psm1`](file:///D:/Git_Repositories/Workspace_AI/tools/Onboarding/LCMOnboarding.psm1) | `1.0.0` | `Test-LCMPreFlight`, `New-LCMGovernanceLinks`, `Expand-LCMTemplate`, `Test-LCMIntegrity`, `Invoke-LCMOnboardRepo` |
| **`Workspace_AI`** | [`tools/QualityGates/WorkspaceQualityGates.psm1`](file:///D:/Git_Repositories/Workspace_AI/tools/QualityGates/WorkspaceQualityGates.psm1) | `1.0.0` | `Test-WorkspaceQualityGates`, `Test-GovernanceRules`, `Test-DryRunEngine` |
| **`Workspace_Inventory`** | [`modules/WorkspaceCM.psm1`](file:///D:/Git_Repositories/Workspace_Inventory/modules/WorkspaceCM.psm1) | `1.0.0` | `Get-WorkspaceRoot`, `Get-WorkspaceAIState`, `Get-RepoCMState`, `Update-WorkspaceInventory`, `Test-WorkspaceDrift`, `New-WorkspaceBaseline`, `Write-CMLog` |
| **`Workspace_Inventory`** | [`modules/ChangeRequestManager.psm1`](file:///D:/Git_Repositories/Workspace_Inventory/modules/ChangeRequestManager.psm1) | `2.0.0` | `Sync-CRJunctions`, `Get-ChangeRequests`, `Find-ChangeRequest`, `New-ChangeRequest`, `Get-CRBundles`, `New-CRBundle`, `Add-CRToBundle`, `Export-ChangeRequestDashboard` |

---

## 2. Setup Python for Google Antigravity

Google Antigravity provides agentic AI pair programming capabilities. The Python virtual environment is established at the workspace root container level.

### Setup Instructions

1. **Prerequisites**:
   * Python 3.10+ installed on Windows (available in `PATH`).

2. **Initialize Virtual Environment**:
   ```powershell
   pwsh -Command "
   cd D:\Git_Repositories
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   python -m pip install --upgrade pip
   "
   ```

3. **Install Antigravity SDK & Dependencies**:
   ```powershell
   pwsh -Command "
   .\.venv\Scripts\Activate.ps1
   pip install google-antigravity
   "
   ```

4. **Verify Installation**:
   ```powershell
   pwsh -Command "
   .\.venv\Scripts\Activate.ps1
   agy --version
   "
   ```

---

## 3. Data Schemas & Configurations

### A. Repository-Local Configuration (`.lcm/config.json`)
Instantiated in each governed repository during Phase 3 of onboarding:
```json
{
  "meta": {
    "module": "config.json",
    "version": "1.0.0",
    "config_type": "lcm-target-repository-config"
  },
  "repository": {
    "name": "VolumeInventory",
    "primary_language": "PowerShell",
    "module_root": "src",
    "onboarded_at": "2026-08-15T23:11:48+02:00"
  },
  "governance": {
    "lcm_version": "4.1.0",
    "workspace_authority": "D:\\Git_Repositories\\Workspace_AI",
    "immutable_links": {
      "junctions": [
        ".agents/rules/core",
        ".copilot/Rules/core"
      ],
      "hardlinks": [
        "AGENTS.md",
        "GEMINI.md",
        ".copilot/instructions.md"
      ]
    }
  }
}
```

### B. Machine-Readable Inventory (`Workspace_Inventory/data/inventory.json`)
Generated automatically by `Update-WorkspaceInventory` during full scans.

### C. Change Request Test Bundles (`Workspace_Inventory/data/bundles/`)
Groups related CRs into single test sequence milestones (e.g., `BUNDLE-2026-01.json` for LCM v4.1.0 Baseline, `BUNDLE-2026-02.json` for CM Initialization).

---

## 4. Requirement Traceability Matrix

| Requirement ID | Requirement Name | Implemented By Control / Tool | Status |
| :--- | :--- | :--- | :---: |
| **`LCM-REQ-SYS-001`** | Authoritative PowerShell Runtime | `pwsh.exe 7.0+` enforced in all `.ps1`/`.psm1` headers & execution policies | **Active** |
| **`LCM-REQ-SYS-002`** | Git Version Control | `Get-RepoCMState` Git inspection; Pre-LCM baseline commit phase | **Active** |
| **`LCM-REQ-SYS-003`** | NTFS Filesystem & Links | `New-LCMGovernanceLinks` (NTFS junctions & hardlinks) | **Active** |
| **`LCM-REQ-SYS-004`** | Python for Antigravity | `D:\Git_Repositories\.venv` (`google-antigravity`, `agy`) | **Active** |
| **`LCM-REQ-001`** | Canonical Authority Root | `Workspace_AI` authority defined; `.agents/rules/core` junctions | **Active** |
| **`LCM-REQ-002`** | Precedence Hierarchy | `Workspace-Rules.md` & `LanguagePolicy.md` invariants | **Active** |
| **`LCM-REQ-004`** | Repository Local Overrides | `.lcm/overrides.json` parsed by `Expand-LCMTemplate` & `Test-RepoReadiness` | **Active** |
| **`LCM-REQ-010`** | Explicit Classification | `Get-RepoCMState` classification in `WorkspaceCM.psm1` | **Active** |
| **`LCM-REQ-011`** | Guarded State Transitions | `Invoke-LCMUpdate.ps1` default proposal mode with dry-run preview | **Active** |
| **`LCM-REQ-021`** | 1-File-Per-CR Standard | `New-ChangeRequest` single-file generation (`Docs/Methods/Proposals/`) | **Active** |
| **`LCM-REQ-022`** | LCM Timestamp Naming | `CR-yyyyMMdd_HHmmss.md` format in `ChangeRequestManager.psm1` | **Active** |
| **`LCM-REQ-023`** | Change Request Bundles | `data/bundles/*.json` batch test suites | **Active** |
| **`LCM-REQ-030`** | Self-Readiness Quality Gate | `Test-WorkspaceReadiness.ps1` in `Workspace_AI` | **Active** |
| **`LCM-REQ-032`** | Drift Evaluation | `Test-WorkspaceDrift.ps1` in `Workspace_Inventory` | **Active** |
