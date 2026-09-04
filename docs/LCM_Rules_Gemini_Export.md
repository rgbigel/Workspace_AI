# Lifecycle Model (LCM) Authoritative Governance Framework
> **Consolidated Master Specification for Gemini AI, Google Drive & Subagents**
> *Exported on: 2026-09-04 22:14:58 | Host: D5P0-SSD980-Z | Version: 1.2.0*

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
Version: 7.0.0  
Status: Authoritative Policy  
Date: 2026-08-29  

---

## 1. Governance Authority Invariants

### `RULE-AUTH-001` (Single Source of Truth & Zero Rule Forking)
- **Canonical Hub**: `D:\Git_Repositories\.agents\rules\` is the single, authoritative canonical root for all LCM governance rules.
- **Child Repositories**: All governed child repositories `MUST` link their local `.agents\rules` directory to the canonical hub via NTFS junction (`mklink /J`).
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
Version: 7.1.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-04  

---

## 1. Core Invariant Rules

### INVARIANT-RULES
- **determinism**: Identical input $\rightarrow$ identical output.
- **reproducibility**: No randomness or speculative inferences.
- **ascii-default**: ASCII required unless explicit exceptions apply:
  - Markdown (`.md`) files may contain Unicode (arrows, bullets, umlauts, typographic symbols).
  - PowerShell literal strings and comments may contain umlauts.
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

# Elevation & Privilege Governance Policy

- Rule ID: `RULE-ELEV-001` through `RULE-ELEV-005`
- Scope: Solution-Wide (All Repositories Governed by LCM v4.1.0)
- Classification: Invariant Rule
- Version: 7.0.0
- Updated: 2026-08-16

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

---

<a id="languagepolicymd"></a>
## Rule #4: LanguagePolicy.md
> **Category**: 1. Core Governance, Invariants & Security | **Canonical Source**: `.agents/rules/LanguagePolicy.md`

# File: LanguagePolicy.md

Module: LanguagePolicy
Purpose: Authoritative rule enforcing English language usage across all workspace documentation, file names, and code.
Path: .agents/rules/LanguagePolicy.md
Authors: Rolf
Version: 7.0.0
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
Version: 7.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-08-29  

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
Version: 7.2.0  
Status: Authoritative Policy  
Date: 2026-09-04  

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
- **Dual-Session Junction Review**: For repositories containing NTFS directory junctions (e.g. `.agents` pointing to `.lcm\.agents`, or `.agents\rules` pointing to `.lcm\.agents\rules`), `Invoke-BeyondCompareReview.ps1` `MUST` automatically dispatch a second Beyond Compare review session targeting the live junction destination on the right pane per `RULE-REV-008`.
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
   - **Governance Plan State (`state`)**: Document approval state (`bug`, `suggested`, `approved`, `deferred`, `rejected`, `completed`, `pushed`).
   - **Implementation Progress State (`progress_state`)**: Physical execution progress (`undecided`, `queued`, `in_progress`, `verification`, `completed`, `pushed`, `blocked`, `failed`).
2. **Initial Invariant**: Every newly submitted proposal and unapproved plan `MUST` initialize with `progress_state: "undecided"`.
3. **Pushed Lifecycle Transition**: Upon successful execution of `Invoke-WorkspacePush.ps1` (or CM Control Hub Push), proposals in `completed` state whose origin repository was pushed `MUST` transition to `pushed` (`pushed_at` timestamp recorded).
4. **Mandatory CM Plan & Walkthrough Archival**:
   - All Markdown implementation plans and execution walkthroughs `MUST` be persistently archived in the governed CM repository under:
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Plan.md`
     - `Workspace_Inventory/data/proposals/plans/Proposal-{ID:03d}_{CR_ID}_Walkthrough.md`
   - Explicit relative links `plan_path` and `walkthrough_path` `MUST` be recorded in `proposals.json`.

### RULE-LCM-008: Lightweight BUG Report & Error Feedback Invariant
1. **Default Lightweight Report on Negative Feedback**: Whenever the operator reports errors, unexpected script failures, broken dependencies, or unwanted agent behavior via prompts, chat, or backchannel inbox:
   - The agent `MUST NOT` immediately initiate a full-scale code rewrite or uncontrolled repository file mutations.
   - The agent `MUST` default to producing a concise **Lightweight BUG Report** containing:
     - **Issue Summary**: Clear description of the symptom or discrepancy.
     - **Superficial Root Cause**: Initial diagnostic hypothesis.
     - **Criticality Assessment**: Impact rating (`LOW`, `MEDIUM`, `HIGH`, `CRITICAL`).
     - **Affected Scope**: Target repository and affected modules.
     - **Proposed Remediation Plan**: High-level proposed fix strategy.
2. **Mandatory Operator Stop**: Upon emitting the Lightweight BUG Report, the agent `MUST STOP` and await explicit operator direction (`do <fix>`, `create CRP`, or alternate instructions) before executing code modifications.

### RULE-LCM-009: Scope and Version-Explicit CRP Naming Standard
1. **Canonical Filename Convention**: All Change Request Proposals (CRPs) `MUST` follow the standardized structure:
   `CRP-YYYY-NNN-[Scope]-[Version]-[DescriptiveSlug].md`
   - `[Scope]`: Affected repository/subsystem name (e.g. `Workspace_AI`, `Installation_LCD`, `SystemConfiguration`, `HaSSD06`), `LCM` for core governance, or `Multiple` for cross-cutting bundles.
   - `[Version]`: Target baseline or affected version horizon (e.g. `v7.0.0`, `v6.2.0`, `v1.0.0-v1.2.0`).
   - `[DescriptiveSlug]`: Kebab-case intent description.
2. **Mandatory Header Metadata**: Every CRP specification `MUST` include explicit metadata fields:
   - `Target Scope`: Explicit repository or subsystem boundary.
   - `Affected Version Range`: Semantic version or range.
   - `Impacted Repositories`: Array of modified repositories.

### RULE-LCM-010: Mandatory Self-Discovered Bug Registration Invariant
1. **Mandatory Self-Discovery Reporting**: Whenever the AI agent discovers a bug, syntax defect, unhandled runtime exception, parser failure, or regression in a permanent tool, platform script, shared module, or web UI during development, testing, or tool execution, the AI agent `MUST` formally register a Bug Report in `Workspace_Inventory/data/proposals/proposals.json` and generate an accompanying plan and walkthrough.
2. **Prohibition of Silent In-Place Hotfixing**: The AI agent `MUST NOT` silently patch defects in permanent tools without registering a formal BUG entry in the Configuration Management ledger.

### RULE-LCM-011: Scope and Version-Explicit Bug Report Naming Standard
1. **Canonical Bug Filename Convention**: All formal Bug Reports `MUST` follow the standardized structure:
   `BUG-YYYY-NNN-[Scope]-[Version]-[DescriptiveSlug].md`
   under `Workspace_Inventory/docs/Proposals/`.
2. **Mandatory Frontmatter Metadata**: Every Bug Report `MUST` include explicit frontmatter fields:
   - `Bug-ID`: Sequential unique identifier (e.g. `BUG-2026-001`).
   - `Scope`: Affected repository or subsystem boundary.
   - `Version`: Target release baseline (e.g. `v7.1.0`).
   - `Affected-Repos`: Array of modified repositories.
   - `Severity`: Impact assessment (`Low`, `Medium`, `High`, `Critical`).
   - `Status`: Lifecycle status (`Open`, `In-Progress`, `Completed`).
   - `Root-Cause`: Concise explanation of failure mechanics.

### RULE-LCM-012: Mandatory Scope-and-Version Explicit CRP Specification Generation Invariant
1. **Mandatory Standalone Specification**: Whenever proposing, designing, or implementing new features, tools, workflows, architectural enhancements, or governance policies, the AI agent `MUST` author a formal, standalone Scope-and-Version Explicit Change Request Proposal specification (`CRP-YYYY-NNN-[Scope]-[Version]-[DescriptiveSlug].md`) in `Workspace_Inventory/docs/Proposals/` before or alongside ledger registration.
2. **Prohibition of Orphan Feature Proposals**: Proposing or executing features or tool modifications without an authoritative, permanent `CRP-*.md` specification file in `Workspace_Inventory/docs/Proposals/` is strictly prohibited. Every non-bug feature proposal in `proposals.json` `MUST` link to a valid `bundle_id` matching an existing CRP document.

### RULE-LCM-013: Mandatory Pre-Push Gemini AI & Knowledge Base Synchronization Invariant
1. **Mandatory Automated Pre-Push Execution**: Every multi-repository push operation executed via `Invoke-WorkspacePush.ps1` (or 1-click UI triggers) `MUST` automatically execute the `Update-Gemini.ps1` pipeline prior to pushing commits to remote Git repositories.
2. **Context & Rules Mirroring Parity**: This guarantees that all 17 canonical LCM rules (`Workspace_AI/docs/LCM_Rules_Gemini_Export.md`), plain-text `.txt` mirrors, tool catalogs, and full workspace knowledge base exports (`D:\GDrive\LCM`) are 100% synchronized with the pushed Git baseline at the moment of remote dispatch.
3. **Automated Export Commit**: If the `Update-Gemini` pipeline updates the consolidated rules export in `Workspace_AI`, those changes `MUST` be staged and committed immediately before dispatching the push to `origin/main`.







### RULE-LCM-014: Implementation Plan Auto-Proceed Block Invariant
1. **Mandatory Stop on Open Questions**: Whenever an Implementation Plan (e.g., implementation_plan.md) is drafted and contains **Open Questions** requiring operator clarification, architectural feedback, or explicit decisions, the AI agent MUST NOT proceed to execution under any circumstances.
2. **Override of Auto-Approval**: Even if automated workspace review policies or system hooks attempt to automatically approve the artifact and trigger execution, the AI agent MUST explicitly halt, reject the auto-proceed, highlight the unresolved questions, and await a direct, human-authored response from the operator before executing any code modifications.

---

<a id="reviewcommitgovernancepolicymd"></a>
## Rule #7: ReviewCommitGovernancePolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/ReviewCommitGovernancePolicy.md`

# File: ReviewCommitGovernancePolicy.md

Module: ReviewCommitGovernancePolicy  
Purpose: Defines mandatory review-gated commit rules, review disposition handling, forced commit overrides, audit logging, and dual-session directory junction reviews.  
Path: .agents/rules/ReviewCommitGovernancePolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 7.1.0  
Status: Authoritative Policy  
Date: 2026-09-04  

---

## 1. Governance Rules

### RULE-REV-001: Mandatory Review-Gated Commits & Invariant Review Boundary
1. **Mandatory Visual Review Gate**: Every Git commit action for source code, configuration, tools, modules, or structural assets (`*.ps1`, `*.psm1`, `.vscode/settings.json`, `.lcm/*`, `docs/*`) in any LCM-governed repository requires a prior validated review disposition (`ACCEPTED` or `ACCEPTED_WITH_EDITS`) produced via the formal Beyond Compare 5 visual review gate (`Invoke-BeyondCompareReview.ps1`).
2. **Conversational Directives Do Not Waive Gating**: Explicit user instructions in chat (e.g. "yes, remove that", "fix this error") grant authority to execute file edits and staging, but **DO NOT waive the Beyond Compare visual review gate**. The agent `MUST` launch `Invoke-BeyondCompareReview.ps1` and await user review sign-off / folder clearance before executing `git commit` and `git push`.
3. **Exemption Scope**: Only purely mechanical telemetry artifacts defined in `RULE-EFF-001` (`inventory.json`, `INVENTORY_DASHBOARD.md`, `out/test_results.json`, and activity logs) are exempt from visual review gating.

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

### RULE-REV-006: Mandatory Review Stop & Turn Termination Invariant
1. **Mandatory Turn Termination**: Whenever an agent carries out a CRP or code modification reaching the visual review stage, the agent `MUST` launch `Invoke-BeyondCompareReview.ps1` and **immediately terminate the current response turn without making additional tool calls**.
2. **Prohibition of Same-Turn Submissions**: The agent `MUST NOT` invoke `Submit-ReviewResult.ps1`, stage files, or execute `git commit` within the same execution turn cycle as the review launcher.
3. **Discrete Operator Disposition Requirement**: Review dispositions (`ACCEPTED`, `ACCEPTED_WITH_EDITS`, `REJECTED`, `DEFERRED`) `SHALL ONLY` be consumed and processed when received as a discrete, independent message submitted by the operator in a subsequent turn.

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

### RULE-REV-008: Dual-Session Beyond Compare Review for Reparse Points & Directory Junctions (.agents)
1. **Mandatory Dual-Session Review**: Whenever `Invoke-BeyondCompareReview.ps1` (or `BCR`) is executed against any repository containing NTFS directory junctions (specifically `.agents` pointing to `.lcm\.agents`, or `.agents\rules` pointing to `.lcm\.agents\rules`), the review tool `MUST` automatically detect the junction and dispatch a second Beyond Compare review session.
2. **Junction Session Layout**:
   - **Left Pane (Baseline Snapshot)**: The extracted Git baseline directory corresponding to the junction (e.g. `<TempReviewRoot>\.agents` or `<TempReviewRoot>\.agents\rules`). If the directory does not exist in the baseline snapshot, the tool `MUST` initialize it.
   - **Right Pane (Live Junction Target)**: The resolved live junction destination on disk (e.g. `D:\Git_Repositories\.lcm\.agents` or `D:\Git_Repositories\.lcm\.agents\rules`).
3. **Session Persistence**: The second comparison `MUST` be registered in `BCSessions.xml` under `LCM_Review_<JunctionName>` and launched to Session 1 desktop via the interactive desktop dispatcher.
4. **Staging & Review Directives**: All review actions (Accept, Edit, Delete, Defer) applied in the second session `MUST` be tracked and integrated into the review audit manifest (`staged_review_<Repo>.json`).

---

<a id="methodefficiencypolicymd"></a>
## Rule #8: MethodEfficiencyPolicy.md
> **Category**: 2. Proposal, Review & Commit Lifecycle | **Canonical Source**: `.agents/rules/MethodEfficiencyPolicy.md`

# MethodEfficiencyPolicy

Module: MethodEfficiencyPolicy.md  
Purpose: Defines auto-acceptance, zero-test-trigger invariants, and method efficiency rules for generated inventory telemetry and logs.  
Path: .agents/rules/MethodEfficiencyPolicy.md  
Authors: Rolf, Workspace_AI Engine  
Version: 7.1.0  
Status: Authoritative Invariant Rule  
Date: 2026-09-03  

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

### RULE-EFF-004 (Agent Direct Execution & RR Review Gating Alignment)
AI pair-programming agents operating under the Lifecycle Model (LCM) `SHALL` execute tool operations, script commands, and file edits directly under `always-proceed` and `allow` policies without introducing interactive chat planning pauses or confirmation prompts. Formal review gating, safety verification, and user acceptance are strictly and exclusively enforced downstream at the Review Request / Beyond Compare (`RR.ps1` / `Invoke-BeyondCompareReview.ps1`) commit stage per `RULE-REV-001`.

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
Purpose: Defines mandatory PowerShell standards for strict mode resilience, verb compliance, string interpolation, pipeline hygiene, and testing across all repositories.  
Path: .agents/rules/PowerShellStandardsPolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 7.1.0  
Status: Authoritative Policy  
Date: 2026-09-03  

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
1. **Persistent Audit Logging**: Automatically write a timestamped log file to `D:\OneDrive\cmd\logs\` (or repository-specific `logs/` directory) with millisecond-precision timestamps (`yyyy-MM-dd HH:mm:ss.fff`).
2. **Structured Log Levels**: Classify every message using standard log levels: `[INFO]`, `[WARN]`, `[ERROR]`, `[DEBUG]`, `[ACTION]`, `[SUMMARY]` (converging on the `SharedModules/Logging` standard).
3. **Mandatory `[SUMMARY]` Footer**: Emit a standardized terminal and log summary block upon completion displaying:
   - Tool name
   - Version number
   - Execution status (`COMPLETED` / `FAILED`)
   - Exact log file path on disk
   - Execution timestamp
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

<a id="powershellrulesmd"></a>
## Rule #10: PowerShellRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PowerShellRules.md`

# File: PowerShellRules.md

Module: PowerShellRules
Purpose: Authoritative rules for PowerShell script generation and normalization.
Path: .copilot/Rules/PowerShellRules.md
Authors: Rolf
Version: 7.0.0
Changelog:
- 2026-07-27: Split unified rule file; clarified ASCII constraints; stabilized PS rules.

POWERSHELL-RULES
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
- location: .copilot/Rules/PowerShellRules.md

---

<a id="pythonrulesmd"></a>
## Rule #11: PythonRules.md
> **Category**: 3. Language & Coding Standards | **Canonical Source**: `.agents/rules/PythonRules.md`

# File: PythonRules.md

Module: PythonRules  
Purpose: Authoritative rule definitions for Python code quality, import ordering, string formatting, and linter compliance.  
Path: .agents/rules/PythonRules.md  
Authors: Rolf, Workspace_AI Engine  
Version: 7.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-08-29  

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
Version: 7.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-08-29  

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
Version: 7.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-08-29  

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
Version: 7.0.0  
Status: Authoritative Policy  
Date: 2026-08-29  

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

### RULE-DOC-003: DOX Metadata Header Invariant
Every Markdown document in `docs/` and `.agents/rules/` `MUST` begin with a standardized DOX metadata header:
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

<a id="subsystemgovernancepolicymd"></a>
## Rule #15: SubsystemGovernancePolicy.md
> **Category**: 4. Documentation & Subsystem Architecture | **Canonical Source**: `.agents/rules/SubsystemGovernancePolicy.md`

# File: SubsystemGovernancePolicy.md

Module: SubsystemGovernancePolicy  
Purpose: Governs disjunct Subsystem repositories (e.g. Home Assistant OS), dedicated subsystem inventories, JIT ephemeral write authentication, host hardware interlocks, and log segregation.  
Path: .agents/rules/SubsystemGovernancePolicy.md  
Authors: Rolf, Workspace_AI Governance  
Version: 7.0.0  
Status: Authoritative Policy  
Date: 2026-08-29  

---

## 1. Scope & Motivation

A **Subsystem** represents an autonomous runtime domain (e.g., `HaSSD06` running Home Assistant OS) that is disjunct from the host PC's multi-boot Windows environment. 

While Subsystems inherit standard LCM **documentation and quality gate rules**, their internal parts (integrations, devices, entities, add-ons) require domain-specific configuration management and elevated safety protocols.

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
# location: .copilot/Rules/macro-definitions.md
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
| **[ProposalReviewFlowPolicy.md](file:///.agents/rules/ProposalReviewFlowPolicy.md)** | `RULE-LCM-001` - `014` | **Proposal & Review Flow** | Workspace & Child Repos | Proposal-first intent, batch commands (`do`, `delete`, `defer`), Beyond Compare 5 review gate, dual-commit sync, Dual-State lifecycle, CM plan archive, and Auto-Proceed Block. |
| **[PowerShellStandardsPolicy.md](file:///.agents/rules/PowerShellStandardsPolicy.md)** | `RULE-PS-001` - `014` | **PowerShell Standards** | All `*.ps1`, `*.psm1`, `*.psd1` | StrictMode `@(...)` wrapping, Microsoft approved verbs (`Get-Verb`), colon-safe string interpolation, test elevation gating, header metadata & date maintenance, structured logging, `-h` help, interactive desktop dispatch routing, prohibition of bare inline `(if ...)`, `Import-Module -Name`, and Smart Inheritance propagation. |
| **[ReviewCommitGovernancePolicy.md](file:///.agents/rules/ReviewCommitGovernancePolicy.md)** | `RULE-REV-001` - `008` | **Commit Gating & Review** | Governed Repos & Root | Mandatory review-gated commits (`ACCEPTED`), readiness quality gate pass, audit receipts in `Workspace_Inventory/data/reviews/`. |
| **[MethodEfficiencyPolicy.md](file:///.agents/rules/MethodEfficiencyPolicy.md)** | `RULE-EFF-001` - `005` | **Method Efficiency** | CM Telemetry & Evidence | Auto-acceptance of mechanical evidence, zero-test cascade on telemetry, short-circuit on quality gate failures. |
| **[ElevationPolicy.md](file:///.agents/rules/ElevationPolicy.md)** | `RULE-ELEV-001` - `005` | **Security & Privileges** | Workspace-wide | Least-privilege execution default, elevated script runner delegation, auto-detection of privileged commands, and elevated console non-auto-close invariant. |
| **[LanguagePolicy.md](file:///.agents/rules/LanguagePolicy.md)** | `LANGUAGE-POLICY` | **Localization & Naming** | Global Workspace | English-always invariant for code, comments, documentation, filenames, and commit messages. |
| **[RepositoryContextPolicy.md](file:///.agents/rules/RepositoryContextPolicy.md)** | `REPO-CONTEXT` | **Context Scoping** | Child Repositories | Strict repository boundary separation, deterministic relative path resolution, CM-only cross-repo writes. |
| **[InvariantRules.md](file:///.agents/rules/InvariantRules.md)** | `INVARIANT-RULES` | **Core Formatting & Output** | Workspace-wide | Determinism, reproducibility, ASCII default, 2-space indentation, CRLF newlines, UTF-8 without BOM. |
| **[PowerShellRules.md](file:///.agents/rules/PowerShellRules.md)** | `POWERSHELL-RULES` | **Scripting Standards** | PowerShell code | StrictMode Latest, `$ErrorActionPreference = 'Stop'`, explicit CmdletBinding. |
| **[CMDRules.md](file:///.agents/rules/CMDRules.md)** | `CMD-RULES` | **Windows Batch** | `*.cmd`, `*.bat` | Explicit echo control (`@echo off`), errorlevel verification, ASCII character sets. |
| **[JsonRules.md](file:///.agents/rules/JsonRules.md)** | `JSON-RULES` | **Data Serialization** | `*.json` | UTF-8 without BOM, 2-space indentation, `$schema` references. |
| **[PythonRules.md](file:///.agents/rules/PythonRules.md)** | `RULE-PY-001` - `007` | **Python Standards** | All `*.py` | No redundant f-strings (`F541`), strict import ordering, zero unused imports/variables (`F401`/`F841`), Windows UTF-8 stdout reconfiguration. |
| **[DocumentationStandardsPolicy.md](file:///.agents/rules/DocumentationStandardsPolicy.md)** | `RULE-DOC-001` - `006` | **Documentation Standards** | All `*.md`, `docs/`, `install/` | Tripartite specifications (`Architecture.md`, `Requirements.md`, `Implementation.md`), universal `install/Installation.md` runbook, DOX metadata headers, `M.Y.Z` major parity, and $M-2$ retention horizon. |
| **[SubsystemGovernancePolicy.md](file:///.agents/rules/SubsystemGovernancePolicy.md)** | `RULE-SUB-001` - `006` | **Subsystem Architecture** | Subsystem Repositories | Disjunct domains, dedicated subsystem inventories, JIT ephemeral tokens, host safety hardware interlocks, log segregation, Update-Gate & CRP bundling. |
| **[RuleAuthority.md](file:///.agents/rules/RuleAuthority.md)** | `RULE-AUTHORITY` | **Governance Hierarchy** | Core Governance | Single source of truth, no rule forking, machine-readable canonical rules in `.agents/rules/`. |
| **[macro-definitions.md](file:///.agents/rules/macro-definitions.md)** | `MACRO-DEFS` | **Operator Macros** | Interactive Shell | Shorthand activation macros: `@tsr` / `@THR` / `@IRA` (superseded by persistent `TimestampHeaderRule`), `@RULEAUTH`, `@ml`. |

---

## 2. Rule Discovery Architecture
- **Canonical Hub**: `D:\Git_Repositories\.agents\rules\` (16 authoritative rule files).
- **Child Repositories**: Every governed repository links `.agents/rules` directly to the canonical root via NTFS junction, guaranteeing 100% rule discovery whether opening the workspace root or an individual repository folder.

---

## 3. Durable Memory & System Troubleshooting Context
- **Active Troubleshooting Thread**: Mouse focus/flicker investigation & background services isolation.
- **Logitech Suppression Status**: Audited against `KillLogitechUpdateFull.ps1` (54/54 items 100% enforced, 0 reversions).
- **Authoritative System Restore Tool**: [`tools/Restore-SystemSettings.ps1`](file:///D:/Git_Repositories/.tools/Restore-SystemSettings.ps1).
- **Active Session State File**: [`.agents/ACTIVE_SESSION.md`](file:///D:/Git_Repositories/.agents/ACTIVE_SESSION.md).

---

<a id="workspace-geminimd-directive"></a>
## Rule #18: Root GEMINI.md Directive
> **Canonical Source**: `GEMINI.md` (Gemini Directive)

<!-- Governed by root LCM standard: D:\Git_Repositories\AGENTS.md -->
# GEMINI.md - LCM Governance Directive

This workspace is governed by the Lifecycle Model (LCM) framework.
See authoritative rules in `.agents/rules/`, [`AGENTS.md`](file:///AGENTS.md), and the [`LCM-Rules-Cross-Reference.md`](file:///Workspace_AI/docs/LCM-Rules-Cross-Reference.md).

