[CmdletBinding()]
param(
  [switch]$AsJson
)

<#
Module: Get-RealRepoTestPlan.ps1
Purpose: Read Workspace_GC real-repository test plan state without changing it.
Path: .copilot/Methods/Get-RealRepoTestPlan.ps1
Authors: Workspace_GC Engine
Version: 1.7.0
Caller Contract: Called by operators or governance scripts when inspecting real-repository dry-run state; performs no external repository access.
Changelog:
- 2026-08-02: Added proposal location and Markdown authority summary fields.
- 2026-08-02: Added lifecycle and integrity preflight policy summary fields.
- 2026-08-01: Added bottom-up change-request flow summary fields.
- 2026-08-01: Added phased dry-run sequence summary fields.
- 2026-08-01: Added intended-action preview status fields.
- 2026-08-01: Added read-only Git command allow-list count.
- 2026-08-01: Added adapter surface and target profile summary fields.
- 2026-08-01: Added read-only real-repository test plan inspection command.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$planPath = Join-Path $workspaceRoot '.copilot\Methods\Logs\GC-RealRepoTestPlan.json'

if (-not (Test-Path -LiteralPath $planPath)) {
  throw "Real-repository test plan not found: $planPath"
}

$plan = Get-Content -Raw -Path $planPath | ConvertFrom-Json
$result = [pscustomobject]@{
  Status = 'OK'
  Mode = $plan.mode
  Enabled = $plan.enabled
  SelectedRepository = $plan.selected_repository
  DryRunEnabled = $plan.dry_run.enabled
  DryRunStatus = $plan.dry_run.status
  WriteAllowed = $plan.write_allowed
  RequiresUserConfirmation = $plan.requires_user_confirmation
  AdapterSurfaceCandidateCount = @($plan.dry_run.adapter_surface_candidates).Count
  AllowedGitCommandCount = @($plan.dry_run.allowed_git_commands).Count
  TargetProfileStatus = $plan.target_profile.status
  ActionPreviewStatus = $plan.action_preview.status
  ActionPreviewWriteAllowed = $plan.action_preview.write_allowed
  ActionPreviewPhaseCount = @($plan.action_preview.phases).Count
  DocumentationFirstPhase = 'phase-04-documentation-discrepancies'
  ChangeRequestOrientation = $plan.action_preview.change_request_flow.orientation
  ChangeRequestPhaseCount = @($plan.action_preview.change_request_flow.phases).Count
  LifecycleStateCount = @($plan.repository_lifecycle_policy.states).Count
  IntegrityPreflightMode = $plan.integrity_preflight_policy.mode
  HiddenIntegrityChecksAllowed = $plan.integrity_preflight_policy.surreptitious_checks_allowed
  RepoWideChecksumDefaultAllowed = $plan.integrity_preflight_policy.repo_wide_checksum_default_allowed
  OrdinaryRepoProposalRoot = $plan.repository_lifecycle_policy.proposal_location_policy.ordinary_repo_proposal_root
  ProposalReviewFormat = $plan.repository_lifecycle_policy.proposal_location_policy.ordinary_repo_required_review_format
  JsonSidecarsReviewable = $plan.repository_lifecycle_policy.proposal_location_policy.json_sidecars_reviewable
}

if ($AsJson) {
  $result | ConvertTo-Json -Depth 6
} else {
  $result
}