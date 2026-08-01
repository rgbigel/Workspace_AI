# Workspace_GC Real-Repository Dry-Run Cases

Module: real-repo-dry-run.md
Purpose: Describes inspectable Workspace_GC real-repository dry-run cases, flows, gates, and non-goals.
Path: D:/Git_Repositories/Workspace_GC/docs/real-repo-dry-run.md
Authors: Workspace_GC Engine
Version: 0.5.0
Changelog:
- 2026-08-01: Added bottom-up concrete change-request flow.
- 2026-08-01: Added realistic phased dry-run sequence with documentation-first discrepancy handling.
- 2026-08-01: Added adapter content-state comparison preview details.
- 2026-08-01: Added intended-action preview flow for near-end real-repository testing.
- 2026-08-01: Added first inspectable real-repository dry-run case documentation.

This document describes the current read-only dry-run model for applying Workspace_GC governance against a future real repository. It is intentionally not a write workflow. It documents the cases that are currently implemented and validated by the native readiness command.

## Current State

Workspace_GC is still in self-stabilization. Real-repository testing is disabled, no repository is selected, and write access is unsupported.

The normal readiness command is:

```powershell
.\.copilot\Methods\Test-WorkspaceGCReadiness.ps1
```

Current expected state:

```text
mode: not-selected
selected_repository: null
dry_run.enabled: false
dry_run.status: blocked-until-repository-selected
write_allowed: false
```

## Safety Rules

- Workspace_AC is off-limits.
- `B:\Backups\Base_WS_AC` is off-limits.
- Workspace_GC cannot select itself as a target.
- Selecting a repository does not enable writes.
- Dry-run mode requires explicit read-only confirmation.
- Write enablement is not supported by the current transition policy.
- Target profiling performs no write probe.

## Case 1: No Repository Selected

Purpose: prove that Workspace_GC can validate its dry-run machinery without inspecting any external repository.

Commands:

```powershell
.\.copilot\Methods\Get-RealRepoTestPlan.ps1
.\.copilot\Methods\Invoke-RealRepoDryRun.ps1
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
.\.copilot\Methods\Set-RealRepoTestPlan.ps1 -RepositoryPath "D:\Git_Repositories\SomeRepo"
```

Selection is rejected if the path is Workspace_GC, Workspace_AC, the backup base, or not an existing Git repository.

Expected result after a valid selection:

```text
mode: candidate-selected
dry_run.enabled: false
dry_run.status: blocked-until-dry-run-enabled
write_allowed: false
```

## Case 3: Read-Only Dry-Run Enabled

Purpose: allow read-only metadata collection from the selected target repository.

Command shape:

```powershell
.\.copilot\Methods\Set-RealRepoTestPlan.ps1 -EnableDryRun -ConfirmReadOnlyDryRun
.\.copilot\Methods\Invoke-RealRepoDryRun.ps1
```

Dry-run activation requires `-ConfirmReadOnlyDryRun`. The command still keeps `write_allowed` false.

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
.\.copilot\Methods\Get-RealRepoTargetProfile.ps1
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
.continue/rules/Workspace_GC.md
.copilot/Rules/RuleAuthority.md
.copilot/Methods/APPLY.ps1
```

## Case 5: Clear Selection

Purpose: return the plan to the blocked self-stabilization state.

Command:

```powershell
.\.copilot\Methods\Set-RealRepoTestPlan.ps1 -ClearSelection
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
.\.copilot\Methods\Get-RealRepoActionPlan.ps1
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
.continue/rules/Workspace_GC.md
.copilot/Rules/RuleAuthority.md
.copilot/Methods/APPLY.ps1
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

Those require a later explicit design and user approval.

## Inspection Checklist

- Run the single readiness command and confirm it passes.
- Confirm `Real repository selected: False` until a target is explicitly chosen.
- Confirm `Real repository dry-run status: blocked-until-repository-selected` in self-stabilization.
- Confirm `Real repository allowed Git commands: 4`.
- Confirm `Real repository action preview status: blocked-until-repository-selected` before target selection.
- Confirm `Real repository change-request orientation: bottom-up`.
- Confirm `WriteProbePerformed: False` in target profile output.