---
name: MethodEfficiencyPolicy
description: Authoritative method efficiency policy enforcing mechanical artifact auto-acceptance, zero-test cascades, DOIT mode velocity, search dispatch, and tool catalog discovery.
globs: "*"
---
# File: MethodEfficiencyPolicy.md

Module: MethodEfficiencyPolicy  
Purpose: Defines auto-acceptance, zero-test-trigger invariants, and method efficiency rules for generated inventory telemetry, logs, DOIT mode execution velocity, and tool discovery.  
Path: .agents/rules/MethodEfficiencyPolicy.md  
Authors: Rolf, LCM_AI Engine  
Version: 8.6.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Purpose & Motivation

In the Lifecycle Model (LCM), Configuration Management (CM) audits, baseline snapshots, test execution evidence, and governance logs are generated deterministically and mechanically by approved tooling.

To maximize **Method Efficiency** and eliminate ceremonial overhead, this policy establishes that purely mechanical, tool-produced artifacts must **never block workflows for manual review** and **must never trigger redundant test runs**.

---

## 2. Invariant Rules

### RULE-EFF-001 (Mechanical Artifact Auto-Acceptance)
Changes strictly modifying tool-generated evidence, audit databases, dashboard summaries, and logs are **automatically accepted** without requiring manual review gates. This applies to:
* `LCM_Inventory/data/inventory.json`
* `LCM_Inventory/docs/INVENTORY_DASHBOARD.md`
* `LCM_Inventory/data/baselines/*.json`
* `LCM_Inventory/logs/*.log`
* `*_Inventory/data/subsystem_inventory.json` (Subsystem Inventories e.g. `HaSSD06_Inventory`)
* `*_Inventory/docs/SUBSYSTEM_DASHBOARD.md`
* `*_Inventory/logs/*.log` and `*_Inventory/data/proposals/*.json`
* `**/out/test_results.json`
* `.copilot/Logs/*.log` and `.agents/logs/*.log`

### RULE-EFF-002 (Zero-Test Cascade Invariant)
Modifications to the mechanical artifacts listed in `RULE-EFF-001` **MUST NEVER** trigger automated test runs, readiness test cascades, or validation cycles. These files are outputs/evidence of prior verification, not executable source code.

### RULE-EFF-003 (Machine-Only Mutation Authority)
Human operators and AI assistants `MUST NOT` hand-edit `inventory.json`, `INVENTORY_DASHBOARD.md`, or baseline snapshots. They must be modified solely by designated CM tools (`Invoke-WorkspaceAudit.ps1`, `New-WorkspaceBaseline.ps1`, `Invoke-LCMUpdate.ps1`).

### RULE-EFF-004 (DOIT Mode & Autonomous Execution Velocity Standard)
1. **DOIT Mode Execution**: When a proposal is in **`DOIT` Mode** (`always-proceed = $true`) — which occurs automatically upon `BUG` birth or when explicitly triggered on a `CRP` via the `do` command — AI pair-programming agents `SHALL` execute tool operations, script commands, and file edits directly under `always-proceed` and `allow` policies without introducing interactive chat planning pauses or per-tool confirmation prompts.
2. **Universal Gate 2 Review Boundary**: Execution velocity under `DOIT` mode proceeds continuously until the downstream Gate 2 Review stage (`RR.ps1` / `Invoke-BeyondCompareReview.ps1`) is reached per `RULE-REV-001`. Even critical, urgent, or internally generated BUGs `MUST NOT` circumvent Gate 2 review.
3. **Normal Cycle Alignment**: For CRPs progressing under the Normal Review Cycle via `Proceed`, agents implement approved changes with interactive checkpoints whenever open questions, architectural alternatives, or user choices are encountered.

### RULE-EFF-005 (Quality Gate Short-Circuiting & Negative-Outcome Prevention)
1. **Short-Circuit on Upstream Failure**: Multi-phase quality gates (`Test-RepoReadiness.ps1`, `Test-WorkspaceReadiness.ps1`) `MUST` execute tiered validations in prerequisite order (`Structure` $\rightarrow$ `Formatting` $\rightarrow$ `GovernanceLinks` $\rightarrow$ `ElevationConsistency` $\rightarrow$ `DocumentationFabric` $\rightarrow$ `PesterSuite`). If any structural tier fails, execution `MUST` abort immediately with a diagnostic message without executing downstream test suites.
2. **Zero Negative-Outcome Execution**: Agents and runners `MUST NEVER` dispatch tests or commands whose operational prerequisites (e.g. elevation, required modules, linked junctions) are known to be absent.

### RULE-EFF-006 (Agent Direct Execution Alignment — Reserved)
Reserved for future use. See RULE-EFF-004 for current agent execution policy.

---

### RULE-EFF-007: Mandatory Search Dispatch Standard
- File-name searches **must** use Everything's `es.exe` CLI, preferably through `Search-Everything.ps1` (`LCM_Inventory/tools/Search-Everything.ps1`). `es.exe` is resolved from PATH (the Everything directory is a Machine PATH entry set by `Set-GitRoot.ps1` from `docs/Requisites/external-tools.json`).
- Direct `es.exe` execution is **allowed from interactive desktop sessions** (agents, operator shells). It remains **prohibited in Session 0 and scheduled-task contexts**, where Everything's IPC is not authorized; those contexts use the wrapper, which falls back automatically.
- Transport order of `Search-Everything.ps1`: (1) `es.exe`, (2) the Everything HTTP REST API (port 8080, only if the operator enabled it), (3) a scoped `Get-ChildItem` scan. Failure of one transport never fails the operation.
- Content searches use `es.exe` with the `content:` filter when the Everything content index is healthy, otherwise `rg.exe` (installed machine-wide, see the Requisites manifest). Index changes are visible after a delay of usually under one second.
- The content-index settings in `Everything.ini` (indexing enabled, workspace folder covered, required file types covered) are verified by `Test-ExternalTools.ps1` as part of workspace readiness.

---
### RULE-EFF-008: Canonical Tool Discovery Standard
- Agents inspecting, modifying, or querying workspace tools or platform commands **must** query `LCM_Inventory/tools/tool_catalog.json` first as the **authoritative single source of truth** before any filesystem traversal.
- Agents are **strictly prohibited** from executing broad, unindexed grep searches across `.psm1`, `.ps1`, or `.cmd` files to locate tool signatures or parameters when `tool_catalog.json` can satisfy the query.

---

### RULE-ENV-003: Zero Speculative Relative Pathing
- Speculative dot-traversal paths (such as `.\..lcm`, `..\..\`, or any path containing `..` without explicit validation) are **prohibited** in tool invocations and script references.
- Tool and script invocations **must** anchor strictly to one of:
  1. `$PSScriptRoot` for same-repository references.
  2. Registered trampolines in `LCM_Inventory/Cmd/` for cross-repository dispatch.
  3. An explicit `Resolve-Path` / `Test-Path` pre-flight check before any path is consumed.

---

## 3. Enforcement & Governance Integration

- **Readiness Runners**: `Test-RepoReadiness.ps1` and `Test-WorkspaceReadiness.ps1` treat changes in log directories and `out/` as non-invalidating evidence and enforce short-circuiting on failure.
- **Git Commit Workflow**: Automated audit syncs and baseline captures may be committed and pushed directly as `chore(audit)` or `chore(telemetry)` without entering formal Change Request review loops.
- **Agent Execution Policy**: Agents must operate in direct execution mode; interactive approval loops in chat UI are superseded by the RR pipeline.
- **Search Enforcement (RULE-EFF-007)**: All agents and tooling must use `es.exe` (directly or through `Search-Everything.ps1`) for file-system searches; `rg.exe` is the fallback content-search tool when the Everything content index is unavailable.
- **Tool Discovery Enforcement (RULE-EFF-008)**: `tool_catalog.json` is the first-query target for all tool and command discovery; broad unindexed filesystem scans are prohibited.
- **Path Safety Enforcement (RULE-ENV-003)**: All path constructions must be grounded via `$PSScriptRoot`, registered trampolines, or explicit pre-flight resolution; speculative traversal is prohibited.






