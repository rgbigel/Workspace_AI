# MethodEfficiencyPolicy

Module: MethodEfficiencyPolicy.md  
Purpose: Defines auto-acceptance, zero-test-trigger invariants, and method efficiency rules for generated inventory telemetry and logs.  
Path: .agents/rules/MethodEfficiencyPolicy.md  
Authors: Rolf, Workspace_AI Engine  
Version: 1.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-08-16  

---

## 1. Purpose & Motivation

In the Lifecycle Model (LCM), Configuration Management (CM) audits, baseline snapshots, test execution evidence, and governance logs are generated deterministically and mechanically by approved tooling.

To maximize **Method Efficiency** and eliminate ceremonial overhead, this policy establishes that purely mechanical, tool-produced artifacts must **never block workflows for manual review** and **must never trigger redundant test runs**.

---

## 2. Invariant Rules

### RULE-EFF-001 (Mechanical Artifact Auto-Acceptance)
Changes strictly modifying tool-generated evidence, audit databases, dashboard summaries, and logs are **automatically accepted** without requiring manual review gates. This applies to:
* `Workspace_Inventory/data/inventory.json`
* `Workspace_Inventory/docs/INVENTORY_DASHBOARD.md`
* `Workspace_Inventory/data/baselines/*.json`
* `Workspace_Inventory/logs/*.log`
* `**/out/test_results.json`
* `.copilot/Logs/*.log` and `.agents/logs/*.log`

### RULE-EFF-002 (Zero-Test Cascade Invariant)
Modifications to the mechanical artifacts listed in `RULE-EFF-001` **MUST NEVER** trigger automated test runs, readiness test cascades, or validation cycles. These files are outputs/evidence of prior verification, not executable source code.

### RULE-EFF-003 (Machine-Only Mutation Authority)
Human operators and AI assistants `MUST NOT` hand-edit `inventory.json`, `INVENTORY_DASHBOARD.md`, or baseline snapshots. They must be modified solely by designated CM tools (`Invoke-WorkspaceAudit.ps1`, `New-WorkspaceBaseline.ps1`, `Invoke-LCMUpdate.ps1`).

### RULE-EFF-004 (Agent Direct Execution & RR Review Gating Alignment)
AI pair-programming agents operating under the Lifecycle Model (LCM) `SHALL` execute tool operations, script commands, and file edits directly under `always-proceed` and `allow` policies without introducing interactive chat planning pauses or confirmation prompts. Formal review gating, safety verification, and user acceptance are strictly and exclusively enforced downstream at the Review Request / Beyond Compare (`RR.ps1` / `Invoke-BeyondCompareReview.ps1`) commit stage per `RULE-REV-001`.

---

## 3. Enforcement & Governance Integration

- **Readiness Runners**: `Test-RepoReadiness.ps1` and `Test-WorkspaceReadiness.ps1` treat changes in log directories and `out/` as non-invalidating evidence.
- **Git Commit Workflow**: Automated audit syncs and baseline captures may be committed and pushed directly as `chore(audit)` or `chore(telemetry)` without entering formal Change Request review loops.
- **Agent Execution Policy**: Agents must operate in direct execution mode; interactive approval loops in chat UI are superseded by the RR pipeline.

