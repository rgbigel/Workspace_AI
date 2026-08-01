[CmdletBinding()]
param(
  [switch]$AsJson
)

<#
Module: Get-RealRepoTestPlan.ps1
Purpose: Read Workspace_GC real-repository test plan state without changing it.
Path: .copilot/Methods/Get-RealRepoTestPlan.ps1
Authors: Workspace_GC Engine
Version: 1.1.0
Caller Contract: Called by operators or governance scripts when inspecting real-repository dry-run state; performs no external repository access.
Changelog:
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
  TargetProfileStatus = $plan.target_profile.status
}

if ($AsJson) {
  $result | ConvertTo-Json -Depth 6
} else {
  $result
}