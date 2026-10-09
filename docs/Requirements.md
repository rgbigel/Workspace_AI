# LCM_AI Lifecycle Model (LCM) Normative Requirements

ModulePath: docs/Requirements.md  
Authors: Rolf, LCM_AI Engine  
Version: 8.0.0  
Status: Authoritative Requirements  
Date: 2026-09-19  

---

## 1. Scope & Governance Authority

This document specifies the normative requirements for the **LCM_AI Lifecycle Model (LCM) Version 7.0.0**, governing `LCM_AI`, `LCM_Inventory`, and all component repositories within the multi-root solution workspace (`D:\Git_Repositories\`).

An operation or repository is LCM-conformant only when:
- All applicable `MUST` and `MUST NOT` normative constraints are satisfied.
- Every approved exception is explicit, scoped, reasoned, and documented in `LCM_Inventory/overrides.json`.
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
[`LCM_AI`](file:///D:/Git_Repositories/LCM_AI) is the sole canonical authority root for LCM baseline rules, prompt instructions, quality gates, and standard repository templates. Target repository links `MUST` point back to `LCM_AI` and `MUST NOT` become divergent independent authority.

### LCM-REQ-002 - Unambiguous Precedence Hierarchy
When rule sources overlap, the following strict authority order `MUST` govern:
1. Repository-local executable behavior and configuration.
2. The authoritative rules in `LCM_AI\.agents\rules\`.
3. Root `AGENTS.md` and repository-local `AGENTS.md`.
4. Repository-local explicit overrides (`LCM_Inventory/overrides.json`) where present.
5. Operational instructions and documentation.

### LCM-REQ-003 - Stable Identity Standard
All active governance tools, logs, and templates `MUST` identify the baseline system as `LCM_AI` (LCM v7.0.0). Legacy recovery prefixes (`Workspace_AC`, `Workspace_GC`) `MUST NOT` appear in active governance ledgers or filenames.

### LCM-REQ-004 - Repository-Local Overrides Standard
A repository `MAY` override standard baseline settings only via `LCM_Inventory/overrides.json`. Overrides `MUST` document the overridden rule, reason, scope, owner, and date.

### LCM-REQ-005 - Agent Skills Packaging Standard
Agent workflows and specialized capabilities `MUST` be packaged under `.agents/skills/<skill_name>/` containing a standard `SKILL.md` file with YAML frontmatter.

### LCM-REQ-006 - Working Directory Scratchpad Policy
The `Working/` directory in any repository is a temporary scratchpad. Files inside `Working/` `MUST NOT` be treated as authoritative governance requirements or quality gate prerequisites, but `MUST` maintain valid UTF-8 CRLF encoding.

---

## 4. Lifecycle State Model

### LCM-REQ-010 - Explicit Repository Classification
Every directory under `D:\Git_Repositories\` `MUST` be assigned an explicit classification by the Configuration Management system:
- `active-design-workshop`: `LCM_AI` (incubation and baseline authority).
- `configuration-management`: `LCM_Inventory` (inventory, auditing, and CR catalog).
- `lcm-governed`: Repositories with active LCM junctions and `LCM_Inventory/config.json`.
- `standard-git`: Git-initialized repositories pending LCM onboarding.
- `non-git`: Folders without `.git` (tracked under `git.ignoredRepositories`).
- `legacy-retired`: Historical material explicitly classified as archival; it is outside the active LCM-root topology.
- `parent-infra`: Solution root infrastructure folders (`.agents`, `.copilot`, `.github`, `.venv`, `.vscode`).

### LCM-REQ-011 - Guarded State Transitions & CR-First Policy
Automated tools `MUST NOT` mutate repository files or force baseline updates without an explicit operator-approved Change Request. Calling update tools in default mode `MUST` create a Change Request proposal and execute a read-only dry-run simulation.

### LCM-REQ-012 - Explicit Approval for Write Operations
Applying an LCM upgrade or template refresh `MUST` require the explicit execution switch (`-Execute` / `-Force`), certifying operator review of the dry-run output.

---

## 5. Ownership, Change Requests & Artifact Placement

### LCM-REQ-020 - Baseline and Instance Separation
`LCM_AI` `MUST` own generic rules, method definitions, templates, and validators. Each component repository `MUST` own its local `Docs/Methods/Proposals/`, `LCM_Inventory/config.json`, and `LCM_Inventory/overrides.json`.

### LCM-REQ-021 - 1-File-Per-CR Architecture
Monolithic multi-CR files are strictly forbidden. Every Change Request `MUST` be stored in its own dedicated Markdown document in `<TargetRepo>/Docs/Methods/Proposals/` with YAML frontmatter (`cr_id`, `title`, `status`, `target_lcm_version`, `bundle_id`, `author`, `created_at`).

### LCM-REQ-022 - LCM Timestamp Naming Standard
Change Request filenames and identifiers `MUST` follow the standard LCM timestamp format: `CR-yyyyMMdd_HHmmss.md` (e.g. `CR-20260815_231129.md`).

### LCM-REQ-023 - Change Request Bundles (Batch Test Suites)
Related Change Requests `MAY` be grouped into named test bundles under `LCM_Inventory/data/bundles/` (e.g., `BUNDLE-2026-01`) to validate multiple micro-changes in a single test sequence and prevent test suite explosion.

---

## 6. Verification & Quality Gates

### LCM-REQ-030 - Quality Gate Self-Readiness
Before releasing an LCM baseline or bumping versions, `LCM_AI` `MUST` pass [`Test-WorkspaceReadiness.ps1`](file:///D:/Git_Repositories/LCM_Inventory/tools/Test-WorkspaceReadiness.ps1) with a full `OK` status across all governance rules, dry-run profiles, and integrity checks.

### LCM-REQ-031 - Target Repository Readiness
Every LCM-governed component repository `MUST` provide a local `tools/Test-RepoReadiness.ps1` script backed by `tools/QualityGates/RepoQualityGates.psm1` to verify local file integrity, JSON syntax, and junction health.

### LCM-REQ-032 - Continuous Drift Evaluation
The CM engine `MUST` continuously monitor for configuration drift, flagging dirty working copies, outdated LCM versions, unpushed commits, and broken junctions.

### LCM-REQ-033 - Privilege & Elevation Governance
Every LCM-governed repository `MUST` declare an explicit `execution_context` block inside `LCM_Inventory/config.json` defining `elevation_required`, `minimum_privilege`, and `reason` (enforcing `RULE-ELEV-001`). Repositories requiring Administrator elevation `MUST` provide `tools/Invoke-ElevatedTest.ps1` for automated elevated test handoff.

### LCM-REQ-034 - Bi-directional Elevation Consistency Gate
The local readiness quality gate `MUST` execute `Assert-RepoElevationConsistency`. The gate `MUST` fail if privileged or self-elevating code is detected in `src/` without matching `elevation_required: true` in `LCM_Inventory/config.json`, or if `elevation_required: true` is configured but `tools/Invoke-ElevatedTest.ps1` is missing.

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
3. **Cross-Repository References**: Dependencies on shared components (e.g. `LCM_Shared`) `MUST` be referenced with their specific prerequisite requirements and installation steps.

### LCM-REQ-041 - Review Scope and Documentation Reconciliation
1. Beyond Compare filters `MUST` govern visual review materiality only; they
	`MUST NOT` classify tracked operational records as invalid or unreviewed
	source solely because they are filtered from a review view.
2. Proposal ledgers and activity logs `MUST` be treated as append-oriented
	operational evidence. Routine lifecycle bookkeeping `MUST NOT` require the
	same visual review treatment as permanent source or architecture documents.
3. Proposal bundles and review walkthroughs `MAY` retain provisional knowledge
	during incremental delivery. That knowledge `MUST` be reconciled into the
	authoritative methodology after meaningful delivery or at release closure,
	no later than a major-version push.
4. Retention and cleanup of historical operational records `MUST` preserve the
	distinction between maintenance and history rewriting.

### Proposed LCM-REQ-042 - Control Hub Facet and Priority Contract
In the proposed target state, the Control Hub `MUST` display separate `Status`,
`Plan State`, and `Progress Status` facets. It `MUST` show busy and failure
indicators without adding lifecycle states, expose the effective execution
switches, and record those values with each execution run. Priority `MUST` be
an integer from $0$ through $10$, with $10$ highest. Technical ordering within
an equal-priority cohort `MAY` advise the operator but `MUST NOT` override the
operator-selected sequence.

### Proposed LCM-REQ-043 - Review Decision and Snapshot Contract
In the proposed target state, `Review Decision` `MUST` be the operator-facing
review checkpoint. `Publish` `MUST` be the visible action and `PUSH` `MUST`
remain a compatible command alias. Each accepted review decision `MUST` append
an immutable, CRP-specific snapshot of the reviewed right-hand state that may
serve only as a BCompare left-side candidate and `MUST NOT` alter the live
right-hand working tree. A final pushed-baseline-to-live roll-up review `MUST`
occur before local commit regardless of intermediate snapshots.

### Proposed LCM-REQ-044 - Scoped Post-Commit BCR Cleanup
In the proposed target state, BCR cleanup `MUST` run only after a successful
local commit is recorded and only for an explicit proposal or bug and
repository. It `MUST` support preview, verify ownership, preserve unrelated
sessions and artifacts, and record cleanup failures without reversing commit
or publication state.

### Proposed LCM-REQ-045 - Query Index Scenario Contract
In the proposed target state, LCM Query Index scenarios `MUST` define inputs,
expected artifacts, provider selection, fallback reason, provenance, and result
contract. Eligible discovery `MUST` prefer `es.exe`; it `MUST` fall back to
`rg` when indexed content, query semantics, or availability is insufficient.
Direct NTFS records `MUST` remain authoritative.

<!-- FixDocumentation: CRP-196 Requirements -->
### REQ-LCM-196: Scoped Documentation Reconciliation

Documentation reconciliation MUST resolve repository-qualified payloads from
the selected CRP/BUG scope. It MUST reject missing scope, ambiguous payloads,
and competing updates for the same repository/document pair; it MUST NOT infer
delivery knowledge from unrelated work.
<!-- /FixDocumentation -->
