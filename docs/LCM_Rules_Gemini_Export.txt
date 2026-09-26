# Lifecycle Model (LCM) Authoritative Governance Framework
> **Consolidated Master Specification for Gemini AI, Google Drive & Subagents**
> *Exported on: 2026-09-26 19:11:31 | Host: D5P0-SSD980-Z | Version: 1.2.0*

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
Authors: Rolf, Workspace_AI Governance  
Version: 8.0.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Governance Authority Invariants

### `RULE-AUTH-001` (Single Source of Truth & Zero Rule Forking)
- **Canonical Physical Hub**: `Workspace_AI\.agents\rules\` is the single, authoritative physical host and primary commit gate for all LCM governance rules.
- **Root & Child Discovery**: The root workspace container links `D:\Git_Repositories\.agents\rules\` directly to `Workspace_AI\.agents\rules\` via NTFS directory junction (`mklink /J`), avoiding rule commit churn on the root container. All governed child repositories link their local `.agents\rules` directory to this canonical hub.
- **No Independent Truth**: Child repositories and IDE adapter surfaces `MUST NOT` fork, maintain conflicting local copies, or override core governance policies without an approved Change Request.

---

### `RULE-AUTH-002` (Mandatory Rule Matrix Synchronization Invariant)
Whenever an existing rule is updated, or a new rule/policy is created ("invented"), the author or AI agent `MUST` update all discovery entrypoints in the same change set:
1. **Root Quick-Reference Table**: Update [`AGENTS.md`](file:///d:/Git_Repositories/AGENTS.md) with the new rule name, rule codes (`RULE-*`), domain, scope, and key invariant.
2. **Comprehensive Matrix**: Update [`Workspace_AI/docs/LCM-Rules-Cross-Reference.md`](file:///d:/Git_Repositories/Workspace_AI/docs/LCM-Rules-Cross-Reference.md) with the full metadata, enforcing scripts, and quality gate mappings.
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
Version: 8.1.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-26  

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
Authors: Rolf, Workspace_AI Governance  
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
Every repository governed under LCM `MUST` declare an explicit `execution_context` block inside its `.lcm/config.json`:
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
Any code in `src/` or `Source/` utilizing privileged Windows commands (`bcdedit`, `fltmc`, `fsutil`, `Get-Partition`, `DiskPart`, `Add-BitLockerKeyProtector`, or `Verb RunAs`) `MUST` have `elevation_required: true` declared in `.lcm/config.json`.
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
Ensure that any tool, script, or shorthand command requiring administrative privileges is never executed directly within a standard un-elevated user context. Instead, enforce automatic discovery and routing through the standardized CLI interceptor (`.lcm/tools/internal/Invoke-PrivilegedTool.ps1`), the background desktop daemon (`http://127.0.0.1:9876/execute`), or `Invoke-InteractiveDesktop.ps1`.

Before executing any tool, script, or shorthand command, the AI agent or CLI launcher `MUST` perform the following validation sequence:
1. **Catalog & Schema Lookup**:
   - Query the authoritative tool catalog (`.lcm/config/tool_catalog.json` / `WorkspaceInventory`) to resolve the target tool's metadata record.
   - Inspect whether the execution profile defines `"Admin": true` (or equivalent elevation requirement flag).
2. **Context & Privilege Verification**:
   - Check whether the current runtime shell session holds elevated administrative rights (e.g. `([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)`).
3. **Execution Routing & Interception**:
   - **Standard Execution**: If the tool does **not** require admin rights (`"Admin": false` or unset), execute it directly in the current session.
   - **Elevated Interception**: If `"Admin": true` and the current session is running under a standard un-elevated user context, **do not** execute the script directly in that session. Immediately route the call via:
     ```powershell
     pwsh .lcm/tools/internal/Invoke-PrivilegedTool.ps1 -Tool <ToolName> [-Arguments <Args>] [-NoExit]
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
Authors: Rolf, Workspace_AI  
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
1. `<TargetRepo>/.lcm/config.json` (for elevation requirements, governance version, and repository classification).
2. `<TargetRepo>/README.md` (for module purpose, exported functions/atoms, and prerequisites).
3. Any open Change Requests / proposals in `<TargetRepo>/docs/Proposals/` (or active task files).

> [!NOTE]
> **Unonboarded Candidate Fallback:**  
> If `.lcm/config.json` is missing from an inspected target directory, the agent `SHALL` classify the repository as an `unonboarded-candidate` and reference the LCM onboarding workflow (`Invoke-LCMOnboardRepo.ps1`) rather than failing or running broad recursive scans.

### `RULE-CTX-003` (Zero Redundant Scan Invariant)
The agent `MUST NOT` run multi-step recursive discovery scans (`list_dir`, broad grep) across the entire workspace when operating within the scope of an identified repository.

### `RULE-CTX-004` (Methodology Awareness)
The agent `MUST` remain aware of the global LCM triad at all times:
* **`Workspace_AI`**: Governs release baselines (v4.3.0), templates, and quality gates.
* **`Workspace_Inventory`**: Configuration Management engine, audit ledger, and cross-repo CR indexing.
* **`SharedModules`**: Reusable functional PowerShell atom library (`Logging`, `VolumeAtoms`, `BcdAtoms`).

---

<a id="proposalreviewflowpolicymd"></a>
## Rule #6: ProposalReviewFlowPolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/ProposalReviewFlowPolicy.md`

# File: ProposalReviewFlowPolicy.md

Module: ProposalReviewFlowPolicy  
Purpose: Enforces ticket-first proposals, batch commands, Beyond Compare 5 review gates, granularity controls, and Workspace_Inventory dual-commit synchronization.  
Path: .agents/rules/ProposalReviewFlowPolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 8.6.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Core LCM Review Flow Rules

### RULE-LCM-001: Proposal-First Intent Invariant
When working in LCM mode (`active`), all user ideas, questions, and exploratory discussions `MUST` be treated as **Proposals only** (State = `suggested`).
- The AI agent `MUST NOT` execute file modifications, code rewrites, or commits immediately upon receiving an initial idea or question.
- When discussion yields a conclusive path of action, register the Change Request / Proposal with State `suggested` in `Workspace_Inventory\data\proposals\proposals.json`.

### RULE-LCM-002: Batch Execution & Control Commands
Proposals transition through the defined lifecycle via deterministic operator commands:
- **`Proceed` / `Proceed <ID>`**: **Single-step status increment**. Deterministically advances matching proposal(s) forward by exactly one discrete state:
  - At Gate 1: Advances from `SUGGESTED` $\rightarrow$ `IN_PROGRESS` (initiates implementation in Normal Cycle).
  - At Gate 2: Advances from `REVIEW` $\rightarrow$ `COMMITTED` (satisfies visual review, records disposition, increments SemVer, and commits to local Git).
- **`do <all, #n, #n-#m> Proposals`**: **Activates `DOIT` mode** (`always-proceed = $true`). Bypasses Gate 1 planning pauses and executes planned tool operations, script runs, and file edits continuously until downstream Gate 2 is reached per `RULE-EFF-004`.
- **`ACCEPT` / `ACCEPT ALL`**: **Alias to PUSH**. Pushes **all currently `COMMITTED` proposals only** to remote repositories (`COMMITTED` $\rightarrow$ `PUSHED`) in lockstep, enforcing the remote push version synchronization per `RULE-REV-007`. Uncommitted, suggested, or in-review items are strictly excluded from push.
- **`delete <all, #n, #n-#m> Proposals`**: Sets matching proposals to `deleted` and clears associated CRs.
- **`defer <all, #n, #n-#m> Proposals`**: Sets matching proposals to `deferred`.
- **`give open Proposals`**: Returns numbered list of active proposals (`#n`).
- **`give repos under review`**: Displays repositories with uncommitted changes, their BC5 review status, and commit readiness.

### RULE-LCM-003: Review Granularity Controls
The review frequency is governed by `review_granularity` in `Workspace_Inventory`:
- **`coarse` (Default)**: Executes all proposals in the batch, runs automated quality gates, then presents a **single BC5 review stop** for the combined changes across the repository before commit.
- **`tight`**: Implements each proposal incrementally with intermediate test runs and a **dedicated BC5 review stop per proposal**.
- Can be set via `set review granularity <coarse|tight>` or inline `do #1-#3 Proposals --tight`.

### RULE-LCM-004: Visual Diff Review & Exemption Scope
- **Governed Repositories & Root Container**: Every governed repository and the Root Container (`D:\Git_Repositories`) `MUST` undergo visual diff review via `Invoke-BeyondCompareReview.ps1 <RepoName>` before commit.
- **Dual-Session Junction Review**: For repositories containing NTFS directory junctions (e.g. `.agents` pointing to `Workspace_AI\.agents`, or `.agents\rules` pointing to `Workspace_AI\.agents\rules`), `Invoke-BeyondCompareReview.ps1` `MUST` automatically dispatch a second Beyond Compare review session targeting the live junction destination on the right pane per `RULE-REV-008`.
- **Privileged Subsystem Data Exemption vs. Tool Scrutiny**:
  - **Dynamic Configuration & Ledger Data Exemption (`RULE-EFF-001`)**: Ledger data, review staging receipts, baseline manifests, telemetry logs, and scratch generation outputs located in `Workspace_Inventory` (`data/`, `logs/`, `scratch/`) are auto-accepted mechanical evidence and exempt from visual diff review stops.
  - **Executable Tools & Documentation Scrutiny**: All permanent scripts, PowerShell modules, test suites, and architectural documentation located in `Workspace_Inventory` (`tools/`, `modules/`, `docs/`, `tests/`, `Cmd/`) are first-class governed LCM software assets and `MUST` undergo visual diff review via `Invoke-BeyondCompareReview.ps1 Workspace_Inventory` prior to commit.

### RULE-LCM-005: Dual-Commit and Push Synchronization Invariant
1. Whenever code changes in a target repository are accepted and committed, `Workspace_Inventory` `MUST ALWAYS` be updated (updating proposal state to `completed`, recording review evidence) and **committed immediately**.
2. On any `git push` (`ACCEPT ALL`), all modified target repositories and `Workspace_Inventory` `MUST` be pushed to their respective remotes in lockstep.

### RULE-LCM-006: Pause, Resume, and Escape Controls
1. **`LCM OFF` (Emergency Escape Switch)**:
   - Temporarily suspends proposal bundle scaffolding and governance gating to enable immediate emergency remediation of corrupted host configurations or broken environments.
   - Re-activated via `LCM ON` or `resume LCM`.
2. **`Testing OFF` (Deferred Deep Testing Switch)**:
   - Suppresses heavy, multi-minute test cascades (deep Pester DAGs, elevated integration test suites) during rapid interactive development and intermediate Gate 2 checkpoints.
   - Syntax validation and fast unit checks still run, but deep testing is strictly deferred to the pre-push quality gate.
   - **Deferred Failure Protocol**: If deep testing encounters errors during pre-push validation, the push is immediately aborted and the failure automatically spawns a formal **`BUG`** proposal bundle in `DOIT` mode (`RULE-LCM-008`).
3. **Push Auto-Reset Invariant (Self-Healing Governance)**:
   - Neither `LCM OFF` nor `Testing OFF` may remain active after publication. Upon any push invocation (`ACCEPT`, `ACCEPT ALL`, `Invoke-WorkspacePush.ps1`), both **LCM Mode** and **Testing Mode** `MUST` unconditionally reset to `ON` (`active`).

### RULE-LCM-007: Dual-State Proposal Lifecycle & CM Plan Archive Invariant
1. **Dual-State Separation**: Every proposal in `Workspace_Inventory/data/proposals/proposals.json` `MUST` track both:
   - **Governance Plan State (`state`)**: Document approval state (`bug`, `suggested`, `approved`, `deferred`, `rejected`, `completed`, `pushed`).
   - **Implementation Progress State (`progress_state`)**: Physical execution progress (`undecided`, `queued`, `in_progress`, `verification`, `completed`, `pushed`, `blocked`, `failed`).
2. **Initial Invariant**: Every newly submitted proposal and unapproved plan `MUST` initialize with `progress_state: "undecided"`.
3. **Pushed Lifecycle Transition**: Upon successful execution of `Invoke-WorkspacePush.ps1` (or CM Control Hub Push), proposals in `completed` state whose origin repository was pushed `MUST` transition to `pushed` (`pushed_at` timestamp recorded).
4. **Mandatory CM Plan & Walkthrough Archival**:
   - All Markdown implementation plans and execution walkthroughs `MUST` be persistently archived in the governed CM repository under:
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Plan.md`
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Walkthrough.md`
   - Explicit relative links `plan_path` and `walkthrough_path` `MUST` be recorded in `proposals.json`.

### RULE-LCM-008: BUG Lifecycle, DOIT Mode & Gate 2 Non-Circumvention Invariant
1. **Birth in `DOIT` Mode**: When a `BUG` is born (whether reported by the operator or self-discovered during test execution), it automatically initializes in **`DOIT` Mode** (`always-proceed = $true`).
   - The agent scaffolds the BUG proposal bundle (`docs/Proposals/BUG-<nnn>-[Slug]/`) and immediately executes code modifications, script adjustments, and unit verification tests continuously without pausing for a Gate 1 planning approval.
2. **Strict Gate 2 Non-Circumvention Invariant**:
   - **Even a critical, urgent, or internally generated BUG MUST NOT circumvent Gate 2.**
   - Once the fix is verified in the working tree and logged in `Walkthrough.md`, the agent `MUST UNCONDITIONALLY HALT` at Gate 2, dispatch the visual review session (`Invoke-BeyondCompareReview.ps1`), and await explicit operator review disposition. The agent `MUST NEVER` self-commit or self-push bug fixes.

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
1. **Mandatory Self-Discovery Reporting**: Whenever the AI agent discovers a bug, syntax defect, unhandled runtime exception, parser failure, or regression in a permanent tool, platform script, shared module, or web UI during development, testing, or tool execution (including deferred deep testing failures per `RULE-LCM-006`), the AI agent `MUST` formally register a Bug Report in `Workspace_Inventory/data/proposals/proposals.json` and scaffold the accompanying proposal bundle.
2. **Immediate Remediation in `DOIT` Mode**: The self-discovered bug transitions directly into `DOIT` mode to diagnose and resolve the failure, but remains bound by the Gate 2 Non-Circumvention Invariant (`RULE-LCM-008`).
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
1. **Mandatory Standalone Specification**: Whenever proposing, designing, or implementing new features, tools, workflows, architectural enhancements, or governance policies, the AI agent `MUST` author a formal, standalone Scope-and-Version Explicit Change Request Proposal specification (`Specification.md`) within its proposal bundle in `Workspace_Inventory/docs/Proposals/` before or alongside ledger registration.
2. **Prohibition of Orphan Feature Proposals**: Proposing or executing features or tool modifications without an authoritative, permanent proposal bundle in `Workspace_Inventory/docs/Proposals/` is strictly prohibited. Every non-bug feature proposal in `proposals.json` `MUST` link to a valid `bundle_id` matching an existing CRP bundle.

### RULE-LCM-013: Mandatory Pre-Push Gemini AI & Knowledge Base Synchronization Invariant
1. **Mandatory Automated Pre-Push Execution**: Every push operation executed via `Invoke-WorkspacePush.ps1` (or `ACCEPT ALL` triggers), whether multi-repository or targeting a single repository (`-Repositories <repo>`), `MUST` automatically execute the `Update-Gemini.ps1` pipeline prior to pushing commits to remote Git repositories. Direct manual `git push` invocations that bypass `Invoke-WorkspacePush.ps1` are prohibited.
2. **Context & Rules Mirroring Parity**: This guarantees that all 17 canonical LCM rules (`Workspace_AI/docs/LCM_Rules_Gemini_Export.md`), plain-text `.txt` mirrors, tool catalogs, and full workspace knowledge base exports (`D:\GDrive\LCM`) are 100% synchronized with the pushed Git baseline at the moment of remote dispatch.
3. **Automated Export Commit**: If the `Update-Gemini` pipeline updates the consolidated rules export in `Workspace_AI`, those changes `MUST` be staged and committed immediately before dispatching the push to `origin/main`.

### RULE-LCM-014: Dual-Gate Architecture & CRP Planning Gate Invariant
1. **CRP Birth in SUGGESTED State**: For any non-bug Change Request Proposal (`CRP`), the proposal `MUST` birth in the **`SUGGESTED`** state under the Normal Review Cycle.
2. **Gate 1 Planning Halt**: The AI agent `MUST` scaffold the Proposal Bundle directory, register the entry in `proposals.json`, present the plan, and `UNCONDITIONALLY HALT`. No source code, permanent script, configuration, or test file may be modified, created, or deleted while at Gate 1.
3. **Gate 1 Activation Triggers**:
   - **`Proceed`**: Advances state from `SUGGESTED` $\rightarrow$ `IN_PROGRESS` in the Normal Review Cycle (interactive checkpoints if open questions or design alternatives exist).
   - **`do` / `do <ID>`**: Advances state to `IN_PROGRESS` and activates **`DOIT` Mode** (`always-proceed = $true`), executing planned modifications continuously until Gate 2 is reached per `RULE-EFF-004`.
4. **Strict Dual-Gate Lifecycle**:
   - **Gate 1 (Planning Gate)**: Propose solution / Register proposal bundle & plan $\rightarrow$ `STOP` and await explicit operator direction (`Proceed` or `do`). (BUGs bypass Gate 1 into `DOIT` mode).
   - **Gate 2 (Review Gate / BC5 Gate)**: Implement approved changes $\rightarrow$ Present visual diffs / walkthrough / BC5 review $\rightarrow$ `STOP` and await operator review disposition. **Mandatory for all proposals, including BUGs.**

### RULE-LCM-015: Strict Intake Classification Gate
1. **Intake Signal Classification**:
   - `CRP:` designator indicates a Change Request Proposal: enters `SUGGESTED` state and halts at Gate 1.
   - `BUG:` designator indicates a Defect Report: enters `DOIT` mode immediately and executes directly to Gate 2.
2. **Priority Ordering**: Priority markings (including "*highest priority*" or "*critical*") affect execution order in batch queues; they `DO NOT` authorize bypassing Gate 2 visual review.

### RULE-LCM-016: Deterministic Lifecycle Command Invariants
1. **`Proceed` / `Proceed <ID>`**:
   - Deterministic single-status pulse: advances the target proposal forward by exactly **one discrete state**.
   - Gate 1: `SUGGESTED` $\rightarrow$ `IN_PROGRESS`.
   - Gate 2: `REVIEW` $\rightarrow$ `COMMITTED` (satisfies review, records audit disposition, increments SemVer, and commits to local Git).
2. **`do <ID>` / `do <batch>`**:
   - Activates **`DOIT` Mode** (`always-proceed = $true`), running all planned tool operations continuously from Gate 1 to Gate 2.
3. **`ACCEPT` / `ACCEPT ALL`**:
   - Authoritative alias to **`PUSH`**.
   - Filters and pushes **all currently `COMMITTED` proposals only** to remote repositories (`COMMITTED` $\rightarrow$ `PUSHED`).
   - Uncommitted, suggested, or in-review items remain strictly in their local state and are never pushed.
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

### RULE-LCM-019: Active App Context Inheritance & Automated Tripartite Synthesis on ACCEPT
1. **Active Context Inheritance (`Workon:`)**:
   - When an active App context is set via `Workon: A<#>` (e.g. `Workon: A1`), all subsequent Change Request Proposals (`crp: ...`), Bug Reports (`bug: ...`), and tasks generated during this focus `MUST` automatically inherit the active `app_id` (e.g. `"App: 1"`) in `proposals.json`.
   - When set to `Workon: Architecture` or cleared (`Workon: Base`), proposals are recorded with `app_id: $null` (foundational system scope).
2. **Automated Tripartite Synthesis upon `ACCEPT`**:
   - The `ACCEPT <id>` / `complete <id>` command serves as the authoritative lifecycle trigger that concludes an App increment.
   - Upon `ACCEPT`, the conclusive architecture decisions, technical requirements, and code manifests associated with the proposal `MUST` be synthesized into the repository's tripartite documentation under the designated `App: #` section:
     - Architectural summary $\rightarrow$ `Architecture.md` under `## App: #`
     - Normative invariants $\rightarrow$ `Requirements.md` under `## App: #`
     - Manifest table $\rightarrow$ `Implementation.md` under `## App: #`
3. **Multi-App Problem Resolution Gating**:
   - For multi-App bugs (`BUG-###`), the proposal `MUST` explicitly declare `primary_app` (root cause) and `affected_apps` (blast radius).
   - The bug cannot be marked `completed` or `committed` until the unit tests of the primary App *and* the integration tests of all affected Apps pass 100%.
   - On `ACCEPT`, documentation updates are synthesized across all affected App sections in a single atomic step.

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

---

<a id="reviewcommitgovernancepolicymd"></a>
## Rule #7: ReviewCommitGovernancePolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/ReviewCommitGovernancePolicy.md`

# File: ReviewCommitGovernancePolicy.md

Module: ReviewCommitGovernancePolicy  
Purpose: Defines mandatory review-gated commit rules, review disposition handling, forced commit overrides, audit logging, and dual-session directory junction reviews.  
Path: .agents/rules/ReviewCommitGovernancePolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 8.1.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Governance Rules

### RULE-REV-001: Mandatory Review-Gated Commits & Gate 2 Non-Circumvention Invariant
1. **Mandatory Visual Review Gate (Gate 2)**: Every Git commit action for source code, configuration, tools, modules, or structural assets (`*.ps1`, `*.psm1`, `.vscode/settings.json`, `.lcm/*`, `docs/*`) in any LCM-governed repository requires a prior validated review disposition (`ACCEPTED` or `ACCEPTED_WITH_EDITS`) produced via the formal Beyond Compare 5 visual review gate (`Invoke-BeyondCompareReview.ps1`).
2. **Strict Gate 2 Non-Circumvention for All Items**:
   - **Even critical, urgent, or internally generated BUGs MUST NOT circumvent Gate 2.**
   - While `BUG` items execute in `DOIT` mode (`always-proceed = $true`) without a Gate 1 planning pause, they `MUST HALT` at Gate 2 for operator review before reaching `COMMITTED`.
3. **Conversational Directives Do Not Waive Gating**: Explicit user instructions in chat (e.g. "yes, remove that", "fix this error") grant authority to execute file edits and staging, but **DO NOT waive the Beyond Compare visual review gate**. The agent `MUST` launch `Invoke-BeyondCompareReview.ps1` and await user review sign-off / folder clearance before stepping to `COMMITTED`.
4. **Exemption Scope**: Only purely mechanical telemetry artifacts defined in `RULE-EFF-001` (`inventory.json`, `INVENTORY_DASHBOARD.md`, `out/test_results.json`, and activity logs) are exempt from visual review gating.
5. **Non-Interactive / Headless Environment Fallback**: If Beyond Compare 5 or Session 1 interactive GUI execution is physically unavailable (e.g. running inside a headless CI/CD runner, container, or non-GUI remote SSH terminal), the agent `SHALL` present unified console diffs alongside the proposal's `Walkthrough.md` verification evidence for explicit terminal disposition before committing.

### RULE-REV-002: Accepted with Edits Qualification
When a review outcome is recorded as `Accepted with Edits` (or `Accepted with Change`):
1. The modified codebase `MUST` execute and satisfy all repository quality gates (`Test-RepoReadiness.ps1`).
2. The modifications `MUST NOT` introduce rule violations, regression errors, or broken dependencies.
3. Upon satisfying all quality gates, the state `SHALL` be classified as fully `ACCEPTED` and committed to Git.

### RULE-REV-003: Override & Force Authority for Rejected/Deferred States
If a review outcome is `REJECTED` or `DEFERRED`:
1. Automated commit and push pipelines `MUST` halt immediately.
2. Committing or pushing changes in a rejected or deferred state `IS FORBIDDEN` unless explicitly commanded by the user with a forced override instruction (e.g., `-Force` parameter or unambiguous explicit override prompt).

### RULE-REV-004: Precedence Over General Permission Rules
The review-gating rules (`RULE-REV-001` through `RULE-REV-003`) take strict precedence over any general "all commands are permitted" or automated background execution policies in effect across the workspace.

### RULE-REV-005: Universal Audit & Change Request Traceability
Every review disposition (`Accepted`, `AcceptedWithEdits`, `Rejected`, `Deferred`) `MUST` be recorded with an immutable timestamp, reviewer identity, repository HEAD SHA, and notes into:
1. `Workspace_Inventory/logs/cm_activity.log` (Append-only CM audit ledger).
2. `Workspace_Inventory/data/reviews/REVIEW-<Repo>-<Timestamp>.json` (Structured review evidence).
3. The active Change Request (CR) record in `Workspace_Inventory/data/change_requests.json` and mirrored proposal Markdown files when modifying governed baselines.

### RULE-REV-006: Mandatory Review Stop & Lifecycle Step Invariant
1. **Mandatory Review Stop**: Whenever an agent carries out a CRP or code modification reaching the visual review stage (Gate 2), the agent `MUST` launch `Invoke-BeyondCompareReview.ps1` and **immediately terminate the current response turn without making additional tool calls**.
2. **`Proceed` at Gate 2**: Upon operator submission of **`Proceed`** (or `Proceed <ID>`) after review inspection:
   - The proposal advances by exactly one status pulse: `REVIEW` $\rightarrow$ **`COMMITTED`**.
   - The local Git commit is created with the required SemVer increment per `RULE-REV-007`.
3. **`ACCEPT` / `ACCEPT ALL` (Push Trigger)**:
   - The `ACCEPT` command serves as an authoritative alias to **`PUSH`**.
   - `ACCEPT ALL` pushes **all currently `COMMITTED` proposals only** to remote repositories (`COMMITTED` $\rightarrow$ `PUSHED`).
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
     - `Workspace_Inventory/data/inventory.json` repository record.
   - Commit messages and review receipts `MUST` record the resulting semantic version (e.g. `feat(cm): ... [v7.1.1]`).
3. **Workspace_Inventory Operational Data Exemption**:
   - Routine data accounting mutations within `Workspace_Inventory` (specifically `data/inventory.json`, `data/proposals/proposals.json`, `logs/cm_activity.log`, `docs/INVENTORY_DASHBOARD.md`, and `data/reviews/*`) occurring as a standard byproduct of reviews, audits, proposal lifecycle transitions, or push recording `SHALL NOT` increment `Workspace_Inventory`'s semantic version.
   - Semantic version increments for `Workspace_Inventory` apply strictly when source code (`tools/*.ps1`, `modules/*.psm1`), specifications (`docs/*.md`), or governance policies are modified.

### RULE-REV-008: Transparent Single-Session Directory Junction Review (FollowSymLinks)
1. **Transparent Directory Junction Traversal**: Beyond Compare 5 review sessions `MUST` configure `<FollowSymLinks Value="True"/>` in `BCSessions.xml`, enabling Beyond Compare to traverse NTFS directory junctions (such as `.agents\rules`) inline within the primary review session.
2. **Unified Single-Window Invariant**: Dual-session Beyond Compare review dispatch is retired. All repository review comparisons execute in a single Beyond Compare window without opening a separate junction review instance.
3. **Automated Baseline Rules Provisioning**: When reviewing a child repository where the baseline Git commit does not natively track `.agents/rules`, `Invoke-BeyondCompareReview.ps1` `MUST` automatically populate the baseline rules directory (`<TempReviewRoot>\.agents\rules`) from the authoritative `Workspace_AI` baseline to ensure accurate inline diffing.
4. **Exclusion Filter Alignment**: Review exclusion filter lists `MUST NOT` filter out `-.agents\rules\`, ensuring all governance rule diffs remain directly inspectable in the primary review pane.

---

<a id="methodefficiencypolicymd"></a>
## Rule #8: MethodEfficiencyPolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/MethodEfficiencyPolicy.md`

# File: MethodEfficiencyPolicy.md

Module: MethodEfficiencyPolicy  
Purpose: Defines auto-acceptance, zero-test-trigger invariants, and method efficiency rules for generated inventory telemetry, logs, DOIT mode execution velocity, and tool discovery.  
Path: .agents/rules/MethodEfficiencyPolicy.md  
Authors: Rolf, Workspace_AI Engine  
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
* `Workspace_Inventory/data/inventory.json`
* `Workspace_Inventory/docs/INVENTORY_DASHBOARD.md`
* `Workspace_Inventory/data/baselines/*.json`
* `Workspace_Inventory/logs/*.log`
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
- **Direct execution of `es.exe` is strictly prohibited** due to IPC authorization constraints when running from non-interactive or Session 0 contexts.
- All high-speed file searches **must** be dispatched via `Search-Everything.ps1` (`.lcm/tools/internal/Search-Everything.ps1`) or directly against the Everything 1.5a HTTP REST API (port 8080).
- CLI text searches inside file contents **must** use `rg.exe` (installed machine-wide in `D:\Tools\rg\`).
- **Search Fallback Protocol**: If the Everything 1.5a HTTP REST API (port 8080) is unreachable or not running, tooling and agents `SHALL` fall back gracefully to `rg.exe --files` or PowerShell `Get-ChildItem` with scoped directory boundaries, ensuring operations never fail due to an inactive background daemon.

---

### RULE-EFF-008: Canonical Tool Discovery Standard
- Agents inspecting, modifying, or querying workspace tools or platform commands **must** query `.lcm/tools/internal/tool_catalog.json` first as the **authoritative single source of truth** before any filesystem traversal.
- Agents are **strictly prohibited** from executing broad, unindexed grep searches across `.psm1`, `.ps1`, or `.cmd` files to locate tool signatures or parameters when `tool_catalog.json` can satisfy the query.

---

### RULE-ENV-003: Zero Speculative Relative Pathing
- Speculative dot-traversal paths (such as `.\..lcm`, `..\..\`, or any path containing `..` without explicit validation) are **prohibited** in tool invocations and script references.
- Tool and script invocations **must** anchor strictly to one of:
  1. `$PSScriptRoot` for same-repository references.
  2. Registered trampolines in `.lcm/Cmd/` for cross-repository dispatch.
  3. An explicit `Resolve-Path` / `Test-Path` pre-flight check before any path is consumed.

---

## 3. Enforcement & Governance Integration

- **Readiness Runners**: `Test-RepoReadiness.ps1` and `Test-WorkspaceReadiness.ps1` treat changes in log directories and `out/` as non-invalidating evidence and enforce short-circuiting on failure.
- **Git Commit Workflow**: Automated audit syncs and baseline captures may be committed and pushed directly as `chore(audit)` or `chore(telemetry)` without entering formal Change Request review loops.
- **Agent Execution Policy**: Agents must operate in direct execution mode; interactive approval loops in chat UI are superseded by the RR pipeline.
- **Search Enforcement (RULE-EFF-007)**: All agents and tooling must route file-system searches through `Search-Everything.ps1` or the Everything HTTP API; `rg.exe` is the mandatory content-search tool.
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
Authors: Rolf, Workspace_AI Governance  
Version: 8.6.0  
Status: Authoritative Policy  
Date: 2026-09-26  

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

### RULE-PS-003: Colon-Safe String Interpolation
When interpolating a variable immediately followed by a colon (`:`) within a double-quoted string, developers `MUST` delimit the variable using `$($var):` or `${var}:`.
- **Rationale**: PowerShell treats `$var:` as an unclosed scope qualifier (e.g., `$global:`, `$script:`), causing a fatal `ParserError`.
- **Correct**:
  ```powershell
  Write-Host ("Created Proposal #{0}: {1}" -f $newId, $Title)
  # or
  Write-Host "Created Proposal #$($newId): $Title"
  ```
- **Forbidden**:
  ```powershell
  Write-Host "Created Proposal #$newId: $Title"  # Throws ParserError
  ```

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
1. **Persistent Audit Logging & Timestamp Precision**: Automatically write a timestamped log file (named `<ToolName>-yyyyMMdd_HHmmss.log`) to the repository-scoped `logs/` directory or `.lcm/logs/` (with fallback to `$env:TEMP/lcm/logs/` if repository logs are unavailable or unwritable) with at least second-level precision (`yyyy-MM-dd HH:mm:ss` or `yyyy-MM-dd HH:mm:ss.fff`). The minute-level format (`YYYYMMDD_HHMM`) is restricted strictly to assistant chat response headers and `MUST NOT` be used in tools or log entries.
2. **Structured Log Levels**: Classify every message using standard log levels: `[INFO]`, `[WARN]`, `[ERROR]`, `[DEBUG]`, `[ACTION]`, `[SUMMARY]` (converging on the `SharedModules/Logging` standard).
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
   Inspect whether `Invoke-InteractiveDesktop.ps1` exists in the workspace (`D:\Git_Repositories\tools\Invoke-InteractiveDesktop.ps1` or `$toolsDir`). If present, GUI execution `MUST` be routed through `Invoke-InteractiveDesktop.ps1` using:
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

<a id="powershellrulesmd"></a>
## Rule #10: PowerShellRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PowerShellRules.md`

# File: PowerShellRules.md

Module: PowerShellRules
Purpose: Authoritative rules for PowerShell script generation and normalization.
Path: .agents/rules/PowerShellRules.md
Authors: Rolf
Version: 8.6.0
Changelog:
- 2026-09-26: Standardized on PS7 (pwsh) runtime exclusively; parity for intermediate code.
- 2026-07-27: Split unified rule file; clarified ASCII constraints; stabilized PS rules.

POWERSHELL-RULES
- ps7-exclusive: pwsh (PS7) is mandatory workspace-wide; legacy powershell.exe (5.1) is forbidden
- intermediate-parity: rules apply equally to permanent scripts and inline pwsh -Command blocks
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
Authors: Rolf, Workspace_AI Engine  
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
Authors: Rolf, Workspace_AI Governance  
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
   - External dependencies (such as `SharedModules` or `Workspace_Inventory`) `MUST` be represented strictly as prerequisite assertions and linkage steps without duplicating foreign repository code or internals.

---

### RULE-DOC-005: LCM Major Version Alignment Invariant (`M.Y.Z`)
Whenever a new major LCM version $M$ (e.g. `v6.0.0`, `v7.0.0`) is established and pushed:
1. **Major Parity**: All contained modules, specification documents, scripts, and configuration manifests `MUST` have their version updated such that their **Major** version component matches $M$.
2. **Subversion Preservation**: Subversions (**Minor** $Y$ and **Patch** $Z$) `MUST NOT` be reset or wiped by pre-push major version actions; their relative evolution history and component-level differentiation are strictly preserved.
3. **Transformation Formula**: If a module or spec has version $X.Y.Z$ and the new LCM major version is $M$, the new version becomes:
   $$\text{NewVersion} = M.Y.Z$$
   *(Example: A module at version `2.3.1` when major version 7 is established becomes `7.3.1`).*
4. **Baseline Synchronization**: All explicit global baseline references in configuration files (`.lcm/config.json`, `.vscode/settings.json`, `.github/agents/Config.json`), agent profiles, and DOX headers `MUST` reference the current active LCM baseline.

---

### RULE-DOC-006: Major Release Retention Horizon Policy & Evolution History Taxonomy
At the time of a major release push $M$ (e.g. `v6.0.0`, `v7.0.0`):
1. **2-Major-Release Retention Horizon ($M - 2$)**:
   - All transient operational logs (`tools/logs/*.log`, `Workspace_Inventory/logs/*.log`), temporary scratch dumps (`scratch/`), and legacy deletion trees (`Deletions/`) from major releases older than 2 major versions ($\le M - 2$) `MUST` be completely flushed.
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

---

<a id="subsystemgovernancepolicymd"></a>
## Rule #15: SubsystemGovernancePolicy.md
> **Category**: 4. Documentation & Subsystem Architecture | **Canonical Source**: `.agents/rules/SubsystemGovernancePolicy.md`

# File: SubsystemGovernancePolicy.md

Module: SubsystemGovernancePolicy  
Purpose: Governs disjunct Subsystem repositories (e.g. Home Assistant OS), dedicated subsystem inventories, JIT ephemeral write authentication, host hardware interlocks, and log segregation.  
Path: .agents/rules/SubsystemGovernancePolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 8.0.0  
Status: Authoritative Policy  
Date: 2026-09-26  

---

## 1. Scope & Motivation

A **Subsystem** represents an autonomous runtime or supervisory domain (e.g., `HaSSD06` running Home Assistant OS, or `Workspace_Supervision` operating continuous task telemetry and status observation) that has specialized operational lifecycles distinct from general scripting utilities. 

While Subsystems inherit standard LCM **documentation and quality gate rules**, their internal parts (integrations, devices, tasks, telemetry ledgers, entities) require domain-specific configuration management and elevated safety protocols.

---

## 2. Invariant Rules

### RULE-SUB-001: Subsystem Classification & Documentation Conformance
1. A repository classified as `subsystem` in `.lcm/config.json` `MUST` fully implement standard LCM **Tripartite Documentation** (`docs/Architecture.md`, `docs/Requirements.md`, `docs/Implementation.md`) and the universal runbook (`install/Installation.md`).
2. The root `Workspace_Inventory` tracks Subsystems at the macro Git level, while delegating internal part tracking to the Subsystem's dedicated inventory engine.

### RULE-SUB-002: Dedicated Subsystem Inventory Engine & Auto-Acceptance Invariant
1. Subsystems `MUST` maintain an independent internal inventory ledger at `data/subsystem_inventory.json` and a rendered summary at `docs/SUBSYSTEM_DASHBOARD.md`.
2. Dedicated audit tools (`tools/Update-<Subsystem>Inventory.ps1`) `SHALL` query domain-specific APIs or MCP services to reconcile active components without polluting the root host inventory.
3. **Direct Carry-Over from LCM (`RULE-EFF-001`)**: Routine Subsystem telemetry collection, entity dumps, and dashboard rendering constitute mechanical evidence and are **automatically accepted**. Telemetry synchronization runs `SHALL NOT` force manual review gates or block workflows on interactive diff sessions.

### RULE-SUB-003: Host-Side Hardware Safety Interlocks (Offline / Pre-Boot)
1. Any host script performing physical disk operations (flashing images, disk cloning, partition restructuring) `MUST NEVER` target arbitrary disk indices (e.g., `Disk 2`) without validating explicit **Hardware Serial Numbers** and **Model Descriptors** declared in `.lcm/config.json`.
2. Host tools `MUST` execute `Assert-DiskTargetSafety` to guarantee that active Windows `Boot`, `System`, or `PageFile` volumes are **never** targeted.
3. Destructive disk operations require high-integrity Administrator elevation and explicit operator confirmation.

### RULE-SUB-004: Safe Write Protocol & Just-In-Time (JIT) Ephemeral Authentication
1. **Dual-User Separation**: Subsystems `MUST` establish distinct service accounts:
   - **Auditor (Read-Only)**: Uses static credentials stored in git-ignored `.lcm/secrets.json` strictly for non-modifying telemetry and inventory queries.
   - **Operator (Write / Privileged)**: Authenticated strictly on-demand via **Just-In-Time (JIT) Ephemeral Sessions**.
2. **Zero Disk / Zero Log Persistence for Privileged Credentials**:
   - Write-mode passwords and tokens `MUST NOT` be stored in `.lcm/secrets.json`, configuration files, or logs.
   - Ephemeral session tokens generated from JIT authentication `SHALL` reside strictly in volatile memory (RAM) for the duration of the mutation batch (default 15–30 minutes) and be purged immediately upon completion.
3. **5-Stage Safe Mutation Pipeline**:
   - All state modifications `MUST` execute through the 5-stage pipeline: `(1) Pre-Flight State Snapshot` $\rightarrow$ `(2) Beyond Compare Visual Payload Gate` $\rightarrow$ `(3) Atomic API Dispatch` $\rightarrow$ `(4) Tiered Polling Health & Liveness Loop (up to 10m for Add-ons, up to 20m for Core, up to 30–45m for Host OS reboots / schema migrations)` $\rightarrow$ `(5) Automated Rollback on Failure`.

### RULE-SUB-005: Strict Log & Evidence Segregation
1. Host-level CM activities (`Workspace_Inventory/logs/cm_activity.log`) record only macro repository lifecycle milestones.
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
# version: 4.3.0

# MACRO-DEFINITIONS-METADATA
# scope: durable-memory
# location: .agents/rules/macro-definitions.md
# update-policy: manual

MACRO: @technical
- description: enforce strict technical, ascii-only, deterministic output
- rules:
  - no prose
  - no decoration
  - no emojis
  - no unicode
  - explicit structures only

MACRO: @user
- description: normal user-facing mode
- rules:
  - allow brief explanations
  - allow minimal formatting
  - keep responses concise

MACRO: @S
- description: system-aligned mode
- rules:
  - follow workspace rules
  - follow copilot profile
  - respect durable-memory files

MACRO: @profile status
- description: report current copilot profile state
- rules:
  - summarize durable-memory presence
  - summarize test-suite presence
  - summarize version alignment

MACRO: @tools
- description: display authoritative alphabetical index of LCM and HaSSD06 tools via Show-ToolIndex.ps1
- aliases: ShowTools, showtools, ShowToolsIndex, Show-ToolIndex, @tools, @t, @menu
- rules:
  - 'ShowTools' / 'showtools' / '@tools' / '@t' -> executes 'pwsh -File tools/Show-ToolIndex.ps1 -Audience User'
  - 'ShowTools dev' / 'showtools dev' / '@tools dev' -> executes 'pwsh -File tools/Show-ToolIndex.ps1 -Audience Dev'
  - 'ShowTools ha' / 'showtools ha' / '@tools ha' -> executes 'pwsh -File tools/Show-ToolIndex.ps1 -Group HaSSD06'
  - 'ShowTools lcm' / 'showtools lcm' / '@tools lcm' -> executes 'pwsh -File tools/Show-ToolIndex.ps1 -Group LCM'
  - 'ShowTools all' / 'showtools all' / '@tools all' -> executes 'pwsh -File tools/Show-ToolIndex.ps1 -Audience All'
  - supports -Filter <query> and -NoBrowser / -Cli

MACRO: @set-tool-audience
- description: update whether a tool is User-exposed or Developer-only
- rules:
  - execute 'pwsh -File tools/Set-ToolAudience.ps1 -ToolName <name> -Audience <User|Developer>'

MACRO: @log
- description: locate and open latest LCM log file and reveal full log history in File Explorer
- aliases: @log, @logs, @lastlog
- rules:
  - '@log' or '@logs' -> executes 'pwsh -File tools/Show-LastLog.ps1'
  - '@log <ToolName>' -> executes 'pwsh -File tools/Show-LastLog.ps1 -ToolName <ToolName>'

MACRO: @BCR
- description: launch Beyond Compare 5 visual review display for a repository against baseline commit
- aliases: BCR, @bcr, bcr
- rules:
  - 'BCR <repo>' or 'bcr <repo>' -> executes 'pwsh -File tools/Invoke-BeyondCompareReview.ps1 -RepositoryName <repo>'
  - 'BCR <repo> <commit>' -> executes 'pwsh -File tools/Invoke-BeyondCompareReview.ps1 -RepositoryName <repo> -BaseCommit <commit>'

MACRO: @ACCEPT
- description: submit review result as Accepted, close Beyond Compare review window, run quality gates, and commit
- aliases: ACCEPT, ACCEPTED, @accept, @accepted
- rules:
  - 'ACCEPT <repo>' or 'ACCEPT' -> executes 'pwsh -File tools/Submit-ReviewResult.ps1 -RepositoryPath <repo> -Result Accepted'
  - automatically closes matching Beyond Compare review window

MACRO: @tsr
- description: legacy timestamp header rule trigger (superseded by persistent TimestampHeaderRule per CRP-005)
- aliases: @tsr, @THR, @TRH, @IRA
- status: replaced / automated
- rules:
  - permanently codified in .agents/rules/InvariantRules.md
  - automatically active on every turn across all sessions without requiring manual invocation
  - format: YYYYMMDD_HHMM "<short-task-description>"

---

<a id="workspace-agentsmd-directive"></a>
## Rule #17: Root AGENTS.md Directive
> **Canonical Source**: `AGENTS.md` (Root Workspace Controller)

# Lifecycle Model (LCM) Multi-Repository Governance

This root container operates under the **Lifecycle Model (LCM)** architecture. All child repositories inherit governance policies from `.agents/rules/`.

> [!NOTE]
> **Comprehensive Rule Matrix**: For full cross-repository details, rule codes, enforcement scripts, and child repository junction mappings, see the authoritative [LCM Rules Cross-Reference Matrix](file:///Workspace_AI/docs/LCM-Rules-Cross-Reference.md).

---

## 1. Quick-Reference Rules Index Table

| Rule File | Rule Identifiers | Domain | Scope | Core Invariant |
|:---|:---|:---|:---|:---|
| **[ProposalReviewFlowPolicy.md](file:///.agents/rules/ProposalReviewFlowPolicy.md)** | `RULE-LCM-001` - `020` | **Proposal & Review Flow** | Workspace & Child Repos | Proposal-first intent, batch commands (`do`, `delete`, `defer`), Beyond Compare 5 review gate, dual-commit sync, Dual-State lifecycle, CM plan archive, Unconditional Plan Review Gate & Anti-Auto-Proceed Invariant (`RULE-LCM-014`), intake gates (`BUG:`, `CRP:`), directional `PROCEED ALL`, 2-attempt loop breaker, credit exhaustion guards, Active App Context (`Workon: A#`), multi-App problem gating, automated tripartite synthesis on `ACCEPT`, and Proposal Bundle Directory Architecture with Git Object Dual Lifecycle (`RULE-LCM-020`). |
| **[PowerShellStandardsPolicy.md](file:///.agents/rules/PowerShellStandardsPolicy.md)** | `RULE-PS-001` - `015` | **PowerShell Standards** | All `*.ps1`, `*.psm1`, `*.psd1` | StrictMode `@(...)` wrapping, Microsoft approved verbs (`Get-Verb`), colon-safe string interpolation, test elevation gating, header metadata & date maintenance, structured logging, `-h` help, interactive desktop dispatch routing, prohibition of bare inline `(if ...)`, `Import-Module -Name`, Smart Inheritance propagation, and variable string interpolation & colon boundaries. |
| **[ReviewCommitGovernancePolicy.md](file:///.agents/rules/ReviewCommitGovernancePolicy.md)** | `RULE-REV-001` - `008` | **Commit Gating & Review** | Governed Repos & Root | Mandatory review-gated commits (`ACCEPTED`), readiness quality gate pass, audit receipts in `Workspace_Inventory/data/reviews/`. |
| **[MethodEfficiencyPolicy.md](file:///.agents/rules/MethodEfficiencyPolicy.md)** | `RULE-EFF-001` - `008`, `RULE-ENV-003` | **Method Efficiency** | CM Telemetry & Evidence | Auto-acceptance of mechanical evidence, zero-test cascade on telemetry, short-circuit on quality gate failures, DOIT autonomous execution velocity, search dispatch routing (`Search-Everything.ps1`/`rg.exe`), tool catalog discovery, zero speculative relative pathing. |
| **[ElevationPolicy.md](file:///.agents/rules/ElevationPolicy.md)** | `RULE-ELEV-001` - `006` | **Security & Privileges** | Workspace-wide | Least-privilege execution default, elevated script runner delegation, auto-detection of privileged commands, elevated console non-auto-close invariant, and automated privilege-aware execution/elevation interception. |
| **[LanguagePolicy.md](file:///.agents/rules/LanguagePolicy.md)** | `LANGUAGE-POLICY` | **Localization & Naming** | Global Workspace | English-always invariant for code, comments, documentation, filenames, and commit messages. |
| **[RepositoryContextPolicy.md](file:///.agents/rules/RepositoryContextPolicy.md)** | `REPO-CONTEXT` | **Context Scoping** | Child Repositories | Strict repository boundary separation, deterministic relative path resolution, CM-only cross-repo writes. |
| **[InvariantRules.md](file:///.agents/rules/InvariantRules.md)** | `INVARIANT-RULES` | **Core Formatting & Output** | Workspace-wide | Determinism, reproducibility, ASCII default, 2-space indentation, CRLF newlines, UTF-8 without BOM. |
| **[PowerShellRules.md](file:///.agents/rules/PowerShellRules.md)** | `POWERSHELL-RULES` | **Scripting Standards** | PowerShell code | StrictMode Latest, `$ErrorActionPreference = 'Stop'`, explicit CmdletBinding. |
| **[CMDRules.md](file:///.agents/rules/CMDRules.md)** | `CMD-RULES` | **Windows Batch** | `*.cmd`, `*.bat` | Explicit echo control (`@echo off`), errorlevel verification, ASCII character sets. |
| **[JsonRules.md](file:///.agents/rules/JsonRules.md)** | `JSON-RULES` | **Data Serialization** | `*.json` | UTF-8 without BOM, 2-space indentation, `$schema` references. |
| **[PythonRules.md](file:///.agents/rules/PythonRules.md)** | `RULE-PY-001` - `008` | **Python Standards** | All `*.py` | No redundant f-strings (`F541`), strict import ordering, zero unused imports/variables (`F401`/`F841`), Windows UTF-8 stdout reconfiguration, template/JS interpolation safety. |
| **[DocumentationStandardsPolicy.md](file:///.agents/rules/DocumentationStandardsPolicy.md)** | `RULE-DOC-001` - `007` | **Documentation Standards** | All `*.md`, `docs/`, `install/` | Tripartite specifications (`Architecture.md`, `Requirements.md`, `Implementation.md`), universal `install/Installation.md` runbook, DOX metadata headers, `M.Y.Z` major parity, $M-2$ retention horizon, and App-Centric Modular Architecture (`App: #`) with Constituent Manifests & Contract Governance. |
| **[DisplayStandardsPolicy.md](file:///.agents/rules/DisplayStandardsPolicy.md)** | `RULE-DSP-001` - `008` | **HTML & UI Display Standards** | All HTML Viewers & Dashboards | Canonical CSS tokens (`StandardTableDisplay.css`), double-row sticky table headers, column filters, large sort/inspect indicators, theme persistence, and desktop dispatching. |
| **[SubsystemGovernancePolicy.md](file:///.agents/rules/SubsystemGovernancePolicy.md)** | `RULE-SUB-001` - `007` | **Subsystem Architecture** | Subsystem Repositories | Disjunct domains, dedicated subsystem inventories, JIT ephemeral tokens, host safety hardware interlocks, log segregation, Update-Gate & CRP bundling, central registry non-mutation invariant. |
| **[RuleAuthority.md](file:///.agents/rules/RuleAuthority.md)** | `RULE-AUTHORITY` | **Governance Hierarchy** | Core Governance | Single source of truth, no rule forking, machine-readable canonical rules in `.agents/rules/`. |
| **[macro-definitions.md](file:///.agents/rules/macro-definitions.md)** | `MACRO-DEFS` | **Operator Macros** | Interactive Shell | Shorthand activation macros: `@tsr` / `@THR` / `@IRA` (superseded by persistent `TimestampHeaderRule`), `@RULEAUTH`, `@ml`. |

---

## 2. Rule Discovery Architecture
- **Canonical Hub**: `Workspace_AI\.agents\rules\` (17 authoritative rule files; physical owner & primary commit gate).
- **Root & Child Discovery**: Root `D:\Git_Repositories\.agents\rules` links to `Workspace_AI\.agents\rules` via junction, eliminating root commit churn. Every governed child repository links `.agents/rules` directly to this hub, guaranteeing 100% rule discovery whether opening the workspace root or an individual repository folder.

---

## 3. Durable Memory & System Troubleshooting Context
- **Active Troubleshooting Thread**: Mouse focus/flicker investigation & background services isolation.
- **Logitech Suppression Status**: Audited against `KillLogitechUpdateFull.ps1` (54/54 items 100% enforced, 0 reversions).
- **Authoritative System Restore Tool**: [`tools/Restore-SystemSettings.ps1`](file:///D:/Git_Repositories/.lcm/tools/internal/Restore-SystemSettings.ps1).
- **Active Session State File**: [`.agents/ACTIVE_SESSION.md`](file:///D:/Git_Repositories/.agents/ACTIVE_SESSION.md).

---

<a id="workspace-geminimd-directive"></a>
## Rule #18: Root GEMINI.md Directive
> **Canonical Source**: `GEMINI.md` (Gemini Directive)

<!-- Governed by root LCM standard: D:\Git_Repositories\AGENTS.md -->
# GEMINI.md - LCM Governance Directive

This workspace is governed by the Lifecycle Model (LCM) framework.
See authoritative rules in `.agents/rules/`, [`AGENTS.md`](file:///AGENTS.md), and the [`LCM-Rules-Cross-Reference.md`](file:///Workspace_AI/docs/LCM-Rules-Cross-Reference.md).

