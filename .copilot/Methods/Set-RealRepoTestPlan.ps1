[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [string]$RepositoryPath,

  [ValidateSet('not-selected', 'candidate-selected', 'dry-run')]
  [string]$Mode,

  [switch]$ClearSelection,

  [switch]$EnableDryRun,

  [switch]$ConfirmReadOnlyDryRun,

  [switch]$AsJson
)

<#
Module: Set-RealRepoTestPlan.ps1
Purpose: Update the Workspace_GC real-repository test plan without enabling writes.
Path: .copilot/Methods/Set-RealRepoTestPlan.ps1
Authors: Workspace_GC Engine
Version: 1.2.0
Caller Contract: Called only for Workspace_GC governance preparation; refuses write enablement and validates policy after updating the local plan file.
Changelog:
- 2026-08-01: Synchronized target-profile and action-preview status fields during candidate transitions.
- 2026-08-01: Added candidate Git repository validation and explicit read-only dry-run confirmation.
- 2026-08-01: Added guarded real-repository test plan update command.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$copilotRoot = Join-Path $workspaceRoot '.copilot'
$planPath = Join-Path $copilotRoot 'Methods\Logs\GC-RealRepoTestPlan.json'
$stabilizationPath = Join-Path $copilotRoot 'Methods\Logs\GC-Stabilization.json'
$qualityGateModulePath = Join-Path $PSScriptRoot 'QualityGates\WorkspaceGCQualityGates.psm1'

Import-Module $qualityGateModulePath -Force

if (-not (Test-Path -LiteralPath $planPath)) {
  throw "Real-repository test plan not found: $planPath"
}

if ($RepositoryPath -and $ClearSelection) {
  throw 'Use either -RepositoryPath or -ClearSelection, not both.'
}

$plan = Get-Content -Raw -Path $planPath | ConvertFrom-Json
$stabilizationState = Get-Content -Raw -Path $stabilizationPath | ConvertFrom-Json

if ($Mode -eq 'dry-run' -and -not $EnableDryRun) {
  throw 'Use -EnableDryRun with -ConfirmReadOnlyDryRun to enter dry-run mode.'
}

if ($ClearSelection) {
  $plan.selected_repository = $null
  $plan.mode = 'not-selected'
  $plan.enabled = $false
  $plan.write_allowed = $false
  $plan.confirmation_token = $null
  $plan.dry_run.enabled = $false
  $plan.dry_run.status = 'blocked-until-repository-selected'
  $plan.target_profile.status = 'not-run'
  $plan.target_profile.repository_name = $null
  $plan.target_profile.repository_path = $null
  $plan.target_profile.repository_root_verified = $false
  $plan.target_profile.branch_name = $null
  $plan.target_profile.head_commit = $null
  $plan.target_profile.git_status_summary = 'not-run'
  $plan.target_profile.adapter_surface_present_count = 0
  $plan.target_profile.adapter_surface_missing_count = 0
  $plan.target_profile.write_probe_performed = $false
  $plan.action_preview.status = 'blocked-until-repository-selected'
  $plan.action_preview.action_count = 0
  $plan.action_preview.current_phase = 'blocked'
}

if ($RepositoryPath) {
  $fullRepositoryPath = [System.IO.Path]::GetFullPath($RepositoryPath).TrimEnd('\')
  $workspaceRootPath = [System.IO.Path]::GetFullPath($workspaceRoot).TrimEnd('\')

  if ($fullRepositoryPath.Equals($workspaceRootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Workspace_GC cannot be selected as its own real-repository test target.'
  }

  foreach ($offLimitsPath in @($stabilizationState.off_limits_paths)) {
    $normalizedOffLimitsPath = [System.IO.Path]::GetFullPath([string]$offLimitsPath).TrimEnd('\')
    if ($fullRepositoryPath.Equals($normalizedOffLimitsPath, [System.StringComparison]::OrdinalIgnoreCase)) {
      throw "Selected repository is off-limits: $fullRepositoryPath"
    }
  }

  if (-not (Test-Path -LiteralPath (Join-Path $fullRepositoryPath '.git'))) {
    throw "Selected repository must be an existing Git repository: $fullRepositoryPath"
  }

  $plan.selected_repository = $fullRepositoryPath
  $plan.mode = 'candidate-selected'
  $plan.enabled = $false
  $plan.write_allowed = $false
  $plan.confirmation_token = $null
  $plan.dry_run.enabled = $false
  $plan.dry_run.status = 'blocked-until-dry-run-enabled'
  $plan.target_profile.status = 'not-run'
  $plan.target_profile.repository_name = Split-Path $fullRepositoryPath -Leaf
  $plan.target_profile.repository_path = $fullRepositoryPath
  $plan.target_profile.repository_root_verified = $false
  $plan.target_profile.branch_name = $null
  $plan.target_profile.head_commit = $null
  $plan.target_profile.git_status_summary = 'not-run'
  $plan.target_profile.adapter_surface_present_count = 0
  $plan.target_profile.adapter_surface_missing_count = @($plan.dry_run.adapter_surface_candidates).Count
  $plan.target_profile.write_probe_performed = $false
  $plan.action_preview.status = 'blocked-until-dry-run-enabled'
  $plan.action_preview.action_count = 0
  $plan.action_preview.current_phase = 'blocked'
}

if ($Mode) {
  $plan.mode = $Mode
}

if ($EnableDryRun) {
  if (-not $plan.selected_repository) {
    throw 'Cannot enable dry-run mode before selecting a repository candidate.'
  }

  if (-not $ConfirmReadOnlyDryRun) {
    throw 'Use -ConfirmReadOnlyDryRun to confirm dry-run remains read-only.'
  }

  $plan.mode = 'dry-run'
  $plan.enabled = $true
  $plan.write_allowed = $false
  $plan.dry_run.enabled = $true
  $plan.dry_run.status = 'ready-read-only'
  $plan.action_preview.status = 'ready-read-only'
  $plan.action_preview.current_phase = 'phase-01-structure'
}

if ($plan.write_allowed -ne $false -or $plan.dry_run.write_allowed -ne $false) {
  throw 'Set-RealRepoTestPlan never enables write permissions.'
}

$json = $plan | ConvertTo-Json -Depth 10
if ($PSCmdlet.ShouldProcess($planPath, 'Update Workspace_GC real-repository test plan')) {
  Set-Content -Path $planPath -Value $json -Encoding utf8
}

$result = Assert-WorkspaceGCRealRepoTestPlan -WorkspaceRoot $workspaceRoot -RealRepoTestPlanPath $planPath -StabilizationPath $stabilizationPath

if ($AsJson) {
  $result | ConvertTo-Json -Depth 6
} else {
  $result
}