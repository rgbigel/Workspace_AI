# Lifecycle Model (LCM) Repository Inventory & Status Matrix

Module: LCM-Repository-Inventory.md
Purpose: Comprehensive inventory and governance status of all repositories and directories under D:\Git_Repositories governed by Solution.code-workspace.
Path: docs/LCM-Repository-Inventory.md
Authors: Rolf, Workspace_AI Engine
Version: 7.1.1
Date: 2026-08-15

---

## 1. Executive Summary & Version Baseline

* **Current Global LCM Baseline**: **`LCM pre-release Version 4.1.0`**
* **Active Upstream Design Workshop**: [`Workspace_AI`](file:///d:/Git_Repositories/Workspace_AI) (Clean, Governed, LCM v4.1.0)
* **Total Discovered Child Directories**: 33 directories under `D:\Git_Repositories\`
* **Governance Status Breakdown**:
  * **Active Design Workshop (LCM Engine v4.1.0)**: 1 (`Workspace_AI`)
  * **Candidate Onboarded Target (LCM v4.0.0 Dry-Run Verified)**: 1 (`VolumeInventory`)
  * **Standard Git Repositories (Un-onboarded / Not LCM)**: 14 repositories
  * **Retired Legacy Baselines**: 2 (`Workspace_AC`, `Workspace_GC`)
  * **Non-Git Child Directories (Not LCM)**: 10 directories
  * **Parent Solution Infrastructure Folders**: 5 directories (`.agents`, `.copilot`, `.github`, `.venv`, `.vscode`)

---

## 2. Complete Repository Inventory Matrix

| Directory / Repository | Git Status | Branch | HEAD Commit | LCM Status / Version | Classification & Role |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **`Workspace_AI`** | Git | `main` | `caab019` | **v4.1.0** | **Active Design Workshop & LCM Release Baseline** |
| **`VolumeInventory`** | Git | `main` | `e8b6aa8` | **v4.0.0** | **Candidate LCM Target (Verified dry-run, eligible for v4.1.0 update)** |
| **`BackgroundModifier`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`BackgroundModifier_AC`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`BootEntryManager`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`DiskAssignmentStatus`** | Git | `DocPhase` | `f6dcc42` | Not LCM | Standard Git Repo (Un-onboarded) |
| **`GetRecoveryVolume`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`InstallFonts`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`MacriumTemplateUpdater`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`MSG file conversion`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`NextBootTray`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`OutlookVBAConversion`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`PowerBGInfo`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`ReEnableRadeonRx580`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`SharedModules`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`TimeStamper`** | Git | `HEAD` | - | Not LCM | Standard Git Repo (Un-onboarded) |
| **`Workspace_AC`** | Git | `main` | `eb35191` | Retired | Legacy Recovery Baseline (Off-limits) |
| **`Workspace_GC`** | Git | `main` | `5576337` | Retired | Legacy Transitional Baseline (Off-limits) |
| **`AuthorizeMasterUser`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`BootOpsHub`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`CommandHub`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`DeviceInventory`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`DiskAssignmentStatus_AC`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`DiskAssignmentStatus_S1`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`EnvironmentTools`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`FileUtilities`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`GitTools`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`SystemConfiguration`** | Non-Git | - | - | Not LCM | Non-Git Component (`git.ignoredRepositories`) |
| **`.agents`** | Non-Git | - | - | Not LCM | Solution Root Customization Directory |
| **`.copilot`** | Non-Git | - | - | Not LCM | Solution Root Copilot Directory |
| **`.github`** | Non-Git | - | - | Not LCM | Solution Root GitHub Directory |
| **`.venv`** | Non-Git | - | - | Not LCM | Local Python Virtual Environment |
| **`.vscode`** | Non-Git | - | - | Not LCM | Solution Root VS Code Settings Directory |

---

## 3. Governance State Definitions & Transition Paths

### 1. Active Design Workshop (`Workspace_AI`)
* **Role**: The single source of truth for all LCM rules, methodologies, templates, quality gates, and onboarding tooling.
* **Current Version**: `4.1.0`.
* **State**: Unlocked during development; committed and tagged prior to global release.

### 2. Onboarded & Candidate Repositories (`VolumeInventory`)
* **Current Version**: `4.0.0`.
* **Transition Path**: Run `Invoke-LCMOnboardRepo.ps1 -TargetRepositoryPath "D:\Git_Repositories\VolumeInventory" -Update` to update junctions, hardlinks, and templates to `v4.1.0`.

### 3. Standard Git Repositories (14 Repositories)
* **Status**: Currently un-onboarded.
* **Transition Path**: Converted one-by-one under operator review using:
  ```powershell
  .\tools\Invoke-LCMOnboardRepo.ps1 -TargetRepositoryPath "D:\Git_Repositories\<TargetRepo>" -StepByStep
  ```

### 4. Non-Git Directories (10 Directories)
* **Status**: Codified under `git.ignoredRepositories`.
* **Transition Path**: When targeted for onboarding, `Invoke-LCMOnboardRepo.ps1` prompts to initialize `git init -b main`, writes standard `.gitignore`, and generates an initial `pre-LCM` baseline commit before seeding governance rules.



