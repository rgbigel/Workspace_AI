# Workspace_AI Lifecycle Model Implementation and Tooling

Module: LCM-Proposal/Implementation-and-Tooling.md
Purpose: Maps proposed LCM requirements to the current Workspace_AI implementation, tools, controls, and evidence.
Path: docs/LCM-Proposal/Implementation-and-Tooling.md
Authors: Workspace_AI documentation proposal
Version: 0.1.0
Status: Proposal
Date: 2026-08-15

## 1. Status Vocabulary

| Status | Meaning |
|---|---|
| `Implemented` | An executable control or machine-validated state currently provides direct evidence. |
| `Partial` | Some control exists, but requirement coverage or evidence is incomplete. |
| `Policy only` | A document states the behavior, but no complete executable enforcement was identified. |
| `Not supported` | The current model intentionally blocks or does not implement the behavior. |
| `Conflict` | Current active-looking sources prescribe incompatible behavior or authority. |

Status describes the current repository, not the desired final state.

## 2. Current Architecture

```text
.copilot/Rules/              canonical rule declarations
.copilot/Atoms/              file-type and invariant building blocks
.copilot/Fixes/              structured fix modules and action descriptions
.copilot/History/Logs/       proposal registries and lifecycle state
.copilot/Logs/               governance execution logs
.github/agents/              agent discovery, workflow, and adapter policy
tools/                       PowerShell methods and public commands
tools/QualityGates/          reusable readiness assertions
docs/                        human-readable operational documentation
target/Docs/Methods/         target-local method instance and evidence
```

The intended control flow is:

```text
rules + state + target identity
  -> readiness and eligibility checks
  -> target-local method instance
  -> read-only profile/dry-run/action preview
  -> Markdown proposal and explicit review
  -> accepted implementation step
  -> focused verification + readiness
  -> durable result and proposal cleanup
```

The last three stages are specified by policy, but the current general real-repository tooling remains read-only.

## 3. Authority and Adapter Surfaces

| Artifact | Current role | Status | Notes |
|---|---|---|---|
| `.copilot/Rules/RuleAuthority.md` | Declares `.copilot/Rules`, `tools`, and `.copilot/Logs` as canonical governance locations. | Partial | Still names Workspace_AI and does not resolve the precedence conflict with Workspace-Rules. |
| `.github/agents/Workspace-Rules.md` | Declares workspace authority order and review constraints. | Conflict | Places itself above `.copilot` while RuleAuthority identifies `.copilot` as canonical. |
| `AGENTS.md` | Agent discovery entry point and operational summary. | Conflict | Declares `.copilot/Rules` canonical but links `.agents/rules`. |
| `.github/agents/WorkspaceAgentIndex.md` | Registry for active workspace agents. | Partial | Provides discovery, not canonical rule storage. |
| `.continuerules` and `.vscode/settings.json` | Continue/Gemini and VS Code adapter surfaces. | Partial | Must remain generated or referential; they are not independent authority. |
| `.copilot/instructions.md` | Command language, profiles, operators, memory model, and workspace path. | Partial | Active content still uses Workspace_AI identity and paths. |

Requirements covered: `LCM-REQ-001` through `LCM-REQ-004`, `LCM-REQ-071`.

## 4. Lifecycle State and Transition Controls

### Baseline State

`.copilot/History/Logs/Stabilization.json` records:

- current phase;
- real-repository testing enablement;
- external write permission;
- protected paths;
- sibling-repository discovery policy.

Current values identify `self-stabilization`, disable real-repository testing, and disable external writes.

### Candidate and Dry-Run State

`.copilot/History/Logs/RealRepoTestPlan.json` is the machine-readable candidate and dry-run plan. The related tools are:

| Tool | Responsibility | Mutation boundary |
|---|---|---|
| `tools/Get-WorkspaceRepositories.ps1` | Discover workspace repositories. | Read-only. |
| `tools/Set-RealRepoTestPlan.ps1` | Select or clear the candidate under policy guards. | Updates baseline candidate state only. |
| `tools/Get-RealRepoTestPlan.ps1` | Report current selection and dry-run status. | Read-only. |
| `tools/Initialize-RealRepoMethodInstance.ps1` | Create approved target-local `Docs/Methods` structure and manifest. | Target-local structural write after explicit approval. |
| `tools/Get-RealRepoTargetProfile.ps1` | Inspect repository identity, branch, HEAD, status, and adapter presence. | Read-only; no write probe. |
| `tools/Invoke-RealRepoDryRun.ps1` | Run observation-only dry-run checks. | Read-only. |
| `tools/Get-RealRepoActionPlan.ps1` | Compare adapter surfaces and classify intended future actions. | Preview only; reports writes as disallowed. |
| `tools/Test-RealRepoProposalCleanup.ps1` | Find accepted and implemented Markdown proposals eligible for cleanup. | Read-only scanner; never deletes. |

Current coverage:

| Requirement | Status | Evidence or gap |
|---|---|---|
| `LCM-REQ-010` | Policy only | States are defined in `docs/real-repo-dry-run.md`; a single state record for every discovered repository was not identified. |
| `LCM-REQ-011` | Partial | Candidate state is structured, but a uniform transition record with source, target, operator, reason, and preflight is not established. |
| `LCM-REQ-012` | Implemented | Stabilization and action-plan controls preserve `write_allowed: false`. |
| `LCM-REQ-013` | Policy only | Per-step acceptance is required in documentation; one end-to-end decision protocol is not defined. |

## 5. Method Baseline and Target-Local Instance

`docs/real-repo-dry-run.md` defines baseline/instance ownership. `tools/Initialize-RealRepoMethodInstance.ps1` provisions the target-local structure after approval.

The expected target-local root is:

```text
Docs/Methods/
  DryRun/
  Logs/
  Results/
  Proposals/
  MethodInstance.json
```

Target-local proposal authority is Markdown. JSON sidecars are derived and non-authoritative. `Docs/Methods/Proposals` is a working queue; logs, results, implementation artifacts, and Git history retain durable evidence after a void proposal is removed.

| Requirement | Status | Evidence or gap |
|---|---|---|
| `LCM-REQ-020` | Partial | Ownership is documented and initialization exists; complete prevention of baseline storage of target outputs depends on tool coverage. |
| `LCM-REQ-021` | Implemented | Initializer and readiness checks validate the target-local method structure. |
| `LCM-REQ-022` | Policy only | Markdown-first authority and sidecar rules are documented; automated stale-sidecar detection was not identified. |
| `LCM-REQ-023` | Partial | Cleanup scanner recognizes accepted/implemented proposals, but a complete disposition schema and decision protocol are not universal. |

## 6. Proposal, Fix, Atom, and Log Artifacts

### Method-Baseline Proposals

`.copilot/History/Logs/Proposals.json` stores method-baseline step proposals, reasons, affected files, dispositions, disposition reasons, and final results. It is appropriate when Workspace_AI itself is the target. It is not the proposal store for ordinary target repositories.

### Fix Modules

`.copilot/Fixes/Fix_*.json` describes structured fixes. A fix module identifies metadata, scope, required atoms/methods/rules, ordered actions, and logging behavior.

`tools/APPLY.ps1` is the execution surface for supported fix action types. APPLY validates dependencies and dispatches defined actions; it is not evidence that arbitrary repository writes are generally enabled.

### Atoms

`.copilot/Atoms/` contains reusable constraints for PowerShell, JSON, CMD, and invariants. Loader tools expose these definitions:

- `tools/LoadAtoms.ps1`
- `tools/LoadFixes.ps1`
- `tools/LoadMethods.ps1`
- `tools/LoadRules.ps1`

### Logs

The repository currently uses several evidence surfaces:

- `.copilot/History/Logs/S1.log` for step outcomes;
- `.copilot/History/Logs/S2.log` for governance markers;
- `.copilot/History/Logs/*.json` for structured state and proposal registries;
- `.copilot/Logs/Workspace.log` and related execution history;
- target-local `Docs/Methods/Logs` and `Docs/Methods/Results` for repository-specific work.

The coexistence of log locations needs an explicit retention and authority rule before `LCM-REQ-062` can be considered fully implemented.

## 7. Workflow Implementation

### Repository Onboarding Flow

The implemented and documented read-only sequence is:

```text
phase-01-structure
phase-02-repo-specifications
phase-03-level-map
phase-04-documentation-discrepancies
phase-05-documentation-change-requests
phase-06-later-implementation
```

The dry-run stops before implementation. Adapter comparisons classify future work as create, update, review, or unchanged by comparing source and target SHA256 hashes without performing the action.

### Concrete Change Request Flow

The documented sequence is:

```text
cr-01-analyze-request
cr-02-determine-impact
cr-03-propose-doc-changes
cr-04-propose-code-changes
cr-05-apply-approved-doc-changes
cr-06-apply-approved-code-changes
```

This sequence supports `LCM-REQ-030` but conflicts with older statements that agents must never modify documentation. Adoption requires one reconciled rule: approved documentation work is allowed only in a declared documentation or Reconciliation Phase.

Requirements `LCM-REQ-031` through `LCM-REQ-033` are primarily policy controls in `.github/agents/WORKFLOW.md`, `.github/agents/Workspace-Rules.md`, and `docs/real-repo-dry-run.md`.

## 8. Safety and Integrity Implementation

`docs/real-repo-dry-run.md` defines protected paths, prohibits selection of the baseline repository as its own target, prevents selection from enabling writes, and limits normal Git inspection to:

```text
git rev-parse --show-toplevel
git rev-parse --abbrev-ref HEAD
git rev-parse HEAD
git status --short
```

Escalated integrity checks are allowed only after a trigger or ambiguous cheap result and must be reported first. Hidden scans, periodic monitoring, write probes, and automatic restore repair are prohibited.

| Requirement | Status | Evidence or gap |
|---|---|---|
| `LCM-REQ-040` | Partial | Protected paths exist in stabilization policy and selection checks; complete blocking across every tool requires coverage verification. |
| `LCM-REQ-041` | Policy only | Cost tiers and triggers are documented; a unified preflight command and result schema were not identified. |
| `LCM-REQ-042` | Policy only | Prohibition is explicit; absence of hidden external behavior cannot be proven by documentation alone. |
| `LCM-REQ-043` | Policy only | External recovery is documented, with no internal rollback feature. |

## 9. Technical Standards and Loaders

| Source | Role |
|---|---|
| `.copilot/Rules/PowerShellRules.md` | PowerShell syntax, structure, encoding, error, and pipeline rules. |
| `.copilot/Rules/JsonRules.md` | JSON structure and deterministic formatting rules. |
| `.copilot/Rules/CMDRules.md` | CMD encoding, structure, and deterministic behavior. |
| `.copilot/Rules/InvariantRules.md` | Cross-format invariants. |
| `.copilot/Rules/macro-definitions.md` | Macro semantics and substitutions. |
| `docs/Standards.md` | Naming, metadata, documentation, and semantic-versioning summary. |
| `docs/version-bump-procedure.md` | Version increment procedure. |
| `docs/version-consistency-check.md` | Cross-control-file version parity expectations. |
| `tools/ValidateRules.ps1` | Rule validation entry point. |
| `tools/Validate-CopilotProfile.ps1` | Profile and command configuration validation. |

Current coverage for `LCM-REQ-050` through `LCM-REQ-053` is `Partial`: substantial rules and validators exist, but identity conflicts, path conflicts, and inconsistent metadata formats prevent a single proven conformance statement.

## 10. Readiness and Quality Gates

The public baseline readiness command is:

```powershell
.\tools\Test-WorkspaceReadiness.ps1
```

It imports `tools/QualityGates/WorkspaceQualityGates.psm1` and is the normal operator entry point. Reusable checks include ignored-repository policy, stabilization state, real-repository test-plan state, and stale authority references.

`tools/Advance-Governance.ps1` evaluates readiness for governance advancement, including proposal disposition, log separation, and target-local ownership constraints.

| Requirement | Status | Evidence or gap |
|---|---|---|
| `LCM-REQ-060` | Implemented | A single public readiness command exists and composes reusable gates. Its Workspace_AI name is a compatibility debt. |
| `LCM-REQ-061` | Partial | Before/after readiness is required, but focused target test selection remains operation-specific. |
| `LCM-REQ-062` | Partial | Multiple logs provide evidence, but one authoritative event schema and retention rule are not defined. |
| `LCM-REQ-063` | Not supported | This proposal is the first consolidated requirement-to-control matrix; controls do not yet carry requirement IDs. |
| `LCM-REQ-064` | Partial | Readiness failures block advancement; uniform failure output across all tools requires verification. |

## 11. Agent Tooling

`.github/agents/` supplies specialized interaction and policy surfaces:

| Agent or file | Intended responsibility |
|---|---|
| `Workspace-Rules.md` | Workspace-wide governance and review boundaries. |
| `WorkspaceAgentIndex.md` | Active agent registry. |
| `DOX.agent.md` | Explicitly approved documentation work. |
| `MIGRATION-Rules.md` | Migration-specific constraints. |
| `ATOM-Building.md` | Atom construction rules. |
| `DirectoryRules.md` | Repository and directory structure. |
| `SharedModulesRule.md` | Shared-module ownership and use. |
| `WORKFLOW.md` | Deterministic evaluation, proposal, and patch sequence. |
| `WorkspaceLog.agent.md` | Canonical governance logging behavior. |
| `WorkspaceLogHistory.agent.md` | Governance log history support. |

Agents are interaction and discovery surfaces. Their output is not sufficient evidence of conformance unless the required state, review decision, validation result, and durable log also exist.

## 12. Requirement-to-Control Summary

| Requirement group | Primary controls | Current status |
|---|---|---|
| `LCM-REQ-001` to `004` | RuleAuthority, Workspace-Rules, AGENTS, agent index | Conflict / Partial |
| `LCM-REQ-010` to `013` | stabilization state, real-repo test plan, dry-run documentation and tools | Implemented / Partial / Policy only |
| `LCM-REQ-020` to `023` | method initializer, target-local `Docs/Methods`, proposal cleanup scanner | Implemented / Partial / Policy only |
| `LCM-REQ-030` to `033` | WORKFLOW, concrete change-request flow, manual review | Policy only / Partial |
| `LCM-REQ-040` to `043` | protected paths, selection guards, integrity preflight policy | Partial / Policy only |
| `LCM-REQ-050` to `053` | canonical rules, atoms, validators, standards and version docs | Partial |
| `LCM-REQ-060` to `064` | readiness script, quality-gate module, governance advancement, logs | Implemented / Partial / Not supported |
| `LCM-REQ-070` to `072` | Workspace-Rules, DOX, proposal status, manual review | Policy only / Conflict |

## 13. Recommended Tooling Work After Adoption

The following work would close the largest documented gaps without enabling target writes:

1. Add a machine-readable LCM requirement registry keyed by the IDs in `Requirements.md`.
2. Add a validator that maps every active requirement to a control and verification method.
3. Resolve the authority order and validate that all mirrors identify canonical sources.
4. Add a Workspace_AI identity scan that classifies every Workspace_AI reference.
5. Define one acceptance-decision schema for proposal, implementation, verification, and cleanup steps.
6. Define one lifecycle-transition schema and validator.
7. Add stale Markdown/JSON sidecar detection.
8. Define authoritative log roles, event fields, retention, and target ownership.
9. Rename tools only through a compatibility plan that preserves existing callers.
10. Keep general target-repository writes unsupported until the write transition, recovery contract, and end-to-end tests are explicitly adopted.
