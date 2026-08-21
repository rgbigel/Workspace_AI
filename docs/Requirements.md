# Workspace_AI Lifecycle Model (LCM) Normative Requirements

Module: docs/Requirements.md  
Authors: Rolf, Workspace_AI Engine  
Version: 5.0.2  
Status: Authoritative Standard  
Date: 2026-08-21  

---

## 1. Scope, Purpose & Conformance

This document specifies the normative requirements for the **Workspace_AI Lifecycle Model (LCM) Version 5.0.2**, governing `Workspace_AI`, `Workspace_Inventory`, and all component repositories within the multi-root solution workspace (`D:\Git_Repositories\`).

An operation or repository is LCM-conformant only when:
- All applicable `MUST` and `MUST NOT` normative constraints are satisfied.
- Every approved exception is explicit, scoped, reasoned, and documented in `.lcm/overrides.json`.
- System prerequisites are verified and active.
- Required verification evidence is captured and preserved.

---

## 2. System Prerequisites Requirements

### LCM-REQ-SYS-001 - Authoritative PowerShell Runtime
The LCM environment and all quality gates, onboarding tools, and CM automation `MUST` execute under **PowerShell 7 (`pwsh.exe` 7.0+)**. Execution under Windows PowerShell 5.1 is strictly non-conformant for automated operations.

### LCM-REQ-SYS-002 - Git Version Control
Every governed repository `MUST` be an initialized Git repository with an established `main` branch. Git tracking `MUST` be clean prior to executing state transitions or release baseline tags.

### LCM-REQ-SYS-003 - NTFS Filesystem & Link Support
The underlying host filesystem `MUST` be NTFS, supporting Directory Junctions (`mklink /J` or `New-Item -ItemType Junction`) and Hardlinks (`New-Item -ItemType HardLink`) for zero-duplication rule projection across sibling repositories.

### LCM-REQ-SYS-004 - Python Environment for Google Antigravity
The workspace container `MUST` provide a configured Python virtual environment (`.venv` Python 3.10+) equipped with Google Antigravity SDK (`google-antigravity`), CLI tools (`agy`), and dependencies to enable AI agent leasing, orchestration, and skill discovery.

### LCM-REQ-SYS-005 - Visual Differential & Review Tooling
The workstation `MUST` provide Beyond Compare 5 (`D:\Tools\Beyond Compare 5\BCompare.exe`) accessible via `Invoke-BeyondCompareReview.ps1` and `Submit-ReviewResult.ps1` (`RR.ps1`) to enable side-by-side historical diff reviews and formal acceptance recording without editor dependency.

---

## 3. Governance Authority & Precedence

### LCM-REQ-001 - Single Canonical Authority Root
[`Workspace_AI`](file:///D:/Git_Repositories/Workspace_AI) is the sole canonical authority root for LCM baseline rules, prompt instructions, quality gates, and standard repository templates. Target repository links `MUST` point back to `Workspace_AI` and `MUST NOT` become divergent independent authority.

### LCM-REQ-002 - Unambiguous Precedence Hierarchy
When rule sources overlap, the following strict authority order `MUST` govern:
1. Workspace-wide Invariants (`Workspace-Rules.md`, `LanguagePolicy.md`).
2. Authoritative Rules (`.agents/rules/` and `.copilot/Rules/` in `Workspace_AI`).
3. Repository-Local Explicit Overrides (`.lcm/overrides.json`).
4. Operational Instructions & Documentation.
5. Generated Adapters and Templates.

### LCM-REQ-003 - Stable Identity Standard
All active governance tools, logs, and templates `MUST` identify the baseline system as `Workspace_AI` (LCM v4.1.0). Legacy recovery prefixes (`Workspace_AC`, `Workspace_GC`) `MUST NOT` appear in active governance ledgers or filenames.

### LCM-REQ-004 - Repository-Local Overrides Standard
A repository `MAY` override standard baseline settings only via `.lcm/overrides.json`. Overrides `MUST` document the overridden rule, reason, scope, owner, and date.

### LCM-REQ-005 - Agent Skills Packaging Standard
Agent workflows and specialized capabilities `MUST` be packaged under `.agents/skills/<skill_name>/` containing a standard `SKILL.md` file with YAML frontmatter.

### LCM-REQ-006 - Working Directory Scratchpad Policy
The `Working/` directory in any repository is a temporary scratchpad. Files inside `Working/` `MUST NOT` be treated as authoritative governance requirements or quality gate prerequisites, but `MUST` maintain valid UTF-8 CRLF encoding.

---

## 4. Lifecycle State Model

### LCM-REQ-010 - Explicit Repository Classification
Every directory under `D:\Git_Repositories\` `MUST` be assigned an explicit classification by the Configuration Management system:
- `active-design-workshop`: `Workspace_AI` (incubation and baseline authority).
- `configuration-management`: `Workspace_Inventory` (inventory, auditing, and CR catalog).
- `lcm-governed`: Repositories with active LCM junctions and `.lcm/config.json`.
- `standard-git`: Git-initialized repositories pending LCM onboarding.
- `non-git`: Folders without `.git` (tracked under `git.ignoredRepositories`).
- `legacy-retired`: Archived baselines (`Workspace_AC`, `Workspace_GC`).
- `parent-infra`: Solution root infrastructure folders (`.agents`, `.copilot`, `.github`, `.venv`, `.vscode`).

### LCM-REQ-011 - Guarded State Transitions & CR-First Policy
Automated tools `MUST NOT` mutate repository files or force baseline updates without an explicit operator-approved Change Request. Calling update tools in default mode `MUST` create a Change Request proposal and execute a read-only dry-run simulation.

### LCM-REQ-012 - Explicit Approval for Write Operations
Applying an LCM upgrade or template refresh `MUST` require the explicit execution switch (`-Execute` / `-Force`), certifying operator review of the dry-run output.

---

## 5. Ownership, Change Requests & Artifact Placement

### LCM-REQ-020 - Baseline and Instance Separation
`Workspace_AI` `MUST` own generic rules, method definitions, templates, and validators. Each component repository `MUST` own its local `Docs/Methods/Proposals/`, `.lcm/config.json`, and `.lcm/overrides.json`.

### LCM-REQ-021 - 1-File-Per-CR Architecture
Monolithic multi-CR files are strictly forbidden. Every Change Request `MUST` be stored in its own dedicated Markdown document in `<TargetRepo>/Docs/Methods/Proposals/` with YAML frontmatter (`cr_id`, `title`, `status`, `target_lcm_version`, `bundle_id`, `author`, `created_at`).

### LCM-REQ-022 - LCM Timestamp Naming Standard
Change Request filenames and identifiers `MUST` follow the standard LCM timestamp format: `CR-yyyyMMdd_HHmmss.md` (e.g. `CR-20260815_231129.md`).

### LCM-REQ-023 - Change Request Bundles (Batch Test Suites)
Related Change Requests `MAY` be grouped into named test bundles under `Workspace_Inventory/data/bundles/` (e.g., `BUNDLE-2026-01`) to validate multiple micro-changes in a single test sequence and prevent test suite explosion.

---

## 6. Verification & Quality Gates

### LCM-REQ-030 - Quality Gate Self-Readiness
Before releasing an LCM baseline or bumping versions, `Workspace_AI` `MUST` pass [`Test-WorkspaceReadiness.ps1`](file:///D:/Git_Repositories/Workspace_AI/tools/Test-WorkspaceReadiness.ps1) with a full `OK` status across all governance rules, dry-run profiles, and integrity checks.

### LCM-REQ-031 - Target Repository Readiness
Every LCM-governed component repository `MUST` provide a local `tools/Test-RepoReadiness.ps1` script backed by `tools/QualityGates/RepoQualityGates.psm1` to verify local file integrity, JSON syntax, and junction health.

### LCM-REQ-032 - Continuous Drift Evaluation
The CM engine `MUST` continuously monitor for configuration drift, flagging dirty working copies, outdated LCM versions, unpushed commits, and broken junctions.

### LCM-REQ-033 - Privilege & Elevation Governance
Every LCM-governed repository `MUST` declare an explicit `execution_context` block inside `.lcm/config.json` defining `elevation_required`, `minimum_privilege`, and `reason` (enforcing `RULE-ELEV-001`). Repositories requiring Administrator elevation `MUST` provide `tools/Invoke-ElevatedTest.ps1` for automated elevated test handoff.

### LCM-REQ-034 - Bi-directional Elevation Consistency Gate
The local readiness quality gate `MUST` execute `Assert-RepoElevationConsistency`. The gate `MUST` fail if privileged or self-elevating code is detected in `src/` without matching `elevation_required: true` in `.lcm/config.json`, or if `elevation_required: true` is configured but `tools/Invoke-ElevatedTest.ps1` is missing.

### LCM-REQ-035 - Documentation Fabric & Prerequisites Quality Gate
The local readiness quality gate `MUST` execute `Assert-RepoDocumentationFabric`. The gate `MUST` assert that:
1. Top-level `README.md` exists and contains an explicit `## System Prerequisites` section.
2. `docs/README.md` documentation directory index exists.
3. `.github/agents/RepoAgentIndex.md` agent discovery index is instantiated and valid.

### LCM-REQ-036 - Method Efficiency & Auto-Accepted Telemetry
Mechanically generated audit records, inventory databases (`data/inventory.json`), CM dashboards (`INVENTORY_DASHBOARD.md`), baseline snapshots (`data/baselines/*.json`), test evidence (`out/test_results.json`), and governance logs `MUST` be automatically accepted without manual review gates and `MUST NEVER` trigger cascade testing or validation cycles (enforcing `RULE-EFF-001` through `RULE-EFF-003`).

### LCM-REQ-037 - Visual Comparison & Review Result (RR) Subsystem
1. **Isolated Differential Environment**: The Configuration Management system `MUST` provide integrated visual differential tooling (`Invoke-BeyondCompareReview.ps1` / Beyond Compare 5) comparing read-only baseline snapshots in `%TEMP%\BC_Review\<RepoName>-<SHA>\` against the live repository.
2. **Review Result Recorder**: The system `MUST` provide a standardized Review Result recorder (`Submit-ReviewResult.ps1` / `RR.ps1`) supporting formal disposition recording (`Accepted`, `AcceptedWithEdits`, `Rejected`, `Deferred`) with automated quality gate execution and CM audit logging.
3. **Session Metadata Token**: Every review session `MUST` generate an immutable `.lcm_review.json` record containing `SessionStartedAt`, `BaseCommit`, `CommitDate`, and `RepositoryName`.
4. **Session Folder Removal Consent**: Removal of a specific repository review session folder in `%TEMP%\BC_Review\` by the operator `MUST` be recognized as an explicit user consent and review completion signal.
5. **Right-Side Modification Detection**: If the operator modifies and saves files directly on the Right-Hand Side (live repository) during a review session, the system `MUST` detect the difference, classify the disposition as `AcceptedWithEdits`, and automatically execute all local repository readiness quality gates (`Test-RepoReadiness.ps1`) prior to staging the commit.
6. **Maintenance Exemption**: Blanket maintenance operations (`Clear-BCReviewTemp.ps1 -All`) `MUST NOT` be interpreted as review consent or trigger Git commits.

### LCM-REQ-038 - Review-Gated Commit & Override Authority
1. **Mandatory Review Gate**: Every Git commit action for source code, configuration, or structural assets in any LCM-governed repository `MUST` have a validated prior `ACCEPTED` or `ACCEPTED_WITH_EDITS` review disposition.
2. **Accepted with Edits Invariant**: Review outcomes of `Accepted with Edits` `MUST` satisfy all repository quality gates (`Test-RepoReadiness.ps1`) before committing; upon passing, the state is committed as fully `ACCEPTED`.
3. **Override Authority**: Committing or pushing changes in a `REJECTED` or `DEFERRED` state `IS STRICTLY FORBIDDEN` unless explicitly commanded by the user with a forced override instruction.
4. **Precedence**: These review rules take strict precedence over any default "all commands are permitted" policies (enforcing `RULE-REV-001` through `RULE-REV-005`).
5. **Universal Traceability**: All review dispositions `MUST` be logged in `logs/cm_activity.log` and structured in `data/reviews/REVIEW-*.json`.

### LCM-REQ-039 - Tripartite Documentation Specification
Every governed repository `MUST` provide distinct, decoupled specifications adhering to the tripartite documentation standard:
1. `docs/Architecture.md`: User-facing mental model, conceptual workflows, and system topology (`RULE-DOC-001`).
2. `docs/Requirements.md`: Normative technical constraints, requirements, and acceptance criteria (`RULE-DOC-002`).
3. `docs/Implementation.md`: Concrete realization in code, exported cmdlets/modules, schemas, and traceability (`RULE-DOC-003`).
4. `docs/README.md`: Component summary & index linking the tripartite specifications.

### LCM-REQ-040 - Universal Installation Runbook Standard
Every governed repository `MUST` provide an `install/` directory containing `Installation.md`:
1. **Runbook Scope**: Procedural runbook detailing prerequisites, customization, installation steps, readiness verification tests, and version upgrade procedures.
2. **Structural Invariant**: `Installation.md` is unified and `MUST NOT` be split into tripartite parts. Complex installations may be divided into supporting markdown documents residing strictly within the `install/` directory.
3. **Cross-Repository References**: Dependencies on shared components (e.g. `SharedModules`) `MUST` be referenced with their specific prerequisite requirements and installation steps.
