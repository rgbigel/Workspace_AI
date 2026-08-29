---
name: ProposalReviewFlowPolicy
description: Governs the LCM Two-Tier Proposal lifecycle, ticket-first enforcement, batch operations, granularity controls, and dual-commit synchronization.
globs: "*"
---
# File: ProposalReviewFlowPolicy.md

Module: ProposalReviewFlowPolicy  
Purpose: Enforces ticket-first proposals, batch commands, Beyond Compare 5 review gates, granularity controls, and Workspace_Inventory dual-commit synchronization.  
Path: .agents/rules/ProposalReviewFlowPolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 7.0.0  
Status: Authoritative Policy  
Date: 2026-08-29  

---

## 1. Core LCM Review Flow Rules

### RULE-LCM-001: Proposal-First Intent Invariant
When working in LCM mode (`active`), all user ideas, questions, and exploratory discussions `MUST` be treated as **Proposals only** (State = `suggested`).
- The AI agent `MUST NOT` execute file modifications, code rewrites, or commits immediately upon receiving an initial idea or question.
- When discussion yields a conclusive path of action, register the Change Request / Proposal with State `suggested` in `Workspace_Inventory\data\proposals\proposals.json`.

### RULE-LCM-002: Batch Execution & Control Commands
Proposals transition through the defined lifecycle only upon explicit user instruction:
- **`give open Proposals`**: Returns numbered list of active proposals (`#n`).
- **`do <all, #n, #n-#m> Proposals`**: Sets matching proposals to `processed` and initiates code changes.
- **`delete <all, #n, #n-#m> Proposals`**: Sets matching proposals to `deleted` and clears associated CRs.
- **`defer <all, #n, #n-#m> Proposals`**: Sets matching proposals to `deferred`.
- **`give repos under review`**: Displays repositories with uncommitted changes, their BC5 review status, and commit readiness.

### RULE-LCM-003: Review Granularity Controls
The review frequency is governed by `review_granularity` in `Workspace_Inventory`:
- **`coarse` (Default)**: Executes all proposals in the batch, runs automated quality gates, then presents a **single BC5 review stop** for the combined changes across the repository before commit.
- **`tight`**: Implements each proposal incrementally with intermediate test runs and a **dedicated BC5 review stop per proposal**.
- Can be set via `set review granularity <coarse|tight>` or inline `do #1-#3 Proposals --tight`.

### RULE-LCM-004: Visual Diff Review & Exemption Scope
- **Governed Repositories & Root Container**: Every governed repository and the Root Container (`D:\Git_Repositories`) `MUST` undergo visual diff review via `Invoke-BeyondCompareReview.ps1 <RepoName>` before commit.
- **Sole Exemption**: `Workspace_Inventory` is **the only exempt repository** from visual BC5 review because it acts strictly as the tool/agent-controlled CM ledger (proposals, session state, review evidence, logs).

### RULE-LCM-005: Dual-Commit and Push Synchronization Invariant
1. Whenever code changes in a target repository are accepted and committed, `Workspace_Inventory` `MUST ALWAYS` be updated (updating proposal state to `completed`, recording review evidence) and **committed immediately**.
2. On any `git push`, all modified target repositories and `Workspace_Inventory` `MUST` be pushed to their respective remotes in lockstep.

### RULE-LCM-006: Pause and Resume Controls
- **`pause LCM`**: Temporarily suspends the proposal-first requirement for rapid ad-hoc tasks.
- **`resume LCM`**: Re-activates strict proposal-first governance.
- LCM status is scoped per repository and automatically resets to default active governance across new sessions.

### RULE-LCM-007: Dual-State Proposal Lifecycle & CM Plan Archive Invariant
1. **Dual-State Separation**: Every proposal in `Workspace_Inventory/data/proposals/proposals.json` `MUST` track both:
   - **Governance Plan State (`state`)**: Document approval state (`suggested`, `approved`, `deferred`, `rejected`, `completed`).
   - **Implementation Progress State (`progress_state`)**: Physical execution progress (`undecided`, `queued`, `in_progress`, `verification`, `completed`, `blocked`, `failed`).
2. **Initial Invariant**: Every newly submitted proposal and unapproved plan `MUST` initialize with `progress_state: "undecided"`.
3. **Mandatory CM Plan & Walkthrough Archival**:
   - All Markdown implementation plans and execution walkthroughs `MUST` be persistently archived in the governed CM repository under:
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Plan.md`
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Walkthrough.md`
   - Explicit relative links `plan_path` and `walkthrough_path` `MUST` be recorded in `proposals.json`.

