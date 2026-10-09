# Lifecycle Model (LCM) Authoritative Governance Framework
> **Consolidated Master Specification for Gemini AI, Google Drive & Subagents**
> *Exported on: 2026-10-09 18:46:23 | Host: D5P0-SSD980-Z | Version: 1.2.0*

---

## 📑 Governance Matrix Table of Contents

### 1. Core Governance, Invariants & Security
- [1. RuleAuthority.md](#ruleauthoritymd)
- [2. InvariantRules.md](#invariantrulesmd)
- [3. ElevationPolicy.md](#elevationpolicymd)
- [4. LanguagePolicy.md](#languagepolicymd)
- [5. RepositoryContextPolicy.md](#repositorycontextpolicymd)

### 2. Proposal, Review & Commit Lifecycle
- [6. ProposalReviewFlowPolicy.md](#proposalreviewflowpolicymd)
- [7. ReviewCommitGovernancePolicy.md](#reviewcommitgovernancepolicymd)
- [8. MethodEfficiencyPolicy.md](#methodefficiencypolicymd)

### 3. Language & Coding Standards
- [9. PowerShellStandardsPolicy.md](#powershellstandardspolicymd)
- [10. PowerShellRules.md](#powershellrulesmd)
- [11. PythonRules.md](#pythonrulesmd)
- [12. CMDRules.md](#cmdrulesmd)
- [13. JsonRules.md](#jsonrulesmd)

### 4. Documentation & Subsystem Architecture
- [14. DocumentationStandardsPolicy.md](#documentationstandardspolicymd)
- [15. SubsystemGovernancePolicy.md](#subsystemgovernancepolicymd)
- [16. macro-definitions.md](#macro-definitionsmd)
- [17. Workspace AGENTS.md Directive](#workspace-agentsmd-directive)
- [18. Workspace GEMINI.md Directive](#workspace-geminimd-directive)

---

<a id="ruleauthoritymd"></a>
## Rule #1: RuleAuthority.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/RuleAuthority.md`

# File: RuleAuthority.md

Module: RuleAuthority  
Purpose: Defines canonical rule authority, governance hierarchy, and mandatory cross-reference synchronization across the workspace.  
Path: .agents/rules/RuleAuthority.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.0.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Governance Authority Invariants

### `RULE-AUTH-001` (Single Source of Truth & Zero Rule Forking)
- **Canonical Physical Hub**: `LCM_AI\.agents\rules\` is the single, authoritative physical host and primary commit gate for all LCM governance rules.
- **Root & Child Discovery**: The root workspace container links `D:\Git_Repositories\.agents\rules\` directly to `LCM_AI\.agents\rules\` via NTFS directory junction (`mklink /J`), avoiding rule commit churn on the root container. All governed child repositories link their local `.agents\rules` directory to this canonical hub.
- **No Independent Truth**: Child repositories and IDE adapter surfaces `MUST NOT` fork, maintain conflicting local copies, or override core governance policies without an approved Change Request.

---

### `RULE-AUTH-002` (Mandatory Rule Matrix Synchronization Invariant)
Whenever an existing rule is updated, or a new rule/policy is created ("invented"), the author or AI agent `MUST` update all discovery entrypoints in the same change set:
1. **Root Quick-Reference Table**: Update [`AGENTS.md`](file:///d:/Git_Repositories/AGENTS.md) with the new rule name, rule codes (`RULE-*`), domain, scope, and key invariant.
2. **Comprehensive Matrix**: Update [`LCM_AI/docs/LCM-Rules-Cross-Reference.md`](file:///d:/Git_Repositories/LCM_AI/docs/LCM-Rules-Cross-Reference.md) with the full metadata, enforcing scripts, and quality gate mappings.
3. **Child Junction Verification**: Verify that the newly created rule is immediately visible across all child repository `.agents\rules` junctions.

---

## 2. Activation Commands
- `@RULEAUTH`: Activates and validates the canonical source-of-truth and synchronization policy.

---

<a id="invariantrulesmd"></a>
## Rule #2: InvariantRules.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/InvariantRules.md`

# File: InvariantRules.md

Module: InvariantRules  
Purpose: Authoritative invariant rules for workspace behavior, encoding, determinism, and generation.  
Path: .agents/rules/InvariantRules.md  
Authors: Rolf  
Version: 8.2.0  
Status: Authoritative Invariant Rule  
Date: 2026-10-03  

---

## 1. Core Invariant Rules

### INVARIANT-RULES
- **determinism**: Identical input $\rightarrow$ identical output.
- **reproducibility**: No randomness or speculative inferences.
- **ascii-default**: ASCII required unless explicit exceptions apply:
  - Markdown (`.md`) files may contain Unicode (arrows, bullets, umlauts, typographic symbols).
  - PowerShell literal strings and comments may contain umlauts.
  - HTML and UI presentation assets (`.html`, `.css`, `.js`) may contain Unicode glyphs and standard UI emojis as defined in DisplayStandardsPolicy.md.
- **no-non-ascii-identifiers**: Identifiers, variables, function names, and file names must be ASCII-only.
- **constant-string-apostrophes**: Use single ASCII apostrophes (`'...'`) for constant strings.
- **indent-2**: Indentation level is exactly 2 spaces (no tabs).
- **newline-crlf**: Windows-native files must end with CRLF.
- **utf8-without-bom**: All text and code files must be saved as UTF-8 without BOM.
- **structure**: Clear hierarchical markdown sections, bulleted lists, and typed code blocks.
- **no-assumptions**: State unknown facts rather than guessing; never invent facts or speculate.
- **zero-assumption-testing**: The AI assistant `MUST NOT` assume or claim that code, scripts, configurations, or proposals are valid, functional, or ready without actively running mechanical tests, compilation, or parser verification. Relying on visual inspection alone or declaring ready without executing test verification is strictly prohibited.
- **mandatory-pre-handoff-syntax-gate**: Every created or modified script, module, or configuration file (`*.ps1`, `*.psm1`, `*.py`, `*.json`, `*.cmd`) `MUST` pass automated syntax parsing or compilation (`ParseInput` for PowerShell, `py_compile` for Python, `ConvertFrom-Json` for JSON) before concluding a turn, proposing review, or claiming completion. Zero syntax errors or parse warnings are tolerated.
- **no-verbosity**: Minimal, direct, and non-repetitive communication; zero conversational padding or pleasantries.
- **zero-conversational-padding**: Prohibit conversational filler, greetings, pleasantries, or preamble/postamble framing.
- **explicit-reasoning**: Provide clear, deterministic technical rationale for all actions, architecture, and diagnostics.
- **english-default-language**: English invariant for all code, comments, documentation, and commit messages.
- **timestamp-header-rule**: Mandatory response output header on every assistant response in the exact format:
  `YYYYMMDD_HHMM "<short-task-description>"`
  Permanent, automated mechanism inherited across all sessions (replaces manual `@tsr` / `@THR` / `@TRH` prompting).
- **tool-and-log-timestamp-precision**: Tool execution timestamps, generated log file names, and internal log entries `MUST` include at least second-level precision (`ss`) (e.g. `yyyyMMdd_HHmmss` or `yyyy-MM-dd HH:mm:ss[.fff]`). The minute-level format (`YYYYMMDD_HHMM`) applies strictly and exclusively to the assistant chat response header, never to tools or logs.
- **no-backtick-line-continuations**: Script generation must not use backticks (`` ` ``) for line continuation; use splatting, pipeline wrapping, or parenthesized expressions instead.

---

## 2. Activation Commands & Legacy Macro Compatibility

- **Native Rule Inheritance**: Rules in this file are auto-inherited across all agent interactions via `.agents/rules/`.
- `@tsr` / `@THR` / `@TRH` / `@IRA`: Legacy prompt macros for TimestampHeaderRule and InvariantRules. Now superseded by persistent, native rule enforcement.
- `@ml`: Shows ordered visible messages in current chat.

---

<a id="elevationpolicymd"></a>
## Rule #3: ElevationPolicy.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/ElevationPolicy.md`

# File: ElevationPolicy.md

Module: ElevationPolicy  
Purpose: Defines mandatory elevation, runner delegation, and privilege interception rules across all repositories.  
Path: .agents/rules/ElevationPolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.6.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Rule Overview & Core Invariants

Certain solution components (such as disk/volume inspectors, boot configuration tools, driver managers, and background service setters) require Windows Administrator privileges to access low-level operating system APIs (e.g. `bcdedit`, `fltmc`, `fsutil`, `Get-Partition`, `DiskPart`).

To maintain predictability, prevent hanging automated runners, and enforce documentation-to-code consistency across the workspace, the following rules are mandatory:

---

## 2. Normative Elevation Rules

### `RULE-ELEV-001` (Mandatory Elevation Metadata)
Every repository governed under LCM `MUST` declare an explicit `execution_context` block inside its `LCM_Inventory/config.json`:
```json
"execution_context": {
  "elevation_required": true,
  "minimum_privilege": "Administrator",
  "reason": "Requires low-level access to bcdedit, fltmc volumes, and storage IOCTLs"
}
```
* If the repository does not require elevation, `elevation_required` `MUST` be set to `false`, `minimum_privilege` to `"User"`, and `reason` to `"Standard user execution"`.

### `RULE-ELEV-002` (Guarded Self-Elevation in Source Code)
Any script within `src/` or `Source/` that implements interactive self-elevation (`Start-Process pwsh -Verb RunAs`) `MUST` guard the elevation call with non-interactive detection:
1. `MUST` check whether the environment is interactive (`[Environment]::UserInteractive` and presence of console UI).
2. `MUST` support an explicit `-NoElevation` or `-ForceInProcess` switch to suppress UAC popups during automated test execution.
3. `MUST NOT` block headless CI/CD agents, IDE test adapters, or background runners on modal GUI UAC prompts.

### `RULE-ELEV-003` (Privileged Code Declaration & Anti-Drift)
Any code in `src/` or `Source/` utilizing privileged Windows commands (`bcdedit`, `fltmc`, `fsutil`, `Get-Partition`, `DiskPart`, `Add-BitLockerKeyProtector`, or `Verb RunAs`) `MUST` have `elevation_required: true` declared in `LCM_Inventory/config.json`.
* The quality gate `Assert-RepoElevationConsistency` `MUST` fail if undeclared privileged code is detected in a repository configured with `elevation_required: false`.

### `RULE-ELEV-004` (Automated Elevated Test Runner)
Every repository with `elevation_required: true` `MUST` provide a standardized elevated test runner (`tools/Invoke-ElevatedTest.ps1`):
1. Automatically executes Pester tests in-process when the current session is already elevated.
2. When called from a standard user session, dispatches an elevated worker process (`Start-Process -Verb RunAs`), captures the test run, and writes structured JSON test evidence (`out/test_results.json`).
3. Quality gates `MUST` certify test passage based on the generated test evidence.

### `RULE-ELEV-005` (Elevated Console Non-Auto-Close Invariant)
When an interactive script or launcher delegates execution to an elevated console window (`Start-Process pwsh.exe ... -Verb RunAs` or `cmd.exe ... -Verb RunAs`), the spawned elevated window `MUST NOT` automatically close upon script completion.
1. The process invocation `MUST` include `-NoExit` (for `pwsh.exe`) or `/k` (for `cmd.exe`), or terminate with an explicit interactive completion prompt (`Read-Host "Press Enter to exit..."`).
2. This guarantees the operator can inspect output logs, execution summaries, and error diagnostics directly in the elevated terminal without premature window dismissal.
3. **Caller & Worker Notification Standard**:
   - The delegating caller (elevator) `MUST` explicitly display a structured pre-launch banner in the active terminal containing:
     - **Timestamp**: Current system timestamp (`yyyy-MM-dd HH:mm:ss`).
     - **Launch Method**: e.g. `Windows UAC Interactive Elevation (Start-Process -Verb RunAs)`.
     - **Target Script & Arguments**: Full executable/script path and parameters forwarded.
     - **Audit Log Path**: Destination log file where live execution telemetry is recorded.
     - **Window Mode Notice**: Clear indication that the elevated console will remain open upon completion per `RULE-ELEV-005`.
   - The elevated worker `MUST` output a clear completion notice upon finishing indicating that the window has been intentionally kept open for operator inspection.

### `RULE-ELEV-006` (Automated Privilege-Aware Tool Execution & Elevation Interception)
Ensure that any tool, script, or shorthand command requiring administrative privileges is never executed directly within a standard un-elevated user context. Instead, enforce automatic discovery and routing through the standardized CLI interceptor (`LCM_Inventory/tools/Invoke-PrivilegedTool.ps1`), the background desktop daemon (`http://127.0.0.1:9876/execute`), or `Invoke-InteractiveDesktop.ps1`.

Before executing any tool, script, or shorthand command, the AI agent or CLI launcher `MUST` perform the following validation sequence:
1. **Catalog & Schema Lookup**:
   - Query the authoritative tool catalog (`LCM_Inventory/config/tool_catalog.json` / `WorkspaceInventory`) to resolve the target tool's metadata record.
   - Inspect whether the execution profile defines `"Admin": true` (or equivalent elevation requirement flag).
2. **Context & Privilege Verification**:
   - Check whether the current runtime shell session holds elevated administrative rights (e.g. `([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)`).
3. **Execution Routing & Interception**:
   - **Standard Execution**: If the tool does **not** require admin rights (`"Admin": false` or unset), execute it directly in the current session.
   - **Elevated Interception**: If `"Admin": true` and the current session is running under a standard un-elevated user context, **do not** execute the script directly in that session. Immediately route the call via:
     ```powershell
     pwsh LCM_Inventory/tools/Invoke-PrivilegedTool.ps1 -Tool <ToolName> [-Arguments <Args>] [-NoExit]
     ```
   - **Automated Dispatch Pipeline**: `Invoke-PrivilegedTool.ps1` and generated `.cmd` trampolines inspect the Session 1 Desktop Daemon on port 9876 and dispatch via `POST /execute` (`{ "command": "...", "elevated": true, "noExit": true }`), falling back to `Invoke-InteractiveDesktop.ps1 -Elevated` if the daemon is offline. Console windows launched via elevation `MUST` include `-NoExit` / `/k` per `RULE-ELEV-005`.

---

<a id="languagepolicymd"></a>
## Rule #4: LanguagePolicy.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/LanguagePolicy.md`

# File: LanguagePolicy.md

Module: LanguagePolicy
Purpose: Authoritative rule enforcing English language usage across all workspace documentation, file names, and code.
Path: .agents/rules/LanguagePolicy.md
Authors: Rolf
Version: 8.0.0
Changelog:
- 2026-08-15: Initial persistent rule for English language invariant across all documentation, file names, code, and comments.

LANGUAGE-POLICY-RULES
- english-always: Use English language always for all documentation, file names, code, comments, change proposals, and commit messages.
- foreign-language-exception: Non-English languages are permitted only when explicitly working on targeted foreign language localization or translation tasks.
- english-filenames: All file and directory names must use English, ASCII-only naming.
- documentation-language: All markdown (.md) documents, headers, and specifications must be written in English.
- code-comments: All source code comments and docstrings must be written in English.

---

<a id="repositorycontextpolicymd"></a>
## Rule #5: RepositoryContextPolicy.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/RepositoryContextPolicy.md`

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

### `RULE-CTX-006` (GoodMorning Session Start)
1. At the start of every session the agent `MUST` run `Invoke-WorkspaceGoodMorning.ps1 -Auto`. It is silent (one line) when less than 7 hours have passed since the last activity; a longer gap implies a good morning and produces the full read-only report.
2. When the report lists attention items (work in between, version disagreement, stale context, pending candidates, guardrail findings) the agent `MUST` tell the operator in its first reply, before any other work.
3. The agent `MUST` also state that it has read `ACTIVE_CONTEXT.md` and `LEARNED_ADVICE.md`, can follow them, and name anything unclear, contradictory or stale. It `MUST NOT` rely on parts of `ACTIVE_CONTEXT.md` that the report marks as stale.
4. GoodMorning is read-only; it `MUST NOT` be used to change, commit or publish anything.

---

<a id="proposalreviewflowpolicymd"></a>
## Rule #6: ProposalReviewFlowPolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/ProposalReviewFlowPolicy.md`

# File: ProposalReviewFlowPolicy.md

Module: ProposalReviewFlowPolicy  
Purpose: Enforces ticket-first proposals, batch commands, Beyond Compare 5 review gates, granularity controls, and LCM_Inventory dual-commit synchronization.  
Path: .agents/rules/ProposalReviewFlowPolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 9.2.0
Status: Authoritative Policy  
Date: 2026-10-03

---

## 1. Core LCM Review Flow Rules

### RULE-LCM-001: Proposal-First Intent Invariant
When working in LCM mode (`active`), all user ideas, questions, and exploratory discussions `MUST` be treated as **Proposals only** (State = `suggested`).
- The AI agent `MUST NOT` execute file modifications, code rewrites, or commits immediately upon receiving an initial idea or question.
- When discussion yields a conclusive path of action, register the Change Request / Proposal with State `suggested` in `LCM_Inventory\data\proposals\proposals.json`.

### RULE-LCM-002: Batch Execution, Control Commands & Flow Switch Activation
Proposals transition through the defined lifecycle via deterministic operator commands:
- **`Proceed` / `Proceed <ID>`**: **Single-step status increment**. Deterministically advances matching proposal(s) forward by exactly one discrete Sync Point along the flat lifecycle continuum (`Suggested` $\rightarrow$ `Scoped` $\rightarrow$ `Decided` $\rightarrow$ `In_Progress` $\rightarrow$ `Verified` $\rightarrow$ `Committed` $\rightarrow$ `Published`).
- **`do <all, #n, #n-#m> Proposals`**: **Sets flow switches!** Specifically activates the **`-DOIT` switch** (`always-proceed = $true`), bypassing Gate 1 planning pauses and executing continuously through `In_Progress` and verification until the downstream Review Decision checkpoint (Gate 2) is reached per `RULE-EFF-004`.
- **`hold <all, #n, #n-#m> Proposals`**: Sets the **`HELD` disposition** with a mandatory reason, suspending active work at its current Sync Point. Pauses all active flow switches. (Supersedes legacy `defer`).
- **`resume <all, #n, #n-#m> Proposals`**: **Reactivation action** that clears the `HELD` disposition and restores the proposal to active flow at its suspended Sync Point. Resume is an operator action, NOT a milestone or status.
- **`COMPLETE` / `COMPLETE ALL`**: Records a completed visual review, creates local commits, and advances the reviewed proposal to `Committed`. It never pushes to a remote.
- **`PUBLISH`**: Publishes only a preflighted cohort of `Committed` proposals and `LCM_Inventory` to their remotes in lockstep (`Committed` $\rightarrow$ `Published`). `PUSH` remains a backward-compatible command alias. Suggested, scoped, in-progress, and uncommitted items are strictly excluded.
- **`cancel <all, #n, #n-#m>`**: **Administrative ticket withdrawal at Gate 1**. Indicates the proposal is dropped, infeasible, or superseded during intake, scoping, or planning ratification. Zero working-tree modifications, zero code reverts, and zero rule modifications occur. The proposal transitions to terminal disposition `Cancelled` and all active flow switches are unconditionally turned **OFF**.
- **`reject <all, #n, #n-#m>`**: **Implementation rejection at Gate 2**. Indicates the physical implementation or review failed visual inspection, automated verification, or operator acceptance during the `Verified` review checkpoint. Actively rolls back and undoes working-tree modifications introduced by the proposal (for batches/cohorts, reverts all proposals in the cohort back to the clean pre-CRP baseline). The proposal transitions to terminal disposition `Rejected` and all active flow switches are unconditionally turned **OFF**.
- **`give open Proposals`**: Returns numbered list of active proposals (`#n`).
- **`give repos under review`**: Displays repositories with uncommitted changes, their BC5 review status, and commit readiness.

### RULE-LCM-003: Review Granularity Controls
The review frequency is governed by `review_granularity` in `LCM_Inventory`:
- **`coarse` (Default)**: Executes all proposals in the batch, runs automated quality gates, then presents a **single BC5 review stop** for the combined changes across the repository before commit.
- **`tight`**: Implements each proposal incrementally with intermediate test runs and a **dedicated BC5 review stop per proposal**.
- **Idempotent Single-Window Review Invariant**: A review stop `MUST NOT` open a duplicate window or redundant tab if the comparison or proposal is already open or currently being reviewed. In Beyond Compare 5, re-invoking review for an open comparison must simply refresh the existing session/tab in place and bring it to focus; opening two windows for the same comparison is strictly prohibited.
- Can be set via `set review granularity <coarse|tight>` or inline `do #1-#3 Proposals --tight`.

### RULE-LCM-004: Visual Diff Review & Exemption Scope
- **Governed Repositories & Root Container**: Every governed repository and the Root Container (`D:\Git_Repositories`) `MUST` undergo visual diff review via `Invoke-BeyondCompareReview.ps1 <RepoName>` before commit, subject to authorized exceptions in `RULE-REV-001`.
- **Dual-Session Junction Review**: For repositories containing NTFS directory junctions (e.g. `.agents` pointing to `LCM_AI\.agents`, or `.agents\rules` pointing to `LCM_AI\.agents\rules`), `Invoke-BeyondCompareReview.ps1` `MUST` automatically dispatch a second Beyond Compare review session targeting the live junction destination on the right pane per `RULE-REV-008`.
- **Privileged Subsystem Data Exemption vs. Tool Scrutiny**:
  - **Dynamic Configuration & Ledger Data Exemption (`RULE-EFF-001`)**: Ledger data, review staging receipts, baseline manifests, telemetry logs, and scratch generation outputs located in `LCM_Inventory` (`data/`, `logs/`, `scratch/`) are auto-accepted mechanical evidence and exempt from visual diff review stops.
  - **Executable Tools & Documentation Scrutiny**: All permanent scripts, PowerShell modules, test suites, and architectural documentation located in `LCM_Inventory` (`tools/`, `modules/`, `docs/`, `tests/`, `Cmd/`) are first-class governed LCM software assets and `MUST` undergo visual diff review via `Invoke-BeyondCompareReview.ps1 LCM_Inventory` prior to commit.

### RULE-LCM-005: Dual-Commit and Push Synchronization Invariant
1. Whenever code changes in a target repository are accepted and committed, `LCM_Inventory` `MUST ALWAYS` be updated (updating proposal state to `completed`, recording review evidence) and **committed immediately**.
2. On any `PUSH`, all completed target repositories and `LCM_Inventory` `MUST` pass a non-mutating lockstep preflight before any remote dispatch. A failed preflight blocks the entire cohort.

### RULE-LCM-006: Pause, Resume, and Escape Controls
1. **`LCM OFF` (Emergency Escape Switch)**:
   - Temporarily suspends proposal bundle scaffolding and governance gating to enable immediate emergency remediation of corrupted host configurations or broken environments.
   - Re-activated via `LCM ON` or `resume LCM`.
2. **`Testing OFF` (Deferred Deep Testing Switch)**:
   - Suppresses heavy, multi-minute test cascades (deep Pester DAGs, elevated integration test suites) during rapid interactive development and intermediate Review Decision checkpoints.
   - Syntax validation and fast unit checks still run, but deep testing is strictly deferred to the pre-push quality gate.
   - **Deferred Failure Protocol**: If deep testing encounters errors during pre-push validation, the push is immediately aborted and the failure automatically spawns a formal **`BUG`** proposal bundle in `DOIT` mode (`RULE-LCM-008`).
3. **Push Auto-Reset Invariant (Self-Healing Governance)**:
   - Neither `LCM OFF` nor `Testing OFF` may remain active after publication. Upon any push invocation (`PUSH`, `Invoke-WorkspacePush.ps1`), both **LCM Mode** and **Testing Mode** `MUST` unconditionally reset to `ON` (`active`).

### RULE-LCM-007: Flat Lifecycle Continuum, Sync Points, Dispositions & CM Plan Archive Invariant
1. **Single-Dimensional "Flat" Status Continuum**:
   - Status is strictly single-dimensional. Multi-dimensional status architectures (such as conflicting `progress_state` vs `state` where internal state stalled on `approved` while physical progress moved secretly) are prohibited.
   - External status binds the internal state directly at **7 canonical Sync Points (Milestones)**. When identical, the single canonical name `MUST` be used across all rules, tools, and UI displays:
     `Suggested` $\rightarrow$ `Scoped` $\rightarrow$ `Decided` $\rightarrow$ `In_Progress` $\rightarrow$ `Verified` $\rightarrow$ `Committed` $\rightarrow$ `Published`.
2. **Canonical Sync Points (Milestones)**:
   - **`Suggested` (0)**: Initial proposal registration / intake. Proposal bundle scaffolded in `docs/Proposals/`; Gate 1 planning pause.
   - **`Scoped` (1)**: Proposal bound to target repository, primary app (`App: #`), and constituent manifest.
   - **`Decided` (2)**: Architecture, requirements, and plan ratified (`Approved` disposition); Gate 1 passed.
   - **`In_Progress` (3)**: Active implementation underway; continuous code modifications and unit tests executing.
   - **`Verified` (4)**: Implementation complete; minimal / automated tests passed; Gate 2 visual diff review stop dispatched.
   - **`Committed` (5)**: Gate 2 visual review accepted (`Approved` disposition); review receipt filed in `reviews/`; local Git commit created.
   - **`Published` (6)**: Walkthrough archived in CM; lockstep preflight verified; remotes synchronized (`Published` preferred over `Pushed`).
3. **Dispositions vs. Status**:
   Dispositions and Plan State are not part of any CM-flow rule as separate dimensions, but are conditions or markers resulting from status and actions:
   - **`BUG`**: A disposition (not a substitute term for CRP). When assigned to a proposal, it sets flow switches to force flow exceptions—specifically activating the **`-DOIT` switch** (`always-proceed = $true`), bypassing Gate 1 planning pauses, while halting at Gate 2 visual review (`RULE-LCM-008`).
   - **`HELD`**: An exceptional disposition suspending a proposal at its current Sync Point. There is NO `defer` action or status anymore—it is simply `HELD`. When `HELD`, active flow switches are paused. Cleared by the `resume` action.
   - **`Approved`**: A disposition recorded at sync points (specifically at `Decided` for Gate 1 plan approval, and `Committed` for Gate 2 review acceptance).
   - **`Completed`**: Disposition indicating completed review and commit prior to or at `Published`.
   - **`Cancelled`**: Terminal administrative disposition at Gate 1 indicating ticket withdrawal (proposal dropped, infeasible, or superseded during intake, scoping, or planning ratification). Involves **zero code reverts**, zero working-tree modifications, and zero rule modifications. Reaching `Cancelled` unconditionally turns **OFF** all active flow switches.
   - **`Rejected`**: Terminal implementation disposition at Gate 2 indicating rejection of physical modifications during visual diff review (`Verified` checkpoint). Actively triggers **rollback and removal of uncommitted working-tree modifications** introduced by the proposal back to the clean pre-CRP baseline (or full cohort rollback for batches). Reaching `Rejected` unconditionally turns **OFF** all active flow switches.
4. **Governed Flow Switches**:
   Flow switches modify execution behavior and velocity across sync points:
   - **`-DOIT`** (`always-proceed = $true`): Activated by `do` command or `BUG` disposition. Bypasses Gate 1 planning pause and executes continuously through `In_Progress` to `Verified`.
   - **`-Force` / `-Immediately`**: Authorizes bypass of Gate 2 visual diff review under strict emergency exception criteria (`RULE-REV-001`).
   - **`-MinimalTests`**: Single-cycle execution switch restricting test DAG to fast regression checks (`RULE-LCM-023`).
   - **`-Coarse` / `-Tight`**: Granularity switch controlling single combined review stop per batch (`-Coarse`) vs. stop per proposal (`-Tight`) (`RULE-LCM-003`).
   - **`LCM OFF`**: Emergency escape switch suspending governance scaffolding and gating (`RULE-LCM-006`).
   - **`Testing OFF`**: Deferred deep testing switch suppressing heavy cascades during interactive development (`RULE-LCM-006`).
5. **Mandatory CM Plan & Walkthrough Archival**:
   - All Markdown implementation plans and execution walkthroughs `MUST` be persistently archived in the governed CM repository under:
     - `LCM_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Plan.md`
     - `LCM_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Walkthrough.md`
   - Explicit relative links `plan_path` and `walkthrough_path` `MUST` be recorded in `proposals.json`.
6. **Authoritative Flat Lifecycle Matrix & State Diagram**:

   #### A. Canonical Flat Lifecycle Matrix

   | Sync Point (Milestone) | Canonical Status Name | Operator Action | Dispositions at Sync Point | Active Flow Switches | CM Side Effect & Invariant |
   |:---|:---|:---|:---|:---|:---|
   | **0. Suggested** | `Suggested` | `suggest` | `BUG` (sets `-DOIT`) | Default | Bundle scaffolded in `docs/Proposals/`; Gate 1 pause. |
   | **1. Scoped** | `Scoped` | `scope` | — | Default | Bound to origin repo, primary app (`App: #`), and constituent manifest. |
   | **2. Decided** | `Decided` | `approve` / `Proceed` | `Approved` | Default | Gate 1 passed; architecture and plan ratified. |
   | **3. In_Progress** | `In_Progress` | `start` / `do` (sets `-DOIT`) | — | `-DOIT` (if `do`/`BUG`) | Active code modification; unit tests executing. |
   | **4. Verified** | `Verified` | `verify` / `bcr` | — | `-MinimalTests` (optional) | Implementation complete; tests pass; Gate 2 BC5 review dispatched. |
   | **5. Committed** | `Committed` | `reviewed` / `commit` / `COMPLETE` | `Approved`, `Completed` | `-Force` (if authorized) | Review accepted; receipt in `reviews/`; local Git commit created. |
   | **6. Published** | `Published` | `publish` / `push` | `Completed` | Auto-Reset (`ON`) | Walkthrough archived; lockstep preflight passed; remotes pushed. |
   | **[Condition] Held** | Current Sync Point | `hold` | `HELD` | Paused | Work suspended; reason recorded in CM ledger. Cleared by `resume`. |
   | **[Terminal] Cancelled** | Discarded (Gate 1) | `cancel` | `Cancelled` | Turned OFF | Administrative withdrawal at Gate 1; zero working-tree modifications; zero code reverts. |
   | **[Terminal] Rejected** | Discarded (Gate 2) | `reject` | `Rejected` | Turned OFF | Implementation rejection at Gate 2; working-tree modifications actively rolled back to pre-CRP baseline. |

   #### B. Canonical Flat Lifecycle State Diagram

   ```mermaid
   stateDiagram-v2
       direction TB

       [*] --> Suggested: Intake (suggest)
       Suggested --> Scoped: Scope (bind repo / app)
       Scoped --> Decided: Decide / Approve Plan (Gate 1 Passed)
       Decided --> In_Progress: Start / do (sets -DOIT)
       In_Progress --> Verified: Verify Tests Passed
       Verified --> Committed: Accept BC5 Review & Commit (Gate 2 Passed)
       Committed --> Published: Publish / Push to Remote
       Published --> [*]

       %% Exception Flow: HELD Suspension
       In_Progress --> Held: hold (sets HELD disposition)
       Scoped --> Held: hold
       Decided --> Held: hold
       Held --> In_Progress: resume (clears HELD disposition)

       %% Exception Flow: Gate 1 Administrative Withdrawal (Zero Reverts)
       Suggested --> Cancelled: cancel (Gate 1 withdrawal / zero reverts)
       Scoped --> Cancelled: cancel (Gate 1 withdrawal / zero reverts)
       Decided --> Cancelled: cancel (Gate 1 withdrawal / zero reverts)

       %% Exception Flow: Gate 2 Implementation Rejection (Rollback to Baseline)
       Verified --> Rejected: reject (Gate 2 review rejection / rollback to baseline)
       In_Progress --> Rejected: reject (aborted implementation / rollback to baseline)

       Cancelled --> [*]
       Rejected --> [*]
   ```

### RULE-LCM-008: BUG Disposition, DOIT Mode & Review Decision Non-Circumvention Baseline
1. **Flow Exception via `BUG` Disposition**: When a proposal is assigned the `BUG` disposition (whether reported by the operator or self-discovered during test execution), it sets flow switches to force flow exceptions. Specifically, it automatically activates the **`-DOIT` switch** (`always-proceed = $true`).
   - The agent scaffolds the proposal bundle (`docs/Proposals/BUG-<nnn>-[Slug]/`) and immediately executes code modifications, script adjustments, and unit verification tests continuously without pausing for a Gate 1 planning approval.
2. **Review Decision Non-Circumvention Baseline & Authorized Exceptions**:
   - By default, even a critical or urgent proposal with disposition `BUG` halts at the Review Decision checkpoint (Gate 2) upon reaching Sync Point `Verified`.
   - Once the fix is verified in the working tree and logged in `Walkthrough.md`, the agent dispatches the visual review session (`Invoke-BeyondCompareReview.ps1`) and awaits operator review disposition.
   - **Authorized Gating Exceptions (`RULE-REV-001`)**: Review gate confirmation may be bypassed only if:
     1. The user explicitly instructs (`IMMEDIATELY`, `FORCE`) to advance directly into implementation or commit.
     2. A critical system bug impedes the intended flow and leads to an unavoidable loop/recursion that the user cannot avoid or fix, bound strictly by the 2-attempt loop breaker (`RULE-LCM-017`).
     - In either case, the bypass justification `MUST` be logged in the proposal bundle and Configuration Management ledger.

### RULE-LCM-009: Scope and Version-Explicit CRP Naming Standard
1. **Canonical Directory Bundle Convention**: All Change Request Proposals (CRPs) `MUST` follow the standardized bundle directory structure:
   `docs/Proposals/CRP-<nnn>-[Slug]/` containing `Specification.md`, `Implementation_Plan.md`, and `Walkthrough.md`.
   - `nnn`: Universal monotonic sequence integer zero-padded to at least 3 digits (e.g. `018`, `119`), matching the proposal ledger `id` 1:1.
   - `[Slug]`: Descriptive kebab-case intent description.
2. **Mandatory Header Metadata**: Every CRP specification `MUST` include explicit metadata fields:
   - `Target Scope`: Explicit repository or subsystem boundary.
   - `Affected Version Range`: Semantic version or range.
   - `Impacted Repositories`: Array of modified repositories.
3. **Legacy Flat File Fallback**: Historical CRPs (e.g. `CRP-001` through `CRP-017`) authored as flat `.md` files remain valid and governed under `RULE-LCM-020` Mode 3 (Legacy Fallback).

### RULE-LCM-010: Mandatory Self-Discovered Bug Registration Invariant
1. **Mandatory Self-Discovery Reporting**: Whenever the AI agent discovers a bug, syntax defect, unhandled runtime exception, parser failure, or regression in a permanent tool, platform script, shared module, or web UI during development, testing, or tool execution (including deferred deep testing failures per `RULE-LCM-006`), the AI agent `MUST` formally register a Bug Report in `LCM_Inventory/data/proposals/proposals.json` and scaffold the accompanying proposal bundle.
2. **Immediate Remediation in `DOIT` Mode**: The self-discovered bug transitions directly into `DOIT` mode to diagnose and resolve the failure, but remains bound by the Review Decision Non-Circumvention Invariant (`RULE-LCM-008`).
3. **Prohibition of Silent In-Place Hotfixing**: The AI agent `MUST NOT` silently patch defects in permanent tools without registering a formal BUG entry in the Configuration Management ledger.

### RULE-LCM-011: Scope and Version-Explicit Bug Report Naming Standard
1. **Canonical Bug Bundle Directory Convention**: All formal Bug Reports `MUST` follow the standardized bundle structure:
   `docs/Proposals/BUG-<nnn>-[Slug]/` containing `Specification.md`, `Implementation_Plan.md`, and `Walkthrough.md`.
   - `nnn`: Universal monotonic sequence integer zero-padded to at least 3 digits (e.g. `024`, `092`), sharing the exact same sequence counter as CRPs and matching the proposal ledger `id` 1:1.
2. **Mandatory Frontmatter Metadata**: Every Bug Report `MUST` include explicit frontmatter fields:
   - `Bug-ID`: Sequential unique identifier sharing the sequence counter with CRPs (e.g. `BUG-024`, `BUG-092`).
   - `Scope`: Affected repository or subsystem boundary.
   - `Version`: Target release baseline (e.g. `v7.1.0`).
   - `Affected-Repos`: Array of modified repositories.
   - `Severity`: Impact assessment (`Low`, `Medium`, `High`, `Critical`).
   - `Status`: Lifecycle status (`Open`, `In-Progress`, `Completed`).
   - `Root-Cause`: Concise explanation of failure mechanics.
3. **Legacy Flat File Fallback**: Historical Bug Reports (e.g. `BUG-024` through `BUG-094`) authored as flat `.md` files remain valid and governed under `RULE-LCM-020` Mode 3 (Legacy Fallback).

### RULE-LCM-012: Mandatory Scope-and-Version Explicit CRP Specification Generation Invariant
1. **Mandatory Standalone Specification**: Whenever proposing, designing, or implementing new features, tools, workflows, architectural enhancements, or governance policies, the AI agent `MUST` author a formal, standalone Scope-and-Version Explicit Change Request Proposal specification (`Specification.md`) within its proposal bundle in `LCM_Inventory/docs/Proposals/` before or alongside ledger registration.
2. **Prohibition of Orphan Feature Proposals**: Proposing or executing features or tool modifications without an authoritative, permanent proposal bundle in `LCM_Inventory/docs/Proposals/` is strictly prohibited. Every non-bug feature proposal in `proposals.json` `MUST` link to a valid `bundle_id` matching an existing CRP bundle.

### RULE-LCM-013: Mandatory Pre-Push Gemini AI & Knowledge Base Synchronization Invariant
1. **Mandatory Automated Pre-Push Execution**: Every `PUSH` operation executed via `Invoke-WorkspacePush.ps1`, whether multi-repository or targeting a single repository (`-Repositories <repo>`), `MUST` automatically execute the `Update-Gemini.ps1` pipeline prior to pushing commits to remote Git repositories. Direct manual `git push` invocations that bypass `Invoke-WorkspacePush.ps1` are prohibited.
2. **Context & Rules Mirroring Parity**: This guarantees that all 17 canonical LCM rules (`LCM_AI/docs/LCM_Rules_Gemini_Export.md`), plain-text `.txt` mirrors, tool catalogs, and full workspace knowledge base exports (`D:\GDrive\LCM`) are 100% synchronized with the pushed Git baseline at the moment of remote dispatch.
3. **Automated Export Commit**: If the `Update-Gemini` pipeline updates the consolidated rules export in `LCM_AI`, those changes `MUST` be staged and committed immediately before dispatching the push to `origin/main`.

### RULE-LCM-014: Dual-Gate Architecture & CRP Planning Gate Invariant
1. **CRP Birth in SUGGESTED State**: For any non-bug Change Request Proposal (`CRP`), the proposal `MUST` birth in the **`SUGGESTED`** state under the Normal Review Cycle.
2. **Gate 1 Planning Halt**: The AI agent `MUST` scaffold the Proposal Bundle directory, register the entry in `proposals.json`, present the plan, and `UNCONDITIONALLY HALT`. No source code, permanent script, configuration, or test file may be modified, created, or deleted while at Gate 1, unless explicitly instructed (`IMMEDIATELY`, `FORCE`) by the operator per `RULE-REV-001`.
3. **Gate 1 Activation Triggers**:
   - **`Proceed`**: Advances state from `SUGGESTED` $\rightarrow$ `IN_PROGRESS` in the Normal Review Cycle (interactive checkpoints if open questions or design alternatives exist).
   - **`do` / `do <ID>`**: Advances state to `IN_PROGRESS` and activates **`DOIT` Mode** (`always-proceed = $true`), executing planned modifications continuously until the Review Decision checkpoint is reached per `RULE-EFF-004`.
4. **Strict Dual-Gate Lifecycle**:
   - **Gate 1 (Planning Gate)**: Propose solution / Register proposal bundle & plan $\rightarrow$ `STOP` and await explicit operator direction (`Proceed` or `do`). (BUGs bypass Gate 1 into `DOIT` mode).
   - **Review Decision Checkpoint (BC5 Review / Gate 2)**: Implement approved changes $\rightarrow$ Present visual diffs / walkthrough / BC5 review $\rightarrow$ `STOP` and await operator review disposition. Mandatory for all proposals, subject strictly to the two authorized exceptions in `RULE-REV-001`.

### RULE-LCM-015: Strict Intake Classification Gate
1. **Intake Signal Classification**:
   - `CRP:` designator indicates a Change Request Proposal: enters `SUGGESTED` state and halts at Gate 1.
   - `BUG:` designator indicates a Defect Report: enters `DOIT` mode immediately and executes directly to the Review Decision checkpoint.
2. **Priority Ordering**: Numeric priority from $0$ through $10$ affects execution order in batch queues; equal-priority items may receive an advisory technical sequence. Priority never authorizes bypassing the Review Decision checkpoint.

### RULE-LCM-016: Deterministic Lifecycle Command Invariants
1. **`Proceed` / `Proceed <ID>`**:
   - Deterministic single-status pulse: advances the target proposal forward by exactly **one discrete state**.
   - Gate 1: `SUGGESTED` $\rightarrow$ `IN_PROGRESS`.
   - Review Decision: `REVIEW` $\rightarrow$ `COMMITTED` (satisfies review, records audit disposition, increments SemVer, and commits to local Git).
2. **`do <ID>` / `do <batch>`**:
   - Activates **`DOIT` Mode** (`always-proceed = $true`), running all planned tool operations continuously from Gate 1 to the Review Decision checkpoint.
3. **`COMPLETE` / `COMPLETE ALL`**:
   - Records review completion, creates a local commit, and transitions eligible proposals to `COMPLETED`.
   - Never invokes a remote push.
4. **`PUSH`**:
   - Pushes only `COMPLETED` proposal repositories in a preflighted cohort with `LCM_Inventory`.
   - A cohort member that is missing, lacks a remote, or is not ahead blocks all remote dispatch.
   - Enforces the Push Auto-Reset Invariant (`RULE-LCM-006`): resets `LCM Mode` and `Testing Mode` to `ON`.iew.

### RULE-LCM-017: Autonomous System Exception Boundary & 2-Attempt Loop Breaker
1. **Autonomous Exception Scope**: As a sole exception to `RULE-LCM-016`, the AI agent is permitted to assume an implicit `PROCEED` to immediately remediate a self-discovered or runtime-generated `BUG` `ONLY IF` all of the following conditions are simultaneously met:
   - **Critical System/Transport Behavior**: The defect represents a severe runtime blocker directly disrupting operations (e.g., REST daemon socket drops on Port 9876, IPC transport failures, or blocking background daemon aborts).
   - **Within Agent Capability**: The root cause is definitively identified and remediable within the agent's direct operational scope.
   - **No Architectural Redesign**: The fix requires no architectural redesign, schema changes, or breaking API alterations.
   - **Net Positive Impact**: The fix will not create cascading side-effects or regressions exceeding the problem being solved.
2. **Mandatory 2-Attempt Loop Breaker**:
   - If two (2) consecutive attempts to fix the runtime defect fail to resolve the issue, the autonomous `PROCEED` exception is **immediately and irrevocably revoked**.
   - The agent `MUST HALT` all modification attempts, mark the BUG item as `blocked`/`open` in the ledger, document the failure telemetry, and yield full control back to the operator.

### RULE-LCM-018: Credit Exhaustion & Batch Execution Granularity Guard
1. **Batch Size Safety**: Multi-item batches `MUST` be segmented into manageable, verifiable increments to prevent credit, context, and token exhaustion.
2. **Discrete Review Boundaries**: Each approved proposal or tight batch `MUST` reach a stable, verifiable state before proceeding to subsequent items, guaranteeing that uncommitted or partially modified code never leaves the workspace in an unrecoverable state.

### RULE-LCM-019: Active App Context Inheritance & Automated Tripartite Synthesis on COMPLETE
1. **Active Context Inheritance (`Workon:`)**:
   - When an active App context is set via `Workon: A<#>` (e.g. `Workon: A1`), all subsequent Change Request Proposals (`crp: ...`), Bug Reports (`bug: ...`), and tasks generated during this focus `MUST` automatically inherit the active `app_id` (e.g. `"App: 1"`) in `proposals.json`.
   - When set to `Workon: Architecture` or cleared (`Workon: Base`), proposals are recorded with `app_id: $null` (foundational system scope).
2. **Automated Tripartite Synthesis upon `COMPLETE`**:
   - The `COMPLETE <id>` command serves as the authoritative local lifecycle trigger that concludes an App increment.
   - Upon `COMPLETE`, the conclusive architecture decisions, technical requirements, and code manifests associated with the proposal `MUST` be synthesized into the repository's tripartite documentation under the designated `App: #` section:
     - Architectural summary $\rightarrow$ `Architecture.md` under `## App: #`
     - Normative invariants $\rightarrow$ `Requirements.md` under `## App: #`
     - Manifest table $\rightarrow$ `Implementation.md` under `## App: #`
3. **Multi-App Problem Resolution Gating**:
   - For multi-App bugs (`BUG-###`), the proposal `MUST` explicitly declare `primary_app` (root cause) and `affected_apps` (blast radius).
   - The bug cannot be marked `completed` or `committed` until the unit tests of the primary App *and* the integration tests of all affected Apps pass 100%.
   - On `COMPLETE`, documentation updates are synthesized across all affected App sections in a single atomic step.

### RULE-LCM-020: Proposal Bundle Directory Architecture, Dual Lifecycle & Git Object Document Retrieval
1. **Self-Contained Proposal Directory Bundles**:
   - Every proposal across the workspace (whether LCM core or child repository feature) `MUST` be stored in a dedicated proposal bundle directory:
     `docs/Proposals/CRP-<nnn>-[Slug]/` (or `BUG-<nnn>-[Slug]/`).
   - Each proposal bundle directory `MUST` contain three standardized Markdown documents:
     - `Specification.md` (Domain intent, problem statement, requirements, architectural tradeoffs, and metadata header)
     - `Implementation_Plan.md` (Technical file diff breakdown, component plans, and verification strategy)
     - `Walkthrough.md` (Execution receipts, test execution logs, before/after evidence, and operational verification)
2. **Pre-Push Working Tree Lifecycle**:
   - During proposal authoring, implementation planning, active coding, and review gating, the proposal bundle directory lives in the local repository working tree and is directly queryable by developers, CLI tools, and the CM Control Hub.
3. **Post-Push Working Tree Purge Invariant**:
   - Upon `Invoke-WorkspacePush.ps1` (or push workflow execution):
     - The target repository head commit SHA `MUST` be captured and recorded in `proposals.json` (`commit_sha: "<SHA>"`).
     - The remote GitHub tree link `MUST` be generated and recorded (`github_url: "<URL>"`).
     - The completed local proposal bundle directory `MUST` be purged from the working tree, ensuring 0 dead or redundant proposal directories remain in the working tree.
4. **Dual-Mode Document Retrieval Protocol (`Get-LcmProposalDocument`)**:
   - Tools, scripts, and dashboards `MUST` resolve proposal documents using the dual-mode resolution protocol:
     - **Mode 1 (Live Disk)**: If the bundle directory exists on disk (`Test-Path`), read content directly from the working tree.
     - **Mode 2 (Git Object Extraction)**: If the local directory has been purged, extract document content directly from the local repository Git object store using `git -C <RepoPath> show "<commit_sha>:<bundle_dir>/<file>"`.
     - **Mode 3 (Legacy Fallback)**: For pre-CRP-162 historic proposals, fall back to flat `plan_path` and `walkthrough_path` targets.

### RULE-LCM-021: Tool & Macro Synchronization Invariant
1. **Synchronous Macro Maintenance**: Whenever any tool, trampoline command (`.cmd`), alias, or CLI parameter interface is added, renamed, refactored, or deprecated across the workspace:
   - The authoritative macro reference in `macro-definitions.md` (`.agents/rules/macro-definitions.md`) `MUST` be updated synchronously within the same proposal or commit increment to reflect accurate tool names, current aliases, and available parameters.
   - Obsolete tool references (such as deprecated script paths or legacy trampolines) `MUST NOT` be retained as primary commands.
2. **Antigravity IDE Bare-Word Precedence**:
   - In Antigravity IDE environments, bare-word command invocations (`ToolExplorer`, `ShowTools`, `tools`, `ar`, `bcr`, `COMPLETE`, `PUSH`, `DO <#>`) `SHALL` be documented as the primary macro syntax to prevent collisions with the IDE's interactive context attachment menu triggered by `@`.
   - The `@` prefix remains recognized as a backward-compatible alias.

### RULE-LCM-022: Atomic Edit Consolidation & Editor Review Safety Invariant
1. **Single-Edit Atomic Consolidation**:
   - The AI agent `MUST` consolidate all modifications to any single target file into **one single comprehensive edit per user turn**.
   - The AI agent `MUST NOT` issue rapid back-to-back sequential edits to the same file across consecutive tool calls or turns without explicit user review and confirmation.
   - When updating multiple non-contiguous blocks of a file, the agent `MUST` use `multi_replace_file_content` in a single unified tool call rather than multiple separate calls.
2. **Editor Review Queue Non-Stacking Invariant**:
   - To prevent stacked diff review decorations and ambiguous chronological review banners in the IDE, the AI agent `MUST NOT` re-modify a file that has an unreviewed pending diff in the editor.
   - Prior to modifying any file that was touched in the preceding turn, the agent `MUST` verify that the user has accepted or dismissed the review.
3. **Buffer Clobber Prevention**:
   - The agent `MUST` ensure `"files.autoSave": "off"` is maintained in workspace settings (`.vscode/settings.json`), preventing the IDE from auto-saving stale in-memory editor buffers over freshly written disk files.

### RULE-LCM-023: Minimal Tests Single-Cycle Execution Switch & State Reflection Invariant
1. **Single-Cycle Ephemeral Scope**:
   - The `-MinimalTests` switch provides a single-cycle execution mode restricting the Test Readiness gate to fast hygiene checks (PowerShell AST parsing, Python compilation, UTF-8/CRLF validation, and English language checks).
   - Heavy test cascades (elevated integration suites, Session 0 harnesses, deep subsystem DAGs) are skipped during the single active proposal or declared batch execution.
   - Upon completion of the target item's readiness check, review submission, or turn conclusion, testing scope unconditionally auto-resets to standard full verification (`full`). Minimal testing `MUST NOT` persist as an ambient workspace state.
2. **Authoritative State Field Representation**:
   - When an item is verified and completed under `-MinimalTests`, its authoritative **`state`** (not status) attribute in `LCM_Inventory/data/proposals/proposals.json` `MUST` explicitly record `"state": "completed [minimal-tests]"`, with metadata attribute `"test_scope": "minimal"`.
   - The CM Control Hub and status displays render this state with distinct indicator chips (`COMPLETED ⚠️ MINIMAL`) to provide transparent operator visibility into verification depth.
3. **Audit Ledger & Review Evidence**:
   - Every activation of Minimal Tests `MUST` record an entry in `LCM_Inventory/logs/cm_activity.log` and capture `"test_scope": "minimal"` in the generated review receipt (`LCM_Inventory/data/reviews/review_*.json`).

---

### RULE-LCM-024: Mandatory Pre-Handoff Verification & Zero-Assumption Testing Invariant
1. **Pre-Handoff Verification Gate**: Before advancing any proposal to `Verified`, proposing Gate 2 visual review, or handing the turn back to the operator:
   - The AI agent `MUST` validate every created or modified script, module, or configuration file using its language's native AST parser or compiler (`[System.Management.Automation.Language.Parser]::ParseInput()` for PowerShell, `python -m py_compile` for Python, `ConvertFrom-Json` for JSON). Zero syntax errors or parse warnings are tolerated.
   - The AI agent `MUST` execute the relevant unit test suites (Pester, pytest, or readiness scripts).
2. **Zero-Assumption Testing Invariant**:
   - The AI agent `MUST NOT` skip tests or assert that code is valid, ready, or functional based on visual inspection alone.
   - Declaring or reporting completion, review readiness, or success without executing mechanical verification is strictly prohibited.

---

<a id="reviewcommitgovernancepolicymd"></a>
## Rule #7: ReviewCommitGovernancePolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/ReviewCommitGovernancePolicy.md`

# File: ReviewCommitGovernancePolicy.md

Module: ReviewCommitGovernancePolicy  
Purpose: Defines mandatory review-gated commit rules, review disposition handling, authorized bypass exceptions, audit logging, and single-session directory junction reviews.  
Path: .agents/rules/ReviewCommitGovernancePolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.6.0  
Status: Authoritative Policy  
Date: 2026-10-03  

---

## 1. Governance Rules

### RULE-REV-001: Mandatory Review-Gated Commits & Gate 2 Non-Circumvention Invariant
1. **Mandatory Visual Review Gate (Gate 2)**: Every Git commit action for source code, configuration, tools, modules, or structural assets (`*.ps1`, `*.psm1`, `.vscode/settings.json`, `LCM_Inventory/*`, `docs/*`) in any LCM-governed repository requires a prior validated review disposition (`COMPLETED` or `COMPLETED_WITH_EDITS`) produced via the formal Beyond Compare 5 visual review gate (`Invoke-BeyondCompareReview.ps1`), with transparent junction traversal via `FollowSymLinks` (`RULE-REV-008`).
2. **Strict Gate 2 Non-Circumvention Baseline**: Beyond Compare visual diff review is non-circumventable for code/tools/specs across all items by default. Even critical, urgent, or internally generated BUGs normally execute in `DOIT` mode (`always-proceed = $true`) without a Gate 1 planning pause, but halt at Gate 2 for operator review before reaching `COMMITTED`.
3. **Authorized Exceptions to Gating**:
   There are two (2) authorized exceptions to this rule:
   1. **Explicit Operator Directive (`IMMEDIATELY`, `FORCE`)**: The user can explicitly INSTRUCT (`IMMEDIATELY`, `FORCE`) to bypass review confirmation and advance directly into the Implementation Phase / review commit without confirming the visual review.
   2. **Critical Flow-Impeding BUG & Loop Breaker**: The system has detected a BUG that impedes the intended flow in a critical manner, especially when the task would lead to an unavoidable loop or recursion that the user cannot circumvent or fix. In this scenario, the system may proceed autonomously, engaging `-MinimalTests` to prevent cascading test recursions, but there `MUST BE NO MORE THAN TWO (2) ATTEMPTS` to resolve the issue before halting.
   - **Mandatory Audit Logging Invariant**: In either exception case, the fact, rationale, and specific trigger `MUST` be explicitly documented in the accompanying `BUG` or `CRP` proposal bundle and recorded in the Configuration Management ledger.
   - **Quality Gate, Syntax & Language Non-Bypass Invariant**: Taking an authorized exception to bypass manual visual review strictly waives only the interactive visual diff inspection step. It `MUST NEVER` bypass, waive, or relax syntax validation (PowerShell AST parser checks, Python compilation), language rules ([`LanguagePolicy.md`](file:///d:/Git_Repositories/.agents/rules/LanguagePolicy.md) English invariant), or baseline repository readiness quality gates (`Test-RepoReadiness.ps1`). All modified files `MUST` compile cleanly with zero syntax errors and satisfy all language and formatting invariants prior to commit.
4. **Exemption Scope**: Only purely mechanical telemetry artifacts defined in `RULE-EFF-001` (`inventory.json`, `INVENTORY_DASHBOARD.md`, `out/test_results.json`, and activity logs) are exempt from visual review gating.
5. **BCompare Materiality Authority**: Beyond Compare is the sole authority for whether a difference is material. The review launcher MUST enable its insignificant-difference controls, and post-review staging MUST record only explicit operator selections made in the visual session. Raw-byte, Git-diff, line-ending, or whitespace comparisons MUST NOT create review candidates or obstruct review disposition.
6. **Non-Interactive / Headless Environment Fallback**: If Beyond Compare 5 or Session 1 interactive GUI execution is physically unavailable (e.g. running inside a headless CI/CD runner, container, or non-GUI remote SSH terminal), the agent `SHALL` present unified console diffs alongside the proposal's `Walkthrough.md` verification evidence for explicit terminal disposition before committing.

### RULE-REV-002: Completed with Edits Qualification
When a review outcome is recorded as `Completed with Edits` (or `Completed with Change`):
1. The modified codebase `MUST` execute and satisfy all repository quality gates (`Test-RepoReadiness.ps1`).
2. The modifications `MUST NOT` introduce rule violations, regression errors, or broken dependencies.
3. Upon satisfying all quality gates, the state `SHALL` be classified as fully `COMPLETED` and committed to Git.
4. When `-MinimalTests` is engaged under operator instruction or automated loop circumvention, the readiness gate executes fast-tier syntax and structure validation while bypassing heavy integration cascades; the resulting commit is recorded as `completed [minimal-tests]` with `"test_scope": "minimal"` per `RULE-LCM-023`.

### RULE-REV-003: Override & Force Authority for Rejected/Deferred States
If a review outcome is `REJECTED` or `DEFERRED`:
1. Automated commit and push pipelines `MUST` halt immediately.
2. Committing or pushing changes in a rejected or deferred state `IS FORBIDDEN` unless explicitly commanded by the user with a forced override instruction (e.g., `-Force` parameter or unambiguous explicit override prompt).

### RULE-REV-004: Precedence Over General Permission Rules
The review-gating rules (`RULE-REV-001` through `RULE-REV-003`) take strict precedence over any general "all commands are permitted" or automated background execution policies in effect across the workspace.

### RULE-REV-005: Universal Audit & Change Request Traceability
Every review disposition (`Completed`, `CompletedWithEdits`, `Rejected`, `Deferred`) `MUST` be recorded with an immutable timestamp, reviewer identity, repository HEAD SHA, and notes into:
1. `LCM_Inventory/logs/cm_activity.log` (Append-only CM audit ledger).
2. `LCM_Inventory/data/reviews/REVIEW-<Repo>-<Timestamp>.json` (Structured review evidence).
3. The active Change Request (CR) record in `LCM_Inventory/data/change_requests.json` and mirrored proposal Markdown files when modifying governed baselines.

### RULE-REV-006: Mandatory Review Stop & Lifecycle Step Invariant
1. **Mandatory Review Stop**: Whenever an agent carries out a CRP or code modification reaching the visual review stage (Gate 2), the agent `MUST` launch `Invoke-BeyondCompareReview.ps1` and **immediately terminate the current response turn without making additional tool calls**.
2. **`Proceed` at Gate 2**: Upon operator submission of **`Proceed`** (or `Proceed <ID>`) after review inspection:
   - The proposal advances by exactly one status pulse: `REVIEW` $\rightarrow$ **`COMMITTED`**.
   - The local Git commit is created with the required SemVer increment per `RULE-REV-007`.
3. **`PUSH` (Publication Trigger)**:
   - `PUSH` is the only lifecycle command that may invoke a remote push.
   - It pushes only a fully preflighted cohort of `COMPLETED` proposals and `LCM_Inventory` in lockstep.
   - Uncommitted proposals remain strictly in their local state.
   - Enforces the Push Auto-Reset Invariant: both `LCM Mode` and `Testing Mode` unconditionally revert to `ON`.

### RULE-REV-007: Mandatory Automatic Semantic Version Increment per Change Invariant
1. **Universal Version Increment Invariant**: Every change, proposal, or bug fix committed to any LCM-governed repository `MUST` increment that repository's semantic version before or during review commit:
   - **Patch Increment (`+0.0.1`)**: Standard default for all bug fixes, refinements, single-purpose enhancements, and incremental proposal completions.
   - **Minor Increment (`+0.1.0`)**: For substantive new feature sets, new tools, new sub-frameworks, or major multi-component proposals.
   - **Major Increment (`+1.0.0`)**: For global platform architectural transitions, governed by `RULE-DOC-005`.
2. **Synchronized Artifact Updates**:
   - The incremented version `MUST` be updated in:
     - DOX metadata headers of modified scripts and modules (`Version: M.Y.Z`).
     - Tripartite specifications (`Architecture.md`, `Requirements.md`, `Implementation.md`).
     - Top-level `README.md` and repository manifests.
     - `LCM_Inventory/data/inventory.json` repository record.
   - Commit messages and review receipts `MUST` record the resulting semantic version (e.g. `feat(cm): ... [v7.1.1]`).
3. **LCM_Inventory Operational Data Exemption**:
   - Routine data accounting mutations within `LCM_Inventory` (specifically `data/inventory.json`, `data/proposals/proposals.json`, `logs/cm_activity.log`, `docs/INVENTORY_DASHBOARD.md`, and `data/reviews/*`) occurring as a standard byproduct of reviews, audits, proposal lifecycle transitions, or push recording `SHALL NOT` increment `LCM_Inventory`'s semantic version.
   - Semantic version increments for `LCM_Inventory` apply strictly when source code (`tools/*.ps1`, `modules/*.psm1`), specifications (`docs/*.md`), or governance policies are modified.

### RULE-REV-008: Transparent Single-Session Directory Junction Review (FollowSymLinks)
1. **Transparent Directory Junction Traversal**: Beyond Compare 5 review sessions `MUST` configure `<FollowSymLinks Value="True"/>` in `BCSessions.xml`, enabling Beyond Compare to traverse NTFS directory junctions (such as `.agents\rules`) inline within the primary review session.
2. **Unified Single-Window Invariant**: Dual-session Beyond Compare review dispatch is retired. All repository review comparisons execute in a single Beyond Compare window without opening a separate junction review instance.
3. **Composite Local Baseline Identity**: The left pane `MUST` be exported from the target repository's explicitly resolved local `BaseCommit`; it `MUST NOT` implicitly resolve, fetch, or substitute a remote reference. Where that commit exposes a junction-backed path, the scratch tree `MUST` replace the junction with a committed rules snapshot selected in this order: the target `BaseCommit`; the local committed junction-authority snapshot at or immediately before the target commit timestamp; the nearest target-history ancestor whose Git tree contains the junction path; then the local committed `HEAD` of the live junction authority. The selected source repository, relative path, SHA, and selection source `MUST` be recorded alongside the target SHA. A target-history snapshot that predates the target commit by a later authority snapshot `MUST NOT` be selected.
4. **Historical Junction Semantics**: The baseline `MUST` contain only files present in the selected committed rules snapshot. A file visible through the live junction but absent from every available committed snapshot `MUST` remain absent on the left and appear as a live-only addition on the right; the launcher `MUST NOT copy` mutable working-tree authority content into a historical baseline.
5. **Identity and Cache Clarity**: The baseline cache identity and pane title `MUST` display the target local SHA, selected rules source, and selected rules SHA. A launcher `MUST NOT` invent or fall back to an unrelated version label when a real version artifact is unavailable.
6. **Exclusion Filter Alignment**: Review exclusion filter lists `MUST NOT` filter out `-.agents\rules\`, ensuring all governance rule diffs remain directly inspectable in the primary review pane.

### RULE-REV-009: Review Discovery Disclosure and Durable Governance Closure
1. **Operator Visibility**: When an agent discovers that a review defect, tool repair, or validation result changes the durable review contract, it `MUST` tell the operator before claiming the implementation is complete. The disclosure `MUST` distinguish the implemented code change from the pending governance or documentation change.
2. **Same-Change-Set Policy Update**: Where the finding defines a recurring review behavior, the agent `MUST` update this policy in the same governed change set, including the exact invariant, evidence fields, and required tool behavior. A tool-only repair is incomplete until this policy update is present or the operator explicitly defers it.
3. **Synchronized Discovery Surface**: Any update under this rule `MUST` synchronize the root `AGENTS.md` rule index and `LCM_AI/docs/LCM-Rules-Cross-Reference.md` under `RULE-AUTH-002`.

---

### RULE-REV-010: Zero-Assumption Pre-Review Gate Verification Invariant
1. **Mandatory Mechanical Verification Before Review**: Before any proposal or change set is presented for Gate 2 visual review or commit gating, all modified or created files `MUST` have undergone mandatory mechanical syntax parsing (PowerShell AST parser, Python compile, JSON validation) and unit test execution (Pester).
2. **Prohibition of Unverified Readiness Claims**: An AI agent or developer `MUST NEVER` launch a Beyond Compare review session, claim review readiness, or solicit operator review disposition based on visual inspection alone without prior execution evidence recorded in `Walkthrough.md`.

### RULE-REV-011: ADMINMODE Rule-Change Authorization Invariant
1. **Authorization Source**: Rule changes require `ADMINMODE = true` for the current Windows user. Eligibility is membership in the Windows local Administrators group identified by SID `S-1-5-32-544`, independent of whether the current process is elevated.
2. **Hidden Operational State**: ADMINMODE state is not displayed by standard dashboards. It initializes on workspace open to `true` for an eligible user and `false` otherwise. `Make-Admin -Mode On|Off` may change it only for an eligible user.
3. **Non-Admin Denial**: A non-admin request to enable ADMINMODE leaves state unchanged and records an audit denial without interactive output.
4. **Commit Gate and Audit**: Before a CRP containing staged rule paths is committed, the review submission tool MUST enforce ADMINMODE and append the current user, SID, CRP identifier, and affected rule paths to the CM log. Administrator rights do not imply elevation, and elevation does not substitute for ADMINMODE.

---

<a id="methodefficiencypolicymd"></a>
## Rule #8: MethodEfficiencyPolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/MethodEfficiencyPolicy.md`

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

---

<a id="powershellstandardspolicymd"></a>
## Rule #9: PowerShellStandardsPolicy.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PowerShellStandardsPolicy.md`

# File: PowerShellStandardsPolicy.md

Module: PowerShellStandardsPolicy  
Purpose: Defines mandatory PowerShell 7 (pwsh) standards for strict mode resilience, verb compliance, string interpolation, intermediate code execution, and pipeline hygiene.  
Path: .agents/rules/PowerShellStandardsPolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.7.0  
Status: Authoritative Policy  
Date: 2026-10-03  

---

## 1. Governance Rules

### RULE-PS-001: Safe Collection & Array Handling under StrictMode
Under `Set-StrictMode -Version Latest`, PowerShell disables scalar property virtualization. Accessing `.Count` or `.Length` on a scalar result that does not natively define it throws a `PropertyNotFoundException`.
- **Mandatory Invariant**: All command outputs, function returns, or expressions that may yield `$null`, a single scalar item, or an array `MUST` be wrapped in the array subexpression operator `@(...)` before evaluating `.Count`, accessing indices, or iterating.
- **Correct**:
  ```powershell
  $items = @(Get-ChildItem -Path $targetPath -Filter *.md)
  if ($items.Count -gt 0) { ... }
  ```
- **Forbidden**:
  ```powershell
  $items = Get-ChildItem -Path $targetPath -Filter *.md
  if ($items.Count -gt 0) { ... }  # Throws PropertyNotFoundException if 1 item returned
  ```

---

### RULE-PS-002: Approved Microsoft Verb Compliance
All exported module cmdlets and public functions `MUST` strictly adhere to standard Microsoft approved verbs (`Get-Verb`).
- **Canonical Naming**: Use approved prefixes (`Get`, `Set`, `New`, `Update`, `ConvertFrom`, `Resolve`, `Invoke`, `Add`, `Remove`, `Test`, `Export`, `Format`).
- **Legacy & Domain Aliases**: If a legacy or colloquial name is desired (e.g., `Sync-CRJunctions`, `Parse-ProposalIdExpression`), the canonical implementation `MUST` use an approved verb (e.g., `Update-CRJunctions`, `Resolve-ProposalIdExpression`), and expose the legacy name via `Set-Alias -Name <Legacy> -Value <Canonical>` and `Export-ModuleMember -Alias`.

---

### RULE-PS-003: Colon-Safe String Interpolation & Boundary Delimitation
When interpolating a variable immediately followed by a colon (`:`) within any double-quoted string, error message, or inline `-Command` execution block, developers and AI agents `MUST` delimit the variable using `${var}:` or `$($var):`, or use explicit string concatenation (`'Prefix ' + $var + ':'`) or format operator (`"{0}:" -f $var`).
- **Rationale**: PowerShell treats `$var:` as an unclosed scope qualifier or drive specification (like `$env:`, `$script:`, `$global:`), causing a fatal `ParserError: Variable reference is not valid. ':' was not followed by a valid variable name character.`
- **Universal Scope Mandate**: This rule applies with zero exception to **all ad-hoc, intermediate, or one-liner inline commands** (e.g., `Write-Error "Error in $f:"` is strictly forbidden).
- **Correct**:
  ```powershell
  Write-Error "AST error in ${f}: $($errors | Out-String)"
  Write-Host ("Created Proposal #{0}: {1}" -f $newId, $Title)
  Write-Host "Created Proposal #$($newId): $Title"
  Write-Host ('AST error in ' + $f + ':')
  ```
- **Forbidden**:
  ```powershell
  Write-Error "AST error in $f: $errors"         # Throws ParserError ($f: treated as drive scope)
  Write-Host "Created Proposal #$newId: $Title"  # Throws ParserError
  ```
- **Mechanical Linter Pattern**: Any occurrence of `\$[a-zA-Z0-9_]+:(?!\/\/|[a-zA-Z])` within double-quoted strings or inline code is a quality gate violation.

---

### RULE-PS-004: Pester v5 Hyphenated Assertion Syntax
All test assertions in `*.Tests.ps1` files `MUST` utilize Pester v5 hyphenated assertion operators per repository quality gates (`Assert-PesterV5Syntax`).
- **Correct**: `Should -Be`, `Should -Not -BeNullOrEmpty`, `Should -BeGreaterThan`, `Should -Throw`.
- **Forbidden**: Legacy unhyphenated assertions (`Should Be`, `Should Not BeNullOrEmpty`).

---

### RULE-PS-005: StrictMode & ErrorAction Defaults
Every production script and module file `MUST` declare strict execution defaults at the beginning of the file:
```powershell
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
```

---

### RULE-PS-006: Pipeline Hygiene & Identifier Formatting
- **Assign `$_` First**: In complex `ForEach-Object` pipeline blocks, assign `$_` or `$PSItem` to an explicitly named local variable immediately before nested operations.
- **Function Pipeline Hygiene (Libraries & Atoms)**: In module functions, cmdlets, and library atoms that return values, unneeded command output `MUST` be suppressed using `| Out-Null`, `[void]`, or `$null = ...` to prevent corrupting caller return streams.
- **Interactive CLI & User Scripts Exemption**: User-facing execution scripts, CLI tools, diagnostics, and reports are **exempt** from pipeline suppression for intentional console output, status reporting, and table rendering (`Write-Host`, `Format-Table`, progress messages).
- **ASCII-Only Identifiers**: Variable, parameter, and function names must be strictly ASCII-only (umlauts and special characters permitted only in string literals and comments).

---

### RULE-PS-007: Test Suite Elevation Gating & Runtime Normalization
1. **Pre-Flight Elevation Check**: Test files asserting administrative or privileged capabilities `MUST` inspect `[Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole('Administrator')` during `BeforeAll`.
2. **Graceful Skip Invariant**: Tests that require Administrator privileges `MUST NOT` attempt live writes when running under an unprivileged user context. They `MUST` either:
   - Gracefully skip live execution (`-Skip:$(-not $isAdmin)`), OR
   - Restrict in-process validation strictly to AST parsing and declarative schema checks, delegating live execution to `Invoke-ElevatedTest.ps1`.
3. **Block Scoping**: `BeforeAll` and `AfterAll` blocks `MUST ALWAYS` reside strictly inside `Describe` or `Context` blocks to ensure compatibility across test runners.

---

### RULE-PS-008: Mandatory File Header Metadata & Date Invariant
All PowerShell scripts (`*.ps1`, `*.psm1`, `*.psd1`) `MUST` contain a standardized metadata header containing the canonical fields:
- `Module`: Canonical module or script identifier.
- `Purpose`: Brief 1-2 sentence description of functionality.
- `Path`: Canonical absolute or repository-relative path.
- `Authors`: Author names and/or AI engine attribution.
- `Version`: Semantic version or date-based version (`YYYY-MM-DD` or `MAJOR.MINOR.PATCH`).
- `Date`: Modification date (`YYYY-MM-DD`).

**Date Update Invariant**:
Whenever an existing script is modified, the `Date:` field (and changelog/version if applicable) `MUST` be updated to the current date. AI agents `MUST NOT` leave stale dates upon modifying script files.

**Canonical Header Format**:
```powershell
<#
.SYNOPSIS
    Brief summary.
.DESCRIPTION
    Module: <ScriptOrModuleName>
    Purpose: <Description>
    Path: <Path>
    Authors: <Author>
    Version: <Version>
    Date: <YYYY-MM-DD>
#>
```

---

### RULE-PS-009: Mandatory Structured Tool Logging & Summary Invariants
All PowerShell automation tools performing system mutations, diagnostics, remediations, repairs, or administrative tasks `MUST`:
1. **Persistent Audit Logging & Timestamp Precision**: Automatically write a timestamped log file (named `<ToolName>-yyyyMMdd_HHmmss.log`) to the repository-scoped `logs/` directory or `LCM_Inventory/data/logs/lcm/` (with fallback to `$env:TEMP/lcm/logs/` if repository logs are unavailable or unwritable) with at least second-level precision (`yyyy-MM-dd HH:mm:ss` or `yyyy-MM-dd HH:mm:ss.fff`). The minute-level format (`YYYYMMDD_HHMM`) is restricted strictly to assistant chat response headers and `MUST NOT` be used in tools or log entries.
2. **Structured Log Levels**: Classify every message using standard log levels: `[INFO]`, `[WARN]`, `[ERROR]`, `[DEBUG]`, `[ACTION]`, `[SUMMARY]` (converging on the `LCM_Shared/Logging` standard).
3. **Mandatory `[SUMMARY]` Footer**: Emit a standardized terminal and log summary block upon completion displaying:
   - Tool name
   - Version number
   - Execution status (`COMPLETED` / `FAILED`)
   - Exact log file path on disk
   - Execution timestamp (including at least seconds: `yyyy-MM-dd HH:mm:ss`)
4. **Detailed Inspection Support (`-ShowAll`)**: Tools must support `-ShowAll` / `-Detailed` to expose granular step-by-step diagnostic telemetry to the interactive terminal.

---

### RULE-PS-010: Mandatory `-h` / `-Help` CLI Parameter Support
All standalone PowerShell scripts, diagnostic tools, and CLI automation utilities `MUST`:
1. **Explicit Help Parameter**: Declare `[Alias('h', '?')][switch]$Help` in the `param(...)` block.
2. **Help Intercept & Exit**: When `-h`, `-Help`, or `-?` is passed, the tool `MUST` display a comprehensive, clean usage help screen (detailing synopsis, parameter reference table, and copy-paste examples) and exit cleanly without executing any mutation actions or throwing `ParameterBindingException`.

---

### RULE-PS-011: Interactive Desktop Dispatch Invariant (Session 1 Routing)
All PowerShell scripts, automation tools, and diagnostic reporters that launch interactive GUI applications, web browser dashboards, text editors (Notepad/Notepad++), File Explorer windows, or visible terminal consoles on behalf of the user `MUST`:
1. **Interactive Session Isolation Awareness**:
   Never assume script execution is running inside the interactive desktop. When executed from background agent sessions, IDE workers, or automated task runners (Session 0), raw `Start-Process` invocations are isolated and completely invisible on the user's physical screen.
2. **Mandatory Desktop Dispatch Routing**:
   Inspect whether `Invoke-InteractiveDesktop.ps1` exists in the workspace (`D:\Git_Repositories\LCM_Tools\Invoke-InteractiveDesktop.ps1` or `$toolsDir`). If present, GUI execution `MUST` be routed through `Invoke-InteractiveDesktop.ps1` using:
   ```powershell
   $dispatcher = Join-Path $toolsDir "Invoke-InteractiveDesktop.ps1"
   if (Test-Path $dispatcher) {
     & pwsh -File $dispatcher -FilePath "explorer.exe" -ArgumentList "`"$htmlPath`"" | Out-Null
   } else {
     Start-Process $htmlPath
   }
   ```
3. **Privileged GUI Elevation**:
   When launching tools requiring administrative elevation in the interactive session, pass `-Elevated` to `Invoke-InteractiveDesktop.ps1` rather than relying on in-process `Start-Process -Verb RunAs`.
4. **Applies Universally To**:
   - HTML Dashboards (`TOOLS_VIEWER.html`, `INVENTORY_VIEWER.html`, `CMD_FOLDER_ANALYSIS.html`)
   - File Explorers (`explorer.exe /select,"<Path>"`)
   - Text Editors (`notepad.exe`, `notepad++.exe`)
   - Interactive Consoles & Terminals (`wt.exe`, `pwsh.exe -NoExit`)

---

### RULE-PS-012: Prohibition of Bare Inline `(if ...)` in Command Invocations
PowerShell parses parentheses `(...)` as an expression group. In PowerShell syntax, `if`, `switch`, and `foreach` are **language statements**, not expressions.
- **The Failure**: Placing a bare `(if (...) { ... } else { ... })` inside a command argument causes the parser to treat `if` as a cmdlet/function name, throwing:
  `The term 'if' is not recognized as a name of a cmdlet, function, script file, or executable program.`
- **Mandatory Invariant**:
  1. **Primary Standard (Pre-assignment - Recommended)**: Pre-calculate the conditional value into an explicitly named local variable immediately before invoking the command.
     ```powershell
     $targetSubsystem = if ($Group -ne 'All') { $Group } else { 'LCM' }
     Build-LcmToolIndexHtml -Subsystem $targetSubsystem
     ```
  2. **Subexpression `$()` Standard**: If evaluated inline, developers `MUST` prefix with the subexpression operator `$(`:
     ```powershell
     Build-LcmToolIndexHtml -Subsystem $(if ($Group -ne 'All') { $Group } else { 'LCM' })
     ```
  3. **PowerShell 7+ Ternary Operator**: Use standard ternary syntax `($cond ? $trueVal : $falseVal)`:
     ```powershell
     Build-LcmToolIndexHtml -Subsystem ($Group -ne 'All' ? $Group : 'LCM')
     ```
- **Strictly Forbidden**:
  ```powershell
  Build-LcmToolIndexHtml -Subsystem (if ($Group -ne 'All') { $Group } else { 'LCM' })  # Fatal Parser Error
  ```

---

### RULE-PS-013: Module Import Parameter Compliance (`Import-Module -Name`)
Unlike filesystem cmdlets (`Get-Content`, `Test-Path`, `Set-Content`), `Import-Module` does `NOT` accept a `-LiteralPath` parameter.
- **Mandatory Invariant**: Always use `-Name` or positional path when importing `.psm1` or `.psd1` files:
  ```powershell
  Import-Module -Name $modulePath -Force
  ```
- **Forbidden**:
  ```powershell
  Import-Module -LiteralPath $modulePath -Force  # ParameterBindingException
  ```

---

### RULE-PS-014: High-Performance NTFS Permission & Smart Inheritance Standard
Brute-force file-by-file recursion (`icacls /T`, `takeown /R`) across entire storage volumes causes millions of redundant disk writes and extreme execution latency (15-45 minutes).
- **Mandatory Invariant**:
  1. Scripts managing NTFS security descriptors `MUST` establish container and object inheritance (`(OI)(CI)(F)`) on parent/root nodes and re-enable clean inheritance (`/inheritance:e`) to allow child objects to inherit permissions dynamically in 0ms.
  2. Explicit `icacls` or `takeown` executions `MUST` be targeted specifically to directory nodes where inheritance is severed or blocked (`Acl.AreAccessRulesProtected == $true`), explicit `DENY` rules are present, or directory junctions require `/L` link-level authorization.
  3. Blind whole-volume recursive rewriting across millions of healthy inheriting files is strictly prohibited.

---

### RULE-PS-015: Variable String Interpolation and Colon Boundaries
The bare syntax `"$var:"` inside double-quoted strings is **strictly prohibited** to avoid PowerShell scope-provider collisions (`ParserError`). PowerShell parses `$identifier:` as an unclosed scope qualifier (`$global:`, `$script:`, `$env:`, drive provider `C:`), causing a fatal parse error at script load time.

- **Mandatory Invariants**:
  1. **Brace Delimitation**: Whenever an interpolated variable is immediately followed by a colon or any non-identifier character that would ambiguate the variable boundary, enclose the variable name in curly braces:
     ```powershell
     Write-Host "Verified Baseline Resolution: [${commitSha}: $commitMsg]"
     Write-Host "Drive root: ${driveLetter}:\\"
     ```
  2. **Format String Alternative**: Use PowerShell format strings as a fully safe alternative for structured output:
     ```powershell
     Write-Host ("Verified Baseline Resolution: [{0}: {1}]" -f $commitSha, $commitMsg)
     ```
  3. **Sub-Expression for Object Properties**: Object property access and nested expressions inside double-quoted strings `MUST` always use sub-expression syntax:
     ```powershell
     Write-Host "Status: $($result.Status) at $($result.Timestamp)"
     ```

- **Strictly Forbidden**:
  ```powershell
  Write-Host "Baseline: [$commitSha: $commitMsg]"   # ParserError — $commitSha: treated as scope qualifier
  Write-Host "Drive: $driveLetter:\\"               # ParserError — $driveLetter: treated as drive provider
  Write-Host "Value: $obj.Property"                 # Silent failure — expands $obj then appends literal '.Property'
  ```

---

### RULE-PS-016: Single-Quoted Here-String Invariant for Inline & Intermediate Code
When an AI agent or automated script invokes PowerShell commands via `pwsh -Command` (intermediate code execution in chat or orchestration), multi-line script blocks, path-bearing commands, and nested string interpolations `MUST` be enclosed in **single-quoted here-strings** (`@' ... '@`).
- **Rationale**: Double-quoted command strings unescape outer quotes and mangle backslashes (`\`) prematurely during CLI argument parsing, triggering fatal `ParserError` or `ParameterBindingException` (`A positional parameter cannot be found that accepts argument...`).
- **Mandatory Invariant**:
  ```powershell
  pwsh -NoProfile -Command @'
    $target = 'D:\Git_Repositories'
    Write-Host "Target: $target"
  '@
  ```
- **Forbidden**: Passing multi-line or path-heavy scripts via double-quoted strings (`pwsh -Command "..."`).

---

### RULE-PS-017: Lock-Free Concurrency & FileShare Invariant
When inspecting, reading, or hashing files in active, synchronized, or cloud-mirrored directories (such as `D:\GDrive\`, `.gemini\`, or live daemon roots), file handles `MUST NOT` be opened with exclusive locks (`FileShare.None`).
- **Mandatory Read Pattern**: Employ explicit `[System.IO.FileStream]` with `[System.IO.FileShare]::ReadWrite` or non-exclusive readers:
  ```powershell
  $fs = [System.IO.FileStream]::new($file, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
  try {
      $hashBytes = $sha256.ComputeHash($fs)
  } finally {
      $fs.Dispose()
  }
  ```
- **Mandatory Write Pattern**: Writes to shared or synced paths `MUST` use atomic temporary file staging (`.tmp` $\rightarrow$ `[System.IO.File]::Move($tmp, $dest, $true)`) wrapped in an exponential backoff retry loop (minimum 3 attempts).

---

### RULE-PS-018: Reparse Point & Link Shell Extension (LSE) Safe Deletion Invariant
NTFS directory junctions and symbolic links represent discrete filesystem reparse pointers.
- **Mandatory Invariant**: Deleting a junction or link `MUST NEVER` invoke naive recursive deletion (`Remove-Item -Recurse -Force`) without reparse verification, as some PowerShell engines traverse into the junction and delete physical target files.
- **Safe Deletion**:
  1. Inspect the reparse attribute: `$item.Attributes -band [System.IO.FileAttributes]::ReparsePoint`.
  2. Call `.Delete()` directly on the filesystem item: `(Get-Item -LiteralPath $path -Force).Delete()`.
  3. Or delegate to Windows shell / Link Shell Extension (LSE) tools or `cmd /c rmdir $path`.

---

### RULE-PS-019: Universal Scope Invariant (Script & Intermediate Code Parity)
The PowerShell standards codified in this policy (`RULE-PS-001` through `RULE-PS-018`) apply with **equal force to both permanent repository scripts (`*.ps1`, `*.psm1`) and ad-hoc intermediate command blocks (`pwsh -Command`)**.
- The AI agent `MUST NOT` relax coding hygiene, error handling, strict typing, or parameter safety when generating inline or temporary execution blocks.
- **Runtime Host Mandate**: The workspace engine is **PowerShell 7 (`pwsh`) exclusively**. Invoking legacy `powershell.exe` (Windows PowerShell 5.1) is strictly prohibited. Modern PS7 features (`||`, `&&`, ternary `? :`, null-coalescing `??`) are fully authorized and preferred.

---

### RULE-PS-020: Class Dependency Runspace Pre-loading for AST Validation
When performing static AST validation on PowerShell scripts that utilize custom classes as type annotations, all prerequisite class definition files must be dot-sourced into the runspace before invoking `[System.Management.Automation.Language.Parser]::ParseFile()`.
- **Rationale**: PowerShell's AST parser cannot resolve custom type tokens unless the type is already loaded in the active runspace, throwing false-positive syntax errors.

---

### RULE-PS-021: Mandatory Pre-Handoff AST Syntax Gate & Zero-Assumption Testing Invariant
Whenever a permanent repository script (`*.ps1`, `*.psm1`, `*.psd1`) or test file is created or modified by an AI agent or developer:
1. **Mandatory Pre-Handoff AST Parse Gate**: The agent `MUST` validate the script using PowerShell's native AST parser `[System.Management.Automation.Language.Parser]::ParseInput()` before declaring a task complete, proposing completion, or handing control back to the operator. Zero syntax errors or parse warnings are tolerated.
2. **Zero-Assumption Testing Invariant**: The agent `MUST NOT` assume or assert that code is valid, ready, or functional without executing either its unit tests (Pester) or an explicit syntax parse first. Relying on visual inspection alone or declaring ready without executing test verification is strictly prohibited.

---

<a id="powershellrulesmd"></a>
## Rule #10: PowerShellRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PowerShellRules.md`

# File: PowerShellRules.md

Module: PowerShellRules
Purpose: Authoritative rules for PowerShell script generation and normalization.
Path: .agents/rules/PowerShellRules.md
Authors: Rolf
Version: 8.8.0
Changelog:
- 2026-10-03: Added mandatory-ast-syntax-gate and zero-assumption-testing invariants to enforce pre-handoff AST validation and prohibit unvalidated completion claims.
- 2026-09-27: Added inline-single-quotes invariant and colon-safe-interpolation rule to eliminate host shell pre-expansion and parsing errors.
- 2026-09-26: Standardized on PS7 (pwsh) runtime exclusively; parity for intermediate code.
- 2026-07-27: Split unified rule file; clarified ASCII constraints; stabilized PS rules.

POWERSHELL-RULES
- ps7-exclusive: pwsh (PS7) is mandatory workspace-wide; legacy powershell.exe (5.1) is forbidden
- intermediate-parity: rules apply equally to permanent scripts and inline pwsh -Command blocks
- inline-single-quotes: inline pwsh -Command blocks MUST use single-quoted script blocks '& { ... }' or here-strings to prevent outer shell variable pre-expansion ($var)
- colon-safe-interpolation: variables followed by colons MUST use explicit braces (${var}:)
- mandatory-ast-syntax-gate: every created or modified *.ps1, *.psm1, *.psd1 MUST undergo explicit AST parser validation ([System.Management.Automation.Language.Parser]::ParseInput) before handoff
- zero-assumption-testing: no tool, script, or proposal may be claimed ready without running either its unit tests or an explicit syntax parse first
- ascii-default: ASCII required; umlauts allowed in literal strings and comments
- utf8-without-bom: scripts must be UTF-8 without BOM
- newline-crlf: scripts must end with CRLF
- no-backticks: forbidden
- no-interpolated-calls: forbid method calls inside interpolated strings
- assign-$_-first: always assign $_ to a variable before use
- no-non-ascii-identifiers: identifiers must be ASCII-only
- no-hidden-state: forbid hidden pipeline or implicit variable usage
- deterministic-output: identical input → identical output

POWERSHELL-METADATA
- scope: durable-memory
- location: .agents/rules/PowerShellRules.md

---

<a id="pythonrulesmd"></a>
## Rule #11: PythonRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PythonRules.md`

# File: PythonRules.md

Module: PythonRules  
Purpose: Authoritative rule definitions for Python code quality, import ordering, string formatting, and linter compliance.  
Path: .agents/rules/PythonRules.md  
Authors: Rolf, LCM_AI Engine  
Version: 8.1.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Core Python Rules

### PYTHON-RULES
- **no-redundant-fstrings** (`RULE-PY-001` / `F541`): Never use `f"..."` or `f'...'` prefix on strings that contain no variable interpolation or `{...}` placeholder expressions. Use standard string literals `"..."` or `'...'`.
- **explicit-import-order** (`RULE-PY-002`): Ensure all module imports (e.g. `import sys`, `import os`) occur before executing any methods or properties on them (e.g. `sys.stdout.reconfigure()`).
- **clean-unused-imports** (`RULE-PY-003` / `F401`): Never leave unused imported modules or functions in Python source files.
- **clean-unused-variables** (`RULE-PY-004` / `F841`): Avoid assigning local variables that are never read, referenced, or returned.
- **utf8-stdout-reconfigure** (`RULE-PY-005`): In standalone CLI tools and automation scripts targeting Windows environments, always configure `sys.stdout.reconfigure(encoding='utf-8')` immediately following the `import sys` block to prevent Unicode encoding faults.
- **exception-handling-cleanliness** (`RULE-PY-006`): Do not name unused exception variables in catch blocks (use `except Exception:` instead of `except Exception as e:` if `e` is not referenced in the block).
- **cross-repo-path-resolution** (`RULE-PY-007`): Scripts referencing shared modules or sibling repositories must resolve paths deterministically or configure `sys.path` dynamically relative to `__file__`.
- **template-interpolation-safety** (`RULE-PY-008`): When generating or emitting secondary languages (HTML, JavaScript, CSS, JSON, SQL, or shell scripts) from Python:
  1. **Escape & Collision Invariant**: Never mix raw f-strings (`f"""..."""`) with JavaScript or CSS code blocks containing `{...}` or `${...}` without complete double-brace escaping (`{{...}}` and `${{...}}`).
  2. **Safe Serialization**: When injecting Python data into JavaScript or HTML context, always serialize via `json.dumps()` (e.g., `const DATA = {json.dumps(obj)};`) rather than ad-hoc string formatting.
  3. **No Embedded Backtick Ambiguity**: When constructing dynamic paths or strings in generated JavaScript, use standard JavaScript string concatenation (`tabName + '_suffix.html'`) rather than backtick template literals (` `${tabName}_...` `) to avoid escape-stripping defects across string generation pipelines.
  4. **Ahead-of-Occurrence Verification**: Python scripts that generate web artifacts (HTML, JS, JSON) must perform pre-emission syntax validation (e.g. `json.loads()` on JSON payloads, or verifying no unexpanded Python expressions `{...}` remain in the emitted text).

---

## 2. Linter & Quality Verification
- All Python source files must pass `flake8` checks with zero `E9,F63,F7,F82,F401,F541,F841` violations.
- All Python files must compile cleanly with `py_compile.compile()` during repository readiness checks (`Test-RepoReadiness.ps1`).

---

<a id="cmdrulesmd"></a>
## Rule #12: CMDRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/CMDRules.md`

# File: CMDRules.md

Module: CMDRules  
Purpose: Authoritative rules for CMD batch generation, echo control, error levels, and normalization.  
Path: .agents/rules/CMDRules.md  
Authors: Rolf  
Version: 8.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Core CMD & Batch Rules

### CMD-RULES
- **echo-control**: Always begin batch scripts with `@echo off`.
- **errorlevel-handling**: Always verify command outcomes using `if errorlevel 1` or `%ERRORLEVEL%` checks.
- **ascii-default**: CMD batch scripts must strictly use ASCII-only character sets.
- **newline-crlf**: All `*.cmd` and `*.bat` files must end with CRLF line endings.
- **deterministic-output**: Identical input $\rightarrow$ identical output.
- **indent-2**: 2-space indentation for logical blocks and parenthesized expressions.

---

<a id="jsonrulesmd"></a>
## Rule #13: JsonRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/JsonRules.md`

# File: JsonRules.md

Module: JsonRules  
Purpose: Authoritative rules for JSON normalization, schema referencing, encoding, and indentation.  
Path: .agents/rules/JsonRules.md  
Authors: Rolf  
Version: 8.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

---

## 1. Core JSON Invariants

### JSON-RULES
- **utf8-without-bom**: All JSON files must be encoded as UTF-8 without BOM.
- **indent-2**: JSON files must use clean 2-space indentation (e.g. `ConvertTo-Json -Depth 5`).
- **newline-crlf**: All JSON files must end with CRLF line endings.
- **schema-declaration**: JSON data files should include a `$schema` property referencing a valid draft schema when applicable.
- **ascii-default**: ASCII recommended for keys and identifiers; UTF-8 strings permitted for localized values.
- **deterministic-output**: Predictable, key-ordered serialization (`[ordered]@{ ... }`).

---

<a id="documentationstandardspolicymd"></a>
## Rule #14: DocumentationStandardsPolicy.md
> **Category**: 4. Documentation & Subsystem Architecture | **Canonical Source**: `.agents/rules/DocumentationStandardsPolicy.md`

# File: DocumentationStandardsPolicy.md

Module: DocumentationStandardsPolicy  
Purpose: Defines mandatory tripartite repository documentation standards, audience scoping, and DOX metadata invariants across all governed repositories.  
Path: .agents/rules/DocumentationStandardsPolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.6.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Governance Rules

### RULE-DOC-001: Mandatory Tripartite Repository Specifications
Every LCM-governed repository `MUST` maintain three distinct core specifications in `<Repo>/docs/`:
1. **`Architecture.md` (End-User & Concept Perspective)**:
   - Describes the system "View" from an end-user / operator perspective.
   - User mental model, visual topology diagrams (Mermaid), CLI/API usage entrypoints, and external boundaries.
2. **`Requirements.md` (Technical Aspects of Design)**:
   - Describes normative technical constraints, prerequisites, and safety boundaries.
   - Environmental prerequisites (PowerShell 7, OS, Elevation Level), normative invariants (`MUST`/`MUST NOT`), error handling & security constraints.
3. **`Implementation.md` (Code Representation)**:
   - Describes how Architecture and Requirements are concretely realized in code and files.
   - Module & script inventory (`*.psm1`, `*.ps1`), exported cmdlets, parameter signatures, data models (`$schema`), and Pester test traceability.

---

### RULE-DOC-002: Distinct Audience Scoping & Separation of Concerns
- **No Conceptual Bleed**: Code-level file paths, function signatures, and internal parameters belong strictly in `Implementation.md`, not `Architecture.md`.
- **Requirements vs Implementation**: `Requirements.md` specifies *what* rules and constraints must be satisfied; `Implementation.md` catalogs *how* code and test files satisfy them.
- **Top-Level `README.md`**: Top-level `README.md` must serve as an executive summary and navigation index pointing directly to the three core tripartite specifications.

---

### RULE-DOC-003: DOX Metadata Header & Rule Frontmatter Invariant
1. **General Markdown Documents (`docs/`)**: Every general Markdown document `MUST` begin with a standardized DOX metadata header:
   ```markdown
   # <Document Title>

   Module: <Relative Path>  
   Purpose: <1-2 Sentence Summary of Purpose>  
   Path: <Canonical Path>  
   Authors: <Author Name / Engine>  
   Version: <MAJOR.MINOR.PATCH>  
   Status: <Authoritative Standard | Reference | Policy>  
   Date: <YYYY-MM-DD>  
   ```
2. **Governance Rule Documents (`.agents/rules/`)**: Governance rule files `MUST` utilize a hybrid structure to ensure compatibility with modern AI agent rule discovery engines and IDEs:
   - **Lines 1–5**: Mandatory YAML Frontmatter declaring rule metadata:
     ```yaml
     ---
     name: <RulePolicyName>
     description: <Concise description of governed domains and invariants>
     globs: "<Applicable file patterns or *>"
     ---
     ```
   - **Immediately below frontmatter**: The standardized DOX metadata header block per Section 1.

---

### RULE-DOC-004: Mandatory Universal `install/` Directory and `Installation.md` Runbook Standard
Every LCM-governed repository that deploys or installs operational payloads `MUST` maintain an `install/` directory at the repository root containing an authoritative lifecycle runbook:
1. **Primary Runbook (`install/Installation.md`)**:
   - Step-by-step procedural runbook conforming to the 7-phase procedural lifecycle:
     1. **Prerequisites & Environmental Dependencies**: OS requirements, PowerShell edition, elevation privilege, hardware interlocks, and external dependencies.
     2. **Target Destination Layout & Customization**: Target folder structure (e.g., `D:\Tools\<Component>`), separating top-level user entrypoints/wrappers from internal helper subfolders (`tools/`, `bin/`).
     3. **Preflight System Health Checks**: Verification of prerequisite drivers, running services, and path accessibility before staging.
     4. **Step-by-Step Deployment & Configuration**: Payload staging, file copying, permission hardening, environment variable and `$env:PATH` registration.
     5. **Post-Deployment Verification & Health Checks**: Verification commands, smoke tests, and contract confirmation.
     6. **Ongoing Servicing & Update Runbook**: Step-by-step update process for new versions and hotfixes.
     7. **Rollback & Uninstallation Procedures**: Clean reversal, process termination, service deregistration, and file removal.
2. **Sub-Phase Structure for Complex Installations**:
   - For complex multi-phase deployments, steps may be cleanly separated into numbered sub-documents in `install/` (e.g., `01-Prerequisites.md`, `02-Configuration.md`, `03-Deployment.md`), centrally indexed and orchestrated by `Installation.md`.
   - `install/` contains purely procedural runbooks and deployment scripts; it `MUST NOT` contain a `README.md`.
3. **Decoupled Cross-Repository Boundaries**:
   - External dependencies (such as `LCM_Shared` or `LCM_Inventory`) `MUST` be represented strictly as prerequisite assertions and linkage steps without duplicating foreign repository code or internals.

---

### RULE-DOC-005: LCM Major Version Alignment Invariant (`M.Y.Z`)
Whenever a new major LCM version $M$ (e.g. `v6.0.0`, `v7.0.0`) is established and pushed:
1. **Major Parity**: All contained modules, specification documents, scripts, and configuration manifests `MUST` have their version updated such that their **Major** version component matches $M$.
2. **Subversion Preservation**: Subversions (**Minor** $Y$ and **Patch** $Z$) `MUST NOT` be reset or wiped by pre-push major version actions; their relative evolution history and component-level differentiation are strictly preserved.
3. **Transformation Formula**: If a module or spec has version $X.Y.Z$ and the new LCM major version is $M$, the new version becomes:
   $$\text{NewVersion} = M.Y.Z$$
   *(Example: A module at version `2.3.1` when major version 7 is established becomes `7.3.1`).*
4. **Baseline Synchronization**: All explicit global baseline references in configuration files (`LCM_Inventory/config.json`, `.vscode/settings.json`, `.github/agents/Config.json`), agent profiles, and DOX headers `MUST` reference the current active LCM baseline.

---

### RULE-DOC-006: Major Release Retention Horizon Policy & Evolution History Taxonomy
At the time of a major release push $M$ (e.g. `v6.0.0`, `v7.0.0`):
1. **2-Major-Release Retention Horizon ($M - 2$)**:
   - All transient operational logs (`tools/logs/*.log`, `LCM_Inventory/logs/*.log`), temporary scratch dumps (`scratch/`), and legacy deletion trees (`Deletions/`) from major releases older than 2 major versions ($\le M - 2$) `MUST` be completely flushed.
   - For major release $M=6$, all artifacts and deletion trees from major releases $\le 4$ are purged.
   - Transient logs within the active operational window ($M$ and $M-1$) are retained.
2. **Permanent Historical Evolution Logs Exemption**:
   - Logs documenting macro-architectural evolution milestones, lineage transitions, and continuous governance history `MUST NOT` be pruned.
3. **Standardized Evolution History Taxonomy**:
   - **Directory Naming**: `{Sequence:02d}_{Theme_or_Era}-Evolution/` (e.g., `01_Pre-AI-Evolution/`, `02_Method-and-Tooling-Evolution/`, `03_Propagation-and-Continuous-History/`).
   - **File Naming**: `{Sequence:02d}_{Subject}_{MilestoneType}.md` (where `MilestoneType` $\in$ `{Lineage, Governance, Milestones, Architecture, Ledger, Rollup}`).
   - **DOX Metadata Invariant**: All permanent evolution log documents `MUST` declare `Classification: permanent-evolution-history` and `Status: Authoritative Historical Ledger`.
   - **Automated Protection**: All directories matching `*-Evolution/` or files with `Classification: permanent-evolution-history` are unconditionally protected from deletion by cleanup engines and daemons.

---

### RULE-DOC-007: App-Centric Modular Tripartite Architecture & Constituent Manifest Standard
For governed repositories that scale beyond single-purpose scripts into multi-capability systems:
1. **Optional Modular Slicing (`App: #`)**:
   - Tripartite specifications (`Architecture.md`, `Requirements.md`, `Implementation.md`) `MAY` be partitioned into numbered `App: # - <Title>` sections (e.g. `App: 1 - CM Interactive Control Hub`).
   - Repositories not requiring modular slicing remain standard un-prefixed tripartite documents.
2. **Tripartite Slicing Consistency Invariant**:
   - When `App: N` is declared in `Architecture.md`, corresponding `## App: N` sections `MUST` exist in `Requirements.md` (normative constraints) and `Implementation.md` (code blueprint).
3. **Directory Separation Layout (`docs/App#<N>-<Slug>/`)**:
   - When directory separation is utilized (`-SplitDocs` or `Split-LcmAppDocs`), each App's tripartite specifications `MUST` be housed in a dedicated subdirectory located **directly under `docs/`**:
     `docs/App#<N>-<Slug>/` (e.g. `docs/App#1-SystemIdentityStateCaptureEngine/`).
   - Intermediate wrapper directories (such as `docs/apps/`) are strictly prohibited.
   - Each `docs/App#<N>-<Slug>/` folder `MUST` contain its dedicated `Architecture.md`, `Requirements.md`, and `Implementation.md`.
   - The root `Architecture.md` `MUST` maintain an authoritative **App Subsystems & Sliced Specifications Index Table** linking directly to each `docs/App#<N>-<Slug>/` tripartite document.
4. **Constituent Manifest Table Standard (`Implementation.md`)**:
   - Under each `## App: N` section (or inside each dedicated `docs/App#<N>-<Slug>/Implementation.md`), an authoritative **Constituent Manifest Table** `MUST` be maintained:
     `| Relative Path | Role / Layer | Primary Cmdlets / Entrypoints | Pester Test Suite |`
5. **Code DOX Header Annotation**:
   - Every script, module, or UI asset belonging to an App `MUST` declare `App: App: N - <Title>` in its standard DOX metadata header.
6. **Machine-Readable Registry (`data/catalog/apps.json`)**:
   - Repositories utilizing App slicing `MUST` maintain a zero-drift machine-readable catalog at `data/catalog/apps.json`, synchronized via AST scanning.
7. **Inter-App Contract Governance (The "Glue")**:
   - Apps `MUST NOT` communicate via private internal functions or implicit global variables. All cross-App interactions `MUST` be governed by declared, registered Public Interface Contracts (Cmdlet Exports, JSON Schemas, REST DTOs, Event Broadcasts) cataloged in `data/catalog/contracts.json`.
8. **Submodules as an App form**: a git submodule is a normal form of the App method for subdividing a large set of functionality of a repository. Consolidating several repositories into one repository with an App per former repository is permitted, but `MUST` only be done by explicit operator decision.

### RULE-DOC-008: Specification Preservation Invariant
1. No specification or architecture document (`Architecture.md`, `Requirements.md`, `Implementation.md`, `docs/Architecture/*`) `MAY` be replaced, condensed or have sections removed without the explicit approval of the operator.
2. Content that is outdated is updated in place (names, paths, status), and a status line marks what no longer matches the live state. It is not deleted.
3. A change that removes or shortens more than a few lines of a specification `MUST` be proposed first, naming the sections affected, and `MUST` be listed in the commit message.
4. Superseding a document with a new one `MUST` keep the old content reachable (restored in place, or moved to a named retired location) in the same commit.

---

<a id="subsystemgovernancepolicymd"></a>
## Rule #15: SubsystemGovernancePolicy.md
> **Category**: 4. Documentation & Subsystem Architecture | **Canonical Source**: `.agents/rules/SubsystemGovernancePolicy.md`

# File: SubsystemGovernancePolicy.md

Module: SubsystemGovernancePolicy  
Purpose: Governs disjunct Subsystem repositories (e.g. Home Assistant OS), dedicated subsystem inventories, JIT ephemeral write authentication, host hardware interlocks, and log segregation.  
Path: .agents/rules/SubsystemGovernancePolicy.md  
Authors: Rolf, LCM_AI Governance  
Version: 8.0.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Scope & Motivation

A **Subsystem** represents an autonomous runtime or supervisory domain (e.g., `HaSSD06` running Home Assistant OS, or `LCM_Supervision` operating continuous task telemetry and status observation) that has specialized operational lifecycles distinct from general scripting utilities. 

While Subsystems inherit standard LCM **documentation and quality gate rules**, their internal parts (integrations, devices, tasks, telemetry ledgers, entities) require domain-specific configuration management and elevated safety protocols.

---

## 2. Invariant Rules

### RULE-SUB-001: Subsystem Classification & Documentation Conformance
1. A repository classified as `subsystem` in `LCM_Inventory/config.json` `MUST` fully implement standard LCM **Tripartite Documentation** (`docs/Architecture.md`, `docs/Requirements.md`, `docs/Implementation.md`) and the universal runbook (`install/Installation.md`).
2. The root `LCM_Inventory` tracks Subsystems at the macro Git level, while delegating internal part tracking to the Subsystem's dedicated inventory engine.

### RULE-SUB-002: Dedicated Subsystem Inventory Engine & Auto-Acceptance Invariant
1. Subsystems `MUST` maintain an independent internal inventory ledger at `data/subsystem_inventory.json` and a rendered summary at `docs/SUBSYSTEM_DASHBOARD.md`.
2. Dedicated audit tools (`tools/Update-<Subsystem>Inventory.ps1`) `SHALL` query domain-specific APIs or MCP services to reconcile active components without polluting the root host inventory.
3. **Direct Carry-Over from LCM (`RULE-EFF-001`)**: Routine Subsystem telemetry collection, entity dumps, and dashboard rendering constitute mechanical evidence and are **automatically accepted**. Telemetry synchronization runs `SHALL NOT` force manual review gates or block workflows on interactive diff sessions.

### RULE-SUB-003: Host-Side Hardware Safety Interlocks (Offline / Pre-Boot)
1. Any host script performing physical disk operations (flashing images, disk cloning, partition restructuring) `MUST NEVER` target arbitrary disk indices (e.g., `Disk 2`) without validating explicit **Hardware Serial Numbers** and **Model Descriptors** declared in `LCM_Inventory/config.json`.
2. Host tools `MUST` execute `Assert-DiskTargetSafety` to guarantee that active Windows `Boot`, `System`, or `PageFile` volumes are **never** targeted.
3. Destructive disk operations require high-integrity Administrator elevation and explicit operator confirmation.

### RULE-SUB-004: Safe Write Protocol & Just-In-Time (JIT) Ephemeral Authentication
1. **Dual-User Separation**: Subsystems `MUST` establish distinct service accounts:
   - **Auditor (Read-Only)**: Uses static credentials stored in git-ignored `LCM_Inventory/secrets.json` strictly for non-modifying telemetry and inventory queries.
   - **Operator (Write / Privileged)**: Authenticated strictly on-demand via **Just-In-Time (JIT) Ephemeral Sessions**.
2. **Zero Disk / Zero Log Persistence for Privileged Credentials**:
   - Write-mode passwords and tokens `MUST NOT` be stored in `LCM_Inventory/secrets.json`, configuration files, or logs.
   - Ephemeral session tokens generated from JIT authentication `SHALL` reside strictly in volatile memory (RAM) for the duration of the mutation batch (default 15–30 minutes) and be purged immediately upon completion.
3. **5-Stage Safe Mutation Pipeline**:
   - All state modifications `MUST` execute through the 5-stage pipeline: `(1) Pre-Flight State Snapshot` $\rightarrow$ `(2) Beyond Compare Visual Payload Gate` $\rightarrow$ `(3) Atomic API Dispatch` $\rightarrow$ `(4) Tiered Polling Health & Liveness Loop (up to 10m for Add-ons, up to 20m for Core, up to 30–45m for Host OS reboots / schema migrations)` $\rightarrow$ `(5) Automated Rollback on Failure`.

### RULE-SUB-005: Strict Log & Evidence Segregation
1. Host-level CM activities (`LCM_Inventory/logs/cm_activity.log`) record only macro repository lifecycle milestones.
2. Granular runtime events, entity modifications, and API traces `MUST` write exclusively to the Subsystem's internal log directory (`<Subsystem>/logs/subsystem_activity.log` and `<Subsystem>/logs/api_traffic.log`).
3. Outgoing and incoming log messages `MUST` pass through automatic regex sanitization to redact any authorization headers, bearer tokens, or password strings.

### RULE-SUB-006: Subsystem External Update-Gate & Breaking-Change Bundling Protocol
1. **Automated Discovery & Breaking-Change Ingestion**:
   - The Subsystem update engine `MUST` scan external updates (Core, OS, Add-ons, Integrations, HACS components, device firmwares) and parse all accompanying release descriptions, explicitly extracting **Breaking Changes**.
   - Each discovered update `SHALL` generate a structured **Change Request Proposal (CRP)** in `data/proposals/`.
2. **Relevance & Risk-Ordered Review**:
   - CRPs `MUST` be prioritized and ordered by operational risk: (1) Breaking Changes & Core/OS $\rightarrow$ (2) Add-ons & Network Services $\rightarrow$ (3) HACS custom components $\rightarrow$ (4) Minor device firmwares.
   - Operators may accept, partially reject, or defer individual CRPs.
3. **Consolidation into Approved Update Bundles**:
   - Accepted CRPs are consolidated into a versioned **Update Bundle** (e.g. `data/bundles/BUNDLE-YYYYMMDD.json`) for semi-automatic execution.
4. **Mandatory Pre-Update Backup & Safety Gate**:
   - Prior to applying any external updates, an atomic full-system snapshot / backup `MUST` be initiated via the Subsystem API.
   - If the pre-update backup fails or times out, the update pipeline `MUST` abort immediately.
5. **Execution Under Security Protocol**:
   - Upon backup verification, the update bundle `SHALL` execute under the JIT visual authentication protocol (`RULE-SUB-004`) followed by the operation-aware Tiered Polling Health Loop (generous multi-minute budgets: up to 10m for Add-ons, 20m for Core, 30–45m for Host OS reboots / large migrations) checking `state == 'RUNNING'` and `safe_mode == false`, with automated rollback on failure.

### RULE-SUB-007: Central Registry Non-Mutation Invariant
1. **Authoritative Internal State**: The Subsystem's internal runtime registries (e.g. Home Assistant OS Device Registry, Entity Registry, Area Registry, and Config Entries stored in `.storage/`) constitute the authoritative internal state of the Subsystem host.
2. **External Write Prohibition**: Tooling, scripts, and MCP agents executing on the host PC `MUST NOT` attempt to mutate, overwrite, clean, or inject records into the Subsystem's internal central registry from the outside (whether via direct `.storage/` file writes or WebSocket mutation endpoints like `config/device_registry/update`).
3. **Observation-Only Protocol**: LCM Configuration Management tools `SHALL` operate strictly as read-only observers and reconcilers. Even if internal registry records contain historical errors, duplicate hardware identifiers, or inconsistent naming, corrections `MUST` be performed exclusively within the official Subsystem UI by the human operator.

---

<a id="macro-definitionsmd"></a>
## Rule #16: macro-definitions.md
> **Category**: 4. Documentation & Subsystem Architecture | **Canonical Source**: `.agents/rules/macro-definitions.md`

# macro-definitions.md
# version: 5.1.0
# date: 2026-09-27

# MACRO-DEFINITIONS-METADATA
# scope: durable-memory
# location: .agents/rules/macro-definitions.md
# update-policy: manual

## Syntax Convention: Antigravity IDE Bare-Word Standard
In the Antigravity IDE environment, typing the `@` character triggers the IDE's interactive context-attachment popup (`@Files`, `@Docs`, `@Git`). Therefore, bare-word command invocations (`ToolExplorer`, `ShowTools`, `tools`, `ar`, `bcr`, `COMPLETE`, `PUBLISH`, `DO <#>`, etc.) are the primary and preferred syntax. The `@` prefix remains supported as a backward-compatible alias.

MACRO: technical
- description: enforce strict technical, ascii-only, deterministic output
- syntax: technical | @technical
- rules:
  - no prose
  - no decoration
  - no emojis
  - no unicode
  - explicit structures only

MACRO: user
- description: normal user-facing mode
- syntax: user | @user
- rules:
  - allow brief explanations
  - allow minimal formatting
  - keep responses concise

MACRO: S
- description: system-aligned mode
- syntax: S | @S
- rules:
  - follow workspace rules
  - follow copilot profile
  - respect durable-memory files

MACRO: profile status
- description: report current copilot profile state
- syntax: profile status | @profile status
- rules:
  - summarize durable-memory presence
  - summarize test-suite presence
  - summarize version alignment

MACRO: GoodMorning
- description: full read-only session-start check (RULE-CTX-006): time gap, work in between, versions, context staleness, pending learned advice
- syntax: GoodMorning
- primary target: LCM_Inventory/tools/Invoke-WorkspaceGoodMorning.ps1 -Force
- rules:
  - report every attention item to the operator before other work
  - confirm that ACTIVE_CONTEXT.md and LEARNED_ADVICE.md were read and can be followed
  - change nothing

MACRO: learn
- description: record something learned as a candidate for LEARNED_ADVICE.md (RULE-CTX-005)
- syntax: /learn <text> | learn <text>
- rules:
  - add the text as a candidate with Save-AllSessionMemory.ps1 -Learn "<text>" -Author <AI name>; do nothing else
  - candidates are reviewed with Invoke-LearnedAdviceReview.ps1 no later than push (push is refused while any are pending)

MACRO: ToolExplorer
- description: generate and launch the authoritative LCM Tool Explorer interactive HTML application via Show-ToolsExplorer.ps1
- syntax: ToolExplorer [switches] | tools [switches] | ShowTools [switches]
- aliases: tools, ToolsExplorer, ShowTools
- primary target: LCM_Inventory/tools/Show-ToolsExplorer.ps1 (trampolines: LCM_Inventory/Cmd/ToolExplorer.cmd, ToolsExplorer.cmd)
- parameters:
  - -Audience <User|Dev|All>: pre-filter audience category (defaults to 'User')
  - -Group <Name>: pre-filter by group or subsystem (e.g. 'HaSSD06', 'LCM', 'SystemConfiguration')
  - -Subsystem <Name>: direct filter for specific subsystem (e.g. 'HaSSD06', 'LCM_Inventory')
  - -HaSSD06 (or -Ha): quick switch to filter directly to Home Assistant HaSSD06 tools
  - -Role <RoleName>: pre-filter by functional role (e.g. 'QualityGate', 'ReviewGate', 'Elevation', 'DesktopGUI')
  - -Tool <ToolName>: pre-select and highlight specific tool
  - -Env <PS1|CMD|PY|REG|LNK|All>: pre-filter by tool execution environment
  - -Filter <query>: initial text search keyword on startup (supports '!term' negation)
  - -NoBrowser (or -Cli, -Text): suppress browser and output catalog to terminal
  - -NoLaunch: generate HTML dashboard and cache without browser launch
  - -h (or -Help): display comprehensive parameter reference
- examples:
  - 'ToolExplorer' or 'tools' -> launches Tool Explorer filtered to Audience=User
  - 'ToolExplorer -Audience Dev' -> launches Tool Explorer filtered to internal developer tools
  - 'ToolExplorer -HaSSD06' -> launches Tool Explorer filtered to HaSSD06 subsystem
  - 'ToolExplorer -NoBrowser' -> renders tool catalog directly in console

MACRO: set-tool-audience
- description: configure whether a tool is User-exposed or Developer-only
- syntax: set-tool-audience | @set-tool-audience
- note: Tool audience, role, and metadata are maintained interactively directly within the ToolExplorer application (or via Update-ToolCatalog.ps1)

MACRO: log
- description: locate and open latest LCM log file and reveal full log history in File Explorer
- syntax: log [ToolName] | logs [ToolName]
- aliases: log, logs, lastlog
- rules:
  - 'log' or 'logs' -> executes 'pwsh -File tools/Show-LastLog.ps1'
  - 'log <ToolName>' -> executes 'pwsh -File tools/Show-LastLog.ps1 -ToolName <ToolName>'

MACRO: BCR
- description: launch Beyond Compare 5 visual review display for a repository against baseline commit
- syntax: bcr <repo> [commit] | BCR <repo> [commit]
- aliases: bcr, BCR, @bcr
- rules:
  - 'bcr <repo>' or 'BCR <repo>' -> executes 'pwsh -File LCM_Inventory/tools/Invoke-BeyondCompareReview.ps1 -RepositoryName <repo>'
  - 'bcr <repo> <commit>' -> executes 'pwsh -File LCM_Inventory/tools/Invoke-BeyondCompareReview.ps1 -RepositoryName <repo> -BaseCommit <commit>'

MACRO: COMPLETE
- description: submit a completed review result, close the Beyond Compare review window, run quality gates, and commit locally
- syntax: complete [repo] | COMPLETE [repo]
- aliases: complete, COMPLETE, completed
- rules:
  - 'complete <repo>' or 'COMPLETE <repo>' -> executes 'pwsh -File LCM_Inventory/tools/Submit-ReviewResult.ps1 -RepositoryPath <repo> -Result Completed'
  - automatically closes matching Beyond Compare review window
  - never invokes a remote push

MACRO: FixDocumentation
- description: reconcile explicit CRP/BUG documentation payloads into the LCM tripartite documents
- syntax: FixDocumentation <CRP/BUG scope> [-Apply] | fixdocumentation <CRP/BUG scope> [-Apply]
- aliases: fixdocumentation, FixDocumentation
- rules:
  - default behavior is dry run and writes a reconciliation manifest without changing documents
  - `-Apply` writes only explicit `Documentation Updates` payloads declared by the selected bundles
  - conflicting or ambiguous payloads stop without modifying documentation
  - an applied update requires BCompare review before local commit
  - executes `pwsh -File LCM_Inventory/tools/Fix-Documentation.ps1 <scope>` (or `LCM_Inventory/Cmd/FixDocumentation.cmd`)

MACRO: PUBLISH
- description: publish a completed proposal cohort and LCM_Inventory to their remotes in lockstep
- syntax: publish [repo] | PUBLISH [repo]
- aliases: publish, PUBLISH, push, PUSH
- rules:
  - 'publish <repo>' or 'PUBLISH <repo>' -> executes 'pwsh -File LCM_Inventory/tools/Invoke-WorkspacePush.ps1 -Repositories <repo>'
  - `push` and `PUSH` remain backward-compatible aliases.
  - requires every target proposal to be completed and LCM_Inventory to be ahead before any remote dispatch

MACRO: tsr (Legacy / Automated)
- note: Superseded by persistent TimestampHeaderRule codified in InvariantRules.md. Automated on every turn; manual macro invocation is deprecated.

MACRO: ar
- description: generate retrospective execution trace and error triage diagnostics report analogous to BC5-Resolution-Analysis.md
- syntax: ar [offset] | AnalyzeReasoning [offset]
- aliases: ar, AR, AnalyzeReasoning
- rules:
  - 'ar', 'AR', or 'AnalyzeReasoning' -> executes 'pwsh -File LCM_Inventory/tools/Invoke-ReasoningAnalysis.ps1 -Offset 0' (or LCM_Inventory/Cmd/ar.cmd)
  - 'ar <offset>' or 'AnalyzeReasoning <offset>' -> executes 'pwsh -File LCM_Inventory/tools/Invoke-ReasoningAnalysis.ps1 -Offset <offset>'
  - generates a structured report in LCM_Inventory/data/logs/ containing Execution Trace, Error Triage & Avoidance Matrix, and Decision Rationale

---

<a id="workspace-agentsmd-directive"></a>
## Rule #17: Root AGENTS.md Directive
> **Canonical Source**: `AGENTS.md` (Root Workspace Controller)

# Lifecycle Model (LCM) Multi-Repository Governance

This root container operates under the **Lifecycle Model (LCM)** architecture. All child repositories inherit governance policies from `.agents/rules/`.

> [!NOTE]
> **Comprehensive Rule Matrix**: For full cross-repository details, rule codes, enforcement scripts, and child repository junction mappings, see the authoritative [LCM Rules Cross-Reference Matrix](file:///LCM_AI/docs/LCM-Rules-Cross-Reference.md).

---

## 1. Quick-Reference Rules Index Table

| Rule File | Rule Identifiers | Domain | Scope | Core Invariant |
|:---|:---|:---|:---|:---|
| **[ProposalReviewFlowPolicy.md](file:///.agents/rules/ProposalReviewFlowPolicy.md)** | `RULE-LCM-001` - `024` | **Proposal & Review Flow** | Workspace & Child Repos | Proposal-first intent, batch commands (`do`, `delete`, `defer`), Beyond Compare 5 review gate, dual-commit sync, Dual-State lifecycle, CM plan archive, Unconditional Plan Review Gate & Anti-Auto-Proceed Invariant (`RULE-LCM-014`), intake gates (`BUG:`, `CRP:`), directional `PROCEED ALL`, 2-attempt loop breaker, credit exhaustion guards, Active App Context (`Workon: A#`), multi-App problem gating, automated tripartite synthesis on `COMPLETE`, Proposal Bundle Directory Architecture (`RULE-LCM-020`), Tool & Macro Synchronization Invariant (`RULE-LCM-021`), Atomic Edit Consolidation & Editor Review Safety Invariant (`RULE-LCM-022`), Minimal Tests Single-Cycle Execution Switch & State Reflection Invariant (`RULE-LCM-023`), and Mandatory Pre-Handoff Verification & Zero-Assumption Testing Invariant (`RULE-LCM-024`). |
| **[PowerShellStandardsPolicy.md](file:///.agents/rules/PowerShellStandardsPolicy.md)** | `RULE-PS-001` - `021` | **PowerShell Standards** | All `*.ps1`, `*.psm1`, `*.psd1` | StrictMode `@(...)` wrapping, Microsoft approved verbs (`Get-Verb`), colon-safe string interpolation, test elevation gating, header metadata & date maintenance, structured logging, `-h` help, interactive desktop dispatch routing, prohibition of bare inline `(if ...)`, `Import-Module -Name`, Smart Inheritance propagation, variable string interpolation & colon boundaries, and Mandatory Pre-Handoff AST Syntax Gate & Zero-Assumption Testing Invariant (`RULE-PS-021`). |
| **[ReviewCommitGovernancePolicy.md](file:///.agents/rules/ReviewCommitGovernancePolicy.md)** | `RULE-REV-001` - `010` | **Commit Gating & Review** | Governed Repos & Root | Mandatory review-gated commits (`ACCEPTED`), Gate 2 visual review with 2 authorized bypass exceptions (explicit operator `IMMEDIATELY`/`FORCE` instruction, or critical loop-preventing bug with max 2 attempts), reproducible local composite BCompare baselines using time-aligned junction-authority rules snapshots, policy-discovery disclosure, readiness quality gate pass, audit receipts in `LCM_Inventory/data/reviews/`, and Zero-Assumption Pre-Review Gate Verification Invariant (`RULE-REV-010`). |
| **[MethodEfficiencyPolicy.md](file:///.agents/rules/MethodEfficiencyPolicy.md)** | `RULE-EFF-001` - `008`, `RULE-ENV-003` | **Method Efficiency** | CM Telemetry & Evidence | Auto-acceptance of mechanical evidence, zero-test cascade on telemetry, short-circuit on quality gate failures, DOIT autonomous execution velocity, search dispatch routing (`Search-Everything.ps1`/`rg.exe`), tool catalog discovery, zero speculative relative pathing. |
| **[ElevationPolicy.md](file:///.agents/rules/ElevationPolicy.md)** | `RULE-ELEV-001` - `006` | **Security & Privileges** | Workspace-wide | Least-privilege execution default, elevated script runner delegation, auto-detection of privileged commands, elevated console non-auto-close invariant, and automated privilege-aware execution/elevation interception. |
| **[LanguagePolicy.md](file:///.agents/rules/LanguagePolicy.md)** | `LANGUAGE-POLICY` | **Localization & Naming** | Global Workspace | English-always invariant for code, comments, documentation, filenames, and commit messages. |
| **[RepositoryContextPolicy.md](file:///.agents/rules/RepositoryContextPolicy.md)** | `REPO-CONTEXT` | **Context Scoping** | Child Repositories | Strict repository boundary separation, deterministic relative path resolution, CM-only cross-repo writes. |
| **[InvariantRules.md](file:///.agents/rules/InvariantRules.md)** | `INVARIANT-RULES` | **Core Formatting & Output** | Workspace-wide | Determinism, reproducibility, ASCII default, 2-space indentation, CRLF newlines, UTF-8 without BOM, zero-assumption testing, and mandatory pre-handoff syntax/AST validation. |
| **[PowerShellRules.md](file:///.agents/rules/PowerShellRules.md)** | `POWERSHELL-RULES` | **Scripting Standards** | PowerShell code | StrictMode Latest, `$ErrorActionPreference = 'Stop'`, explicit CmdletBinding. |
| **[CMDRules.md](file:///.agents/rules/CMDRules.md)** | `CMD-RULES` | **Windows Batch** | `*.cmd`, `*.bat` | Explicit echo control (`@echo off`), errorlevel verification, ASCII character sets. |
| **[JsonRules.md](file:///.agents/rules/JsonRules.md)** | `JSON-RULES` | **Data Serialization** | `*.json` | UTF-8 without BOM, 2-space indentation, `$schema` references. |
| **[PythonRules.md](file:///.agents/rules/PythonRules.md)** | `RULE-PY-001` - `008` | **Python Standards** | All `*.py` | No redundant f-strings (`F541`), strict import ordering, zero unused imports/variables (`F401`/`F841`), Windows UTF-8 stdout reconfiguration, template/JS interpolation safety. |
| **[GoRules.md](file:///.agents/rules/GoRules.md)** | `LCM-RULE-GO-001` | **Go Standards** | All `*.go` | Mandatory file header block, explicit error handling and control flow, resource discipline, memory/slice/type rules, Windows platform rules. |
| **[DocumentationStandardsPolicy.md](file:///.agents/rules/DocumentationStandardsPolicy.md)** | `RULE-DOC-001` - `007` | **Documentation Standards** | All `*.md`, `docs/`, `install/` | Tripartite specifications (`Architecture.md`, `Requirements.md`, `Implementation.md`), universal `install/Installation.md` runbook, DOX metadata headers, `M.Y.Z` major parity, $M-2$ retention horizon, and App-Centric Modular Architecture (`App: #`) with Constituent Manifests & Contract Governance. |
| **[DisplayStandardsPolicy.md](file:///.agents/rules/DisplayStandardsPolicy.md)** | `RULE-DSP-001` - `016` | **UI & Display Standards** | All UI Displays, Dashboards & GUIs | Antigravity-IDE Light Mode default palette & typography (`IBM Plex Mono/Sans`, `CM_CONTROL_HUB_IMPLEMENTATION_0.html`), Topbar & Status Rail architecture, Lucide vector icons, WPF/WinForms desktop GUIs, print-to-PDF paged media, theme persistence, desktop dispatching, IDE Canvas forward-compatibility, test window hygiene, and dynamic tool versioning. |
| **[SubsystemGovernancePolicy.md](file:///.agents/rules/SubsystemGovernancePolicy.md)** | `RULE-SUB-001` - `007` | **Subsystem Architecture** | Subsystem Repositories | Disjunct domains, dedicated subsystem inventories, JIT ephemeral tokens, host safety hardware interlocks, log segregation, Update-Gate & CRP bundling, central registry non-mutation invariant. |
| **[AnalysisGovernancePolicy.md](file:///.agents/rules/AnalysisGovernancePolicy.md)** | `RULE-ANA-001` - `006` | **Analysis Governance** | Workspace & Gemini Sessions | Intent wake words (`ANALYZE` / `IMPLEMENT`), read-only tool lock, provenance tagging (`[VERIFIED]`, `[GAP]`), search radius fence ($\le 2$), Circuit Breaker protocol (`[ANALYSIS RESUMED]`), and runtime state transparency. |
| **[RuleAuthority.md](file:///.agents/rules/RuleAuthority.md)** | `RULE-AUTHORITY` | **Governance Hierarchy** | Core Governance | Single source of truth, no rule forking, machine-readable canonical rules in `.agents/rules/`. |
| **[macro-definitions.md](file:///.agents/rules/macro-definitions.md)** | `MACRO-DEFS` | **Operator Macros** | Interactive Shell | Antigravity IDE bare-word standard (`ToolExplorer`, `ShowTools`, `tools`, `ar`, `bcr`, `COMPLETE`, `PUSH`), `@tsr` superseded by persistent `TimestampHeaderRule`, `@RULEAUTH`, `@ml`. |

---

## 2. Rule Discovery Architecture
- **Canonical Hub**: `LCM_AI\.agents\rules\` (18 authoritative rule files; physical owner & primary commit gate).
- **Root & Child Discovery**: Root `D:\Git_Repositories\.agents\rules` links to `LCM_AI\.agents\rules` via junction, eliminating root commit churn. Every governed child repository links `.agents/rules` directly to this hub, guaranteeing 100% rule discovery whether opening the workspace root or an individual repository folder.

---

## 3. Durable Memory & System Troubleshooting Context
- **Active Troubleshooting Thread**: Mouse focus/flicker investigation & background services isolation.
- **Logitech Suppression Status**: Audited against `KillLogitechUpdateFull.ps1` (54/54 items 100% enforced, 0 reversions).
- **Authoritative System Restore Tool**: [`tools/Restore-SystemSettings.ps1`](file:///D:/Git_Repositories/LCM_Inventory/tools/Restore-SystemSettings.ps1).
- **Active Session State File**: [`.agents/ACTIVE_SESSION.md`](file:///D:/Git_Repositories/.agents/ACTIVE_SESSION.md).

---

<a id="workspace-geminimd-directive"></a>
## Rule #18: Root GEMINI.md Directive
> **Canonical Source**: `GEMINI.md` (Gemini Directive)

<!-- Governed by root LCM standard: D:\Git_Repositories\AGENTS.md -->
# GEMINI.md - LCM Governance Directive

This workspace is governed by the Lifecycle Model (LCM) framework.
See authoritative rules in `.agents/rules/`, [`AGENTS.md`](file:///AGENTS.md), and the [`LCM-Rules-Cross-Reference.md`](file:///LCM_AI/docs/LCM-Rules-Cross-Reference.md).

