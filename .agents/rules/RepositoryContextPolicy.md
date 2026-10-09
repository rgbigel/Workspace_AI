---
name: RepositoryContextPolicy
description: Authoritative rule for automatic repository context detection, fast-tier ingestion, candidate fallback, and zero-redundant scan governance.
globs: "*"
---
# File: RepositoryContextPolicy.md

Module: RepositoryContextPolicy  
Purpose: Defines automatic active-document repository detection, fast-tier context priming, candidate fallback, and scan optimization invariants.  
Path: .agents/rules/RepositoryContextPolicy.md  
Authors: Rolf, LCM_AI  
Version: 8.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Context Ingestion Invariants

### `RULE-CTX-001` (Active Repository Scope Resolution)
At the start of every interaction or when switching focus, the agent `MUST` automatically identify the target repository from:
1. The currently active document / cursor file path in the IDE metadata.
2. Explicitly referenced repository paths in the user request.
3. If working at workspace root (`D:\Git_Repositories\`), the global context in [.agents/ACTIVE_CONTEXT.md](file:///d:/Git_Repositories/.agents/ACTIVE_CONTEXT.md) defines baseline scope.

### `RULE-CTX-002` (Fast-Tier Repository Context Priming)
When active work begins on a specific repository (e.g. `VolumeInventory`, `BootEntryManager`, `HaSSD06`, `BackgroundModifier`), the agent `MUST` prime its working context in a single targeted tier by reading:
1. `<TargetRepo>/LCM_Inventory/config.json` (for elevation requirements, governance version, and repository classification).
2. `<TargetRepo>/README.md` (for module purpose, exported functions/atoms, and prerequisites).
3. Any open Change Requests / proposals in `<TargetRepo>/docs/Proposals/` (or active task files).

> [!NOTE]
> **Unonboarded Candidate Fallback:**  
> If `LCM_Inventory/config.json` is missing from an inspected target directory, the agent `SHALL` classify the repository as an `unonboarded-candidate` and reference the LCM onboarding workflow (`Invoke-LCMOnboardRepo.ps1`) rather than failing or running broad recursive scans.

### `RULE-CTX-003` (Zero Redundant Scan Invariant)
The agent `MUST NOT` run multi-step recursive discovery scans (`list_dir`, broad grep) across the entire workspace when operating within the scope of an identified repository.

### `RULE-CTX-004` (Methodology Awareness)
The agent `MUST` remain aware of the global LCM triad at all times:
* **`LCM_AI`**: Governs release baselines (v4.3.0), templates, and quality gates.
* **`LCM_Inventory`**: Configuration Management engine, audit ledger, and cross-repo CR indexing.
* **`LCM_Shared`**: Reusable functional PowerShell atom library (`Logging`, `VolumeAtoms`, `BcdAtoms`).

### `RULE-CTX-005` (Learned Advice)
1. At the start of a session the agent `MUST` read `.agents/ACTIVE_CONTEXT.md` and `.agents/LEARNED_ADVICE.md`. Entries under **Accepted** are binding; entries under **Candidates** are guidance only.
2. When the operator writes `/learn <text>` the agent `MUST` add the text as a candidate (`Save-AllSessionMemory.ps1 -Learn "<text>" -Author <AI name>`), without changing anything else. An agent `MAY` also propose a candidate on its own when it learns something durable; it `MUST` tell the operator.
3. Candidates `MUST` be reviewed (`Invoke-LearnedAdviceReview.ps1`: accept, reject, or promote to a rule) no later than publishing. `Invoke-WorkspacePush.ps1` refuses to publish while candidates are pending.
4. Entries marked `[->rule]` are written into the matching rule file, after which the entry is replaced by a reference to that rule.


