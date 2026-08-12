# Workspace_GC Real-Repository Dry-Run Cases

Module: real-repo-dry-run.md
Purpose: Describes inspectable Workspace_GC real-repository dry-run cases, flows, gates, and non-goals.
Path: D:/Git_Repositories/Workspace_GC/docs/real-repo-dry-run.md
Authors: Workspace_GC Engine
Version: 1.2.0
Changelog:
- 2026-08-02: Added read-only target-local proposal cleanup scanner.
- 2026-08-02: Added target-local method instance bootstrap command and policy.
- 2026-08-02: Added cleanup methodology for accepted and implemented target-local proposal files.
- 2026-08-02: Clarified target-local method instance ownership for repo dry-runs, logs, results, and proposals.
- 2026-08-02: Added target-local Markdown proposal authority for external intake and repo changes.
- 2026-08-02: Added repository lifecycle boundary cases and explicit cost-tiered integrity preflight policy.
- 2026-08-02: Clarified Workspace_GC-only incubation, candidate selection, override, rollback, and Accept-gate policy.
- 2026-08-01: Added bottom-up concrete change-request flow.
- 2026-08-01: Added realistic phased dry-run sequence with documentation-first discrepancy handling.
- 2026-08-01: Added adapter content-state comparison preview details.
- 2026-08-01: Added intended-action preview flow for near-end real-repository testing.
- 2026-08-01: Added first inspectable real-repository dry-run case documentation.

This document describes the current read-only dry-run model for applying Workspace_GC governance against a future real repository. It is intentionally not a write workflow. It documents the cases that are currently implemented and validated by the native readiness command.

## Current State

Workspace_GC is still the methodology incubation repository. Real-repository testing starts by selecting a repository that already exists under `D:\Git_Repositories`, but methodology evolution itself remains in Workspace_GC until further notice.

The normal readiness command is:

```powershell
.\tools/Test-WorkspaceGCReadiness.ps1
```

Default expected state before a candidate is selected:

```text
mode: not-selected
selected_repository: null
dry_run.enabled: false
dry_run.status: blocked-until-repository-selected
write_allowed: false
```

Current candidate policy:

```text
selected_repository: D:\Git_Repositories\VolumeInventory
dry_run.enabled: false in Workspace_GC
dry_run.status: ready-for-read-only-dry-run when the target-local method instance exists
action_preview.status: ready-read-only-action-preview when the target-local method instance exists
write_allowed: false
```

Nothing is copied to `D:\Git_Repositories` as a parent-level rule location. The real workspace is the repository set under `D:\Git_Repositories`; Workspace_GC remains the place where methodology changes are designed, validated, and accepted before any real repository is changed.

Workspace_GC may record the candidate identity, but it must not own the target repository's dry-run results, work logs, proposals, or repo-specific decisions. Those belong inside the target repository once its target-local method instance exists.

## Safety Rules

- Workspace_AC is off-limits.
- `B:\Backups\Base_WS_AC` is off-limits.
- Workspace_GC cannot select itself as a target.
- Selecting a repository does not enable writes.
- Selecting a repository records only the candidate in Workspace_GC.
- Dry-run mode for a real repository belongs to that repository's target-local method instance.
- Write enablement is not supported by the current transition policy.
- Target profiling performs no write probe.

The term `adapter surface` means a candidate file or entrypoint that a dry-run can compare, such as `.continuerules` or `tools/APPLY.ps1`. It does not mean those files are already active workspace rules and it does not authorize copying them anywhere.

Repo-local rules can override Workspace_GC only when they are confirmed as repository requirements, not merely incidental implementation details. That decision must be documented in the target repository before it is treated as an override.

The methodology does not require an internal rollback feature. Recovery is external to this workflow, normally by restoring the repository or system state; Macrium Reflect restores are expected to be possible and may create Git inconsistencies that must be handled afterward.

The promotion or advancement gate is a per-step user `Accept` decision for the current verification step. Bundled multi-step promotion is not the normal operating model.

## Target-Local Method Instance

Workspace_GC defines the method baseline. The target repository owns the application of that method.

For ordinary repositories, the target-local method instance uses:

```text
Docs/Methods/
Docs/Methods/DryRun/
Docs/Methods/Logs/
Docs/Methods/Results/
Docs/Methods/Proposals/
```

The target-local method instance is a structural override of the method baseline location. It is automatically accepted for candidate repositories because otherwise every target operation would store its work products at the wrong level.

Workspace_GC may hold generic rules, templates, validation logic, and the candidate identity. It must not store target-repo dry-run results, work logs, repo-specific proposals, or repo-specific verification results.

The bootstrap command for creating the target-local method instance is:

```powershell
.\tools/Initialize-RealRepoMethodInstance.ps1 -RepositoryPath "D:\Git_Repositories\VolumeInventory"
```

The bootstrap is allowed only after explicit operator approval. It may create the target-local method directories, a manifest, and local README files inside the target repository. It must not stage, commit, or write unrelated target files, and it must not move target-repo outputs back into Workspace_GC.

The old idea of enabling a real-repo dry-run by writing more state into Workspace_GC is transitional only. Future target work should first establish the target-local `Docs/Methods` method instance, then store dry-run state and results there.

## Repository Lifecycle Boundary Cases

Being located under `D:\Git_Repositories` is not enough to make a repository eligible for Workspace_GC operations. A repository can be discovered but blocked, selected as a candidate, placed in read-only dry-run, treated as external intake, considered for cleanup, governed after explicit acceptance, or retired.

Important lifecycle states:

```text
discovered-only          -> exists, no operation decision yet
blocked-do-not-operate   -> intentionally excluded from operation
candidate                -> selected, dry-run not enabled
read-only-dry-run        -> explicitly confirmed observation only
external-intake          -> create or populate structured repo, analyze, propose, then stop for review
cleanup-candidate        -> proposal-only cleanup assessment
active-governed          -> accepted per-step changes only
retired                  -> no longer operated on
```

Copied GitHub repositories or other working copies that must not be touched should be classified as `blocked-do-not-operate`. Discovery may list them, but governance, APPLY, adapter comparison, documentation discrepancy proposals, and cleanup must not operate on them until the state is changed by explicit decision.

External code import is its own flow. Outside code is evidence, not authority. Intake may create a new repository skeleton, add incoming `.ps1`, `.psm1`, or other code into the correct locations defined by Workspace rules, then analyze the code in that repository context.

External intake step 1 creates a proposal baseline, not a finished remediation. It should identify atoms, document them, identify functional problems such as code that will not work properly, create documentation proposals at the appropriate levels, create code or design change proposals, and then stop for review.

After review and `Accept`, later steps implement accepted documentation and code proposals, add or update tests, run verification, and iterate until final acceptance of tested and approved code.

Proposal placement is target-local:

```text
ordinary repo proposals: Docs/Methods/Proposals/**/*.md
method baseline proposals: .copilot/History/Logs/GC-Proposals.json
```

Normal repository proposal files are Markdown-first because they are human review artifacts. Proposal files may be grouped under `Docs/Methods/Proposals/` in review-cycle folders or other meaningful groupings.

Optional JSON sidecars are allowed only as derived automation artifacts. They are not reviewed, have no independent authority, and are valid only while they match the current reviewed state of the paired `.md` proposal. If the Markdown proposal is modified, rejected, split, merged, or superseded, the sidecar is stale until regenerated. A proposal may not be accepted based only on a JSON sidecar.

Workspace_GC does not store change proposals for ordinary target repos. The exception is when Workspace_GC itself is the method-baseline target; in that case the existing `tools/...` proposal mechanism is appropriate.

`Docs/Methods/Proposals` is a working review queue, not a permanent archive. A proposal remains there while it is pending review, rejected but intentionally retained for context, modified into a new review shape, or accepted but not yet implemented. Once an accepted proposal has led to the corresponding documentation or code changes and that implementation step is accepted, the proposal file is void and should be removed from the proposal directory.

Proposal cleanup is target-local housekeeping. Removing a void proposal file must not remove durable evidence such as method logs, dry-run results, verification results, commit history, or accepted governance records. The durable record moves to the implementation artifacts; the original proposal stops being authority once the accepted work exists.

The read-only cleanup scanner is:

```powershell
.\tools/Test-RealRepoProposalCleanup.ps1 -RepositoryPath "D:\Git_Repositories\VolumeInventory"
```

The scanner reports Markdown proposals that explicitly carry both `disposition: accepted` and an implemented marker such as `implementation_status: implemented`. It does not delete files. Deletion remains a target-local cleanup action that requires explicit acceptance.

Cleanup is also proposal-only until accepted. A cleanup assessment may propose keep, block, archive, move, or delete. Destructive actions require an explicit path, explicit action, and explicit `Accept` for the current step.

## Integrity Preflight Policy

Repository integrity preflight is explicit, event-triggered, and cost-tiered. During a continuous VS Code session, repository state is treated as stable unless a user statement, candidate change, cheap marker mismatch, or command failure indicates otherwise.

Workspace_GC must not perform hidden integrity scans, periodic background checks, or repo-wide checksums by default.

Preflight triggers:

```text
user requests integrity check
user reports restore, copy, import, or manual filesystem change
candidate selection changes
cheap marker mismatch from last known state
Git command failure during a requested operation
repository root, HEAD, or status inconsistency during requested dry-run
```

Cheap first-pass checks:

```text
repository path exists
.git exists
git rev-parse --show-toplevel
git rev-parse --abbrev-ref HEAD
git rev-parse HEAD
git status --short
```

Escalated checks are allowed only after a trigger or ambiguous cheap result, and Workspace_GC must report before using them:

```text
selected path timestamp comparison
limited checksum of known governance files
repo inventory snapshot
git fsck --no-dangling
full file checksum scan
```

Macrium or system restore events are out-of-band. Workspace_GC does not plan them. If their aftermath is detected, normal operations stop and the method reports a diagnostic or repair path; it does not auto-repair.

## Case 1: No Repository Selected

Purpose: prove that Workspace_GC can validate its dry-run machinery without inspecting any external repository.

Commands:

```powershell
.\tools/Get-RealRepoTestPlan.ps1
.\tools/Invoke-RealRepoDryRun.ps1
```

Expected result:

```text
DryRunStatus: blocked-until-repository-selected
TargetProfileStatus: blocked
GitStatusSummary: not-run
WriteProbePerformed: False
```

No external repository is inspected in this case.

## Case 2: Candidate Repository Selected

Purpose: record a candidate repository path while keeping dry-run disabled and write access impossible.

Command shape:

```powershell
.\tools/Set-RealRepoTestPlan.ps1 -RepositoryPath "D:\Git_Repositories\SomeRepo"
```

The first selected candidate is:

```text
D:\Git_Repositories\VolumeInventory
```

Selection is rejected if the path is Workspace_GC, Workspace_AC, the backup base, or not an existing Git repository.

Expected result after a valid selection:

```text
mode: candidate-selected
dry_run.enabled: false
dry_run.status: ready-for-read-only-dry-run when the target-local method instance exists
action_preview.status: ready-read-only-action-preview when the target-local method instance exists
write_allowed: false
```

## Case 3: Target-Local Read-Only Dry-Run Prepared

Purpose: prepare the target repository to own its own read-only dry-run state, logs, results, and proposals.

Target-local method root:

```text
Docs/Methods/
Docs/Methods/DryRun/
Docs/Methods/Logs/
Docs/Methods/Results/
Docs/Methods/Proposals/
```

Dry-run activation still requires explicit read-only confirmation, but the dry-run's repo-specific state and results must be target-local. Workspace_GC must not become the storage location for those target work products.

Allowed Git commands are limited to:

```text
git rev-parse --show-toplevel
git rev-parse --abbrev-ref HEAD
git rev-parse HEAD
git status --short
```

## Case 4: Target Profile Inventory

Purpose: inspect only the target repository state needed to plan a later adapter workflow.

Command:

```powershell
.\tools/Get-RealRepoTargetProfile.ps1
```

Read-only observations:

- repository path identity;
- Git repository root identity;
- current branch name;
- current HEAD commit id;
- working-tree status summary;
- presence or absence of expected Workspace_GC adapter surfaces.

Adapter surface candidates currently checked:

```text
.continuerules
.vscode/settings.json
.copilot/Rules/RuleAuthority.md
tools/APPLY.ps1
```

## Case 5: Clear Selection

Purpose: return the plan to the blocked self-stabilization state.

Command:

```powershell
.\tools/Set-RealRepoTestPlan.ps1 -ClearSelection
```

Expected result:

```text
mode: not-selected
selected_repository: null
dry_run.enabled: false
dry_run.status: blocked-until-repository-selected
write_allowed: false
```

## Case 6: Intended Action Preview

Purpose: show what Workspace_GC would intend to do in a later write-capable adaptation pass, without performing those actions now.

Command:

```powershell
.\tools/Get-RealRepoActionPlan.ps1
```

When no repository is selected, the action plan is blocked:

```text
Status: blocked
IntendedActionCount: 0
WriteAllowed: False
```

When a repository is selected and read-only dry-run is enabled, the action plan classifies each adapter surface as one of these preview-only actions:

```text
would-create-adapter-surface
would-update-adapter-surface
would-review-existing-adapter-surface
would-leave-target-unchanged
```

Each preview action compares the Workspace_GC source surface with the target repository surface using read-only SHA256 hashes. Comparison states are:

```text
target-missing
target-identical
target-different
source-missing
```

The action plan uses those states as follows:

```text
target-missing   -> would-create-adapter-surface
target-identical -> would-leave-target-unchanged
target-different -> would-update-adapter-surface
source-missing   -> would-review-existing-adapter-surface
```

The current adapter surfaces are:

```text
.continuerules
.vscode/settings.json
.copilot/Rules/RuleAuthority.md
tools/APPLY.ps1
```

Each intended action reports `WriteAllowedNow: False` and `RequiresFutureApproval: True`.

## Realistic Dry-Run Sequence

The first real-repository dry-run is phase-oriented. It does not jump directly to implementation or installation changes.

```text
phase-01-structure                  -> check repository structure against Workspace_GC workspace rules
phase-02-repo-specifications         -> read repository-local specifications and compare expectations
phase-03-level-map                   -> map docs, source, modules, implementation, discrepancies, installation
phase-04-documentation-discrepancies -> determine documentation-level content discrepancies only
phase-05-documentation-change-requests -> queue explicitly requested documentation-level changes
phase-06-later-implementation        -> defer source/module/implementation/install planning
```

The first actionable discrepancy scope is documentation-only. The dry-run should report documentation discrepancies up to that point before any source, module, implementation, or installation action is considered.

The action preview may show adapter-surface create/update/no-change classifications, but those remain preview-only and subordinate to the staged review sequence.

## Concrete Change Request Flow

A concrete change request is different from repository onboarding. It starts bottom-up from a requested requirement or implementation detail change. In this flow, documentation is expected to change because documentation must reflect the changed requirement.

Typical examples:

- functional requirement change;
- runtime logging rule change;
- JSON detail or structure change;
- implementation detail change;
- installer or execution contract change.

The preview phases are:

```text
cr-01-analyze-request             -> classify the concrete change request
cr-02-determine-impact            -> determine affected docs, source, modules, implementation, install behavior, tests, governance
cr-03-propose-doc-changes         -> propose required documentation changes first
cr-04-propose-code-changes        -> propose code/schema/module/script changes after documentation impact is clear
cr-05-apply-approved-doc-changes  -> documentation may change after explicit approval
cr-06-apply-approved-code-changes -> code changes may follow after documentation proposal review and approval
```

This flow is intentionally bottom-up. It does not treat existing documentation as immutable truth. The requested change can alter the requirement, and then documentation must be updated to express the new requirement before or together with approved implementation work.

Without approval, this flow is still preview-only. With approval, documentation changes are legitimate and expected.

## Non-Goals

- No target repository file edits.
- No target repository Git mutations.
- No generated adapter installation.
- No commit, reset, checkout, clean, merge, rebase, or stash in the target repository.
- No write-capable real-repository adaptation flow.
- No execution of intended actions from the action preview.
- No unapproved documentation or code changes from concrete change-request previews.
- No hidden integrity scans or periodic repository monitoring.
- No repo-wide checksums unless explicitly triggered and reported first.

Those require a later explicit design and user approval.

## Inspection Checklist

- Run the single readiness command and confirm it passes.
- Confirm `Real repository selected: False` until a target is explicitly chosen.
- Confirm `Real repository dry-run status: blocked-until-repository-selected` in self-stabilization.
- Confirm `Real repository dry-run status: ready-for-read-only-dry-run` after the selected target has a target-local method instance.
- Confirm `Real repository allowed Git commands: 4`.
- Confirm `Real repository action preview status: blocked-until-repository-selected` before target selection.
- Confirm `Real repository action preview status: ready-read-only-action-preview` after the selected target has a target-local method instance.
- Confirm `Real repository change-request orientation: bottom-up`.
- Confirm `WriteProbePerformed: False` in target profile output.