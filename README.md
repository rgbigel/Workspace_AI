# Workspace_AI

**Authoritative Governance, Lifecycle Model (LCM), and Baseline Source for Solution Workspace Engineering**

- **Version**: `4.1.0`
- **Module**: `README.md`
- **Authors**: Rolf, Workspace_AI Engine
- **Status**: Authoritative Active Baseline

---

## 1. System Prerequisites

Before running any LCM tools, quality gates, or AI agent pair-programming workflows, ensure the following foundational prerequisites are present:

1. **PowerShell 7 (`pwsh.exe` 7.0+)**: Mandatory runtime environment for all scripts, tools, and quality gates (`D:\Tools\PowerShell\7\pwsh.exe`).
2. **Git for Windows**: Required for distributed version control, SHA auditing, and branch management.
3. **NTFS Filesystem**: Required for Directory Junctions (`mklink /J`) and Hardlinks (`mklink /H`) to project rules without file duplication.
4. **Python for Google Antigravity**: Python 3.10+ virtual environment (`D:\Git_Repositories\.venv`) with `google-antigravity` SDK and `agy` CLI installed.
5. **Antigravity IDE / VS Code**: Multi-root parent workspace container (`D:\VSCode-Workspaces\Solution.code-workspace`).

---

## 2. Core Documentation Standards

The authoritative Lifecycle Model documentation is structured into three foundational specifications:

* **[Requirements (`docs/Requirements.md`)](docs/Requirements.md)**: Normative outcomes, system prerequisites, lifecycle states, and acceptance criteria.
* **[Architecture (`docs/Architecture.md`)](docs/Architecture.md)**: Dual-repo governance topology, NTFS junction projection model, 1-file-per-CR junction mirroring, batch test bundles, and the 4-phase onboarding pipeline.
* **[Implementation (`docs/Implementation.md`)](docs/Implementation.md)**: Complete inventory of PowerShell tools, modules, data schemas, and the requirement traceability matrix.

---

## 3. Configuration Management & Extended Guides

* **[Configuration Management Architecture (`docs/LCM-Configuration-Management.md`)](docs/LCM-Configuration-Management.md)**: Details `Workspace_Inventory` operational CM, junction CR mirroring, and drift detection.
* **[Repository Onboarding Architecture (`docs/LCM-Onboarding-Architecture.md`)](docs/LCM-Onboarding-Architecture.md)**: Deep dive into the 4-phase onboarding engine.
* **[Repository Inventory Matrix (`docs/LCM-Repository-Inventory.md`)](docs/LCM-Repository-Inventory.md)**: Classification and state matrix across all 33+ workspace directories.
* **[Standards & Versioning (`docs/Standards.md`)](docs/Standards.md)**: Semantic versioning, formatting, and file encoding standards.
* **[Workspace Conventions (`docs/Workspace Conventions.md`)](docs/Workspace%20Conventions.md)**: Standard directories, rule precedence, and path conventions.
* **[Evolution & Governance Logs (`docs/Logs/`)](docs/Logs/)**: Complete historical evolution lineage and continuous governance ledgers.

---

## 4. Key Verification Commands

* **Run Workspace_AI Quality Gates & Self-Readiness**:
  ```powershell
  pwsh -ExecutionPolicy Bypass -File .\tools\Test-WorkspaceReadiness.ps1
  ```

* **Onboard or Update a Target Repository**:
  ```powershell
  pwsh -ExecutionPolicy Bypass -File .\tools\Invoke-LCMOnboardRepo.ps1 -TargetRepositoryPath "..\<RepoName>" -Update
  ```
