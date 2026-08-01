[CmdletBinding()]
param(
  [switch]$AsJson
)

<#
Module: Get-RealRepoTargetProfile.ps1
Purpose: Build a read-only profile of the selected real-repository dry-run target.
Path: .copilot/Methods/Get-RealRepoTargetProfile.ps1
Authors: Workspace_GC Engine
Version: 1.0.0
Caller Contract: Called only after Workspace_GC dry-run policy validation; reads target path, git status, and adapter surface presence without writing to the target.
Changelog:
- 2026-08-01: Added read-only real-repository target profile command.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$copilotRoot = Join-Path $workspaceRoot '.copilot'
$planPath = Join-Path $copilotRoot 'Methods\Logs\GC-RealRepoTestPlan.json'
$stabilizationPath = Join-Path $copilotRoot 'Methods\Logs\GC-Stabilization.json'
$qualityGateModulePath = Join-Path $PSScriptRoot 'QualityGates\WorkspaceGCQualityGates.psm1'

Import-Module $qualityGateModulePath -Force

$planValidation = Assert-WorkspaceGCRealRepoTestPlan -WorkspaceRoot $workspaceRoot -RealRepoTestPlanPath $planPath -StabilizationPath $stabilizationPath
$plan = Get-Content -Raw -Path $planPath | ConvertFrom-Json

if ($planValidation.DryRunEnabled -ne $true -or -not $planValidation.SelectedRepository) {
  $result = [pscustomobject]@{
    Status = 'blocked'
    Reason = $planValidation.DryRunStatus
    RepositoryName = $null
    RepositoryPath = $planValidation.SelectedRepository
    GitStatusSummary = 'not-run'
    GitStatusLineCount = 0
    AdapterSurfacePresentCount = 0
    AdapterSurfaceMissingCount = @($plan.dry_run.adapter_surface_candidates).Count
    WriteProbePerformed = $false
  }
} else {
  $selectedRepository = [string]$planValidation.SelectedRepository
  if (-not (Test-Path -LiteralPath (Join-Path $selectedRepository '.git'))) {
    throw "Selected dry-run target is not a Git repository: $selectedRepository"
  }

  $gitStatusShort = @(git -C $selectedRepository status --short)
  $adapterSurfaceCandidates = @($plan.dry_run.adapter_surface_candidates)
  $presentSurfaces = @()
  $missingSurfaces = @()

  foreach ($surface in $adapterSurfaceCandidates) {
    $currentSurface = [string]$surface
    $surfacePath = Join-Path $selectedRepository $currentSurface
    if (Test-Path -LiteralPath $surfacePath) {
      $presentSurfaces += $currentSurface
    } else {
      $missingSurfaces += $currentSurface
    }
  }

  $result = [pscustomobject]@{
    Status = 'OK'
    Reason = 'read-only-profile-complete'
    RepositoryName = Split-Path $selectedRepository -Leaf
    RepositoryPath = $selectedRepository
    GitStatusSummary = if ($gitStatusShort.Count -eq 0) { 'clean' } else { 'has-changes' }
    GitStatusLineCount = $gitStatusShort.Count
    AdapterSurfacePresentCount = $presentSurfaces.Count
    AdapterSurfaceMissingCount = $missingSurfaces.Count
    AdapterSurfacePresent = $presentSurfaces
    AdapterSurfaceMissing = $missingSurfaces
    WriteProbePerformed = $false
  }
}

if ($AsJson) {
  $result | ConvertTo-Json -Depth 6
} else {
  $result
}