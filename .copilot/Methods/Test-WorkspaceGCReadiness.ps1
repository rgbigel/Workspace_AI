[CmdletBinding()]
param()

<#
Module: Test-WorkspaceGCReadiness.ps1
Purpose: Run native Workspace_GC self-readiness checks before real-repository testing.
Path: .copilot/Methods/Test-WorkspaceGCReadiness.ps1
Authors: Workspace_GC Engine
Version: 1.5.0
Caller Contract: Called manually before enabling real-repository tests; validates current native governance pipeline.
Changelog:
- 2026-08-01: Added target-profile command parsing and readiness output.
- 2026-08-01: Added guarded real-repository transition command parsing and plan inspection.
- 2026-08-01: Added real-repository dry-run contract checks.
- 2026-08-01: Consolidated helper checks behind WorkspaceGCQualityGates module.
- 2026-08-01: Added stabilization policy and stale-reference checks.
- 2026-08-01: Added Workspace_GC readiness self-test wrapper.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
Set-Location $workspaceRoot

$qualityGateModulePath = Join-Path $PSScriptRoot 'QualityGates\WorkspaceGCQualityGates.psm1'
Import-Module $qualityGateModulePath -Force

Get-Content -Raw .\.vscode\settings.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\Methods\Logs\GC-Proposals.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\Methods\Logs\GC-Stabilization.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\Methods\Logs\GC-RealRepoTestPlan.json | ConvertFrom-Json | Out-Null

$scriptFiles = @(
  '.\.copilot\Methods\APPLY.ps1',
  '.\.copilot\Methods\Generate-Log.ps1',
  '.\.copilot\Methods\Advance-Governance.ps1',
  '.\.copilot\Methods\Get-WorkspaceRepositories.ps1',
  '.\.copilot\Methods\Get-RealRepoTestPlan.ps1',
  '.\.copilot\Methods\Get-RealRepoTargetProfile.ps1',
  '.\.copilot\Methods\Set-RealRepoTestPlan.ps1',
  '.\.copilot\Methods\Invoke-RealRepoDryRun.ps1',
  '.\.copilot\Methods\QualityGates\WorkspaceGCQualityGates.psm1',
  '.\.copilot\Methods\Update-Proposal.ps1'
)

foreach ($scriptFile in $scriptFiles) {
  $currentScriptFile = $scriptFile
  $parseErrors = @()
  [System.Management.Automation.PSParser]::Tokenize((Get-Content -Raw $currentScriptFile), [ref]$parseErrors) | Out-Null
  if ($parseErrors.Count -gt 0) {
    throw "PowerShell parse failed: $currentScriptFile"
  }
}

.\.copilot\Methods\APPLY.ps1 -FixName Fix_S3E03 -NoLog
Assert-WorkspaceGCIgnoredRepositories -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCStabilizationPolicy -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCRealRepoTestPlan -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCStaleAuthorityReferences -WorkspaceRoot $workspaceRoot | Out-Host
.\.copilot\Methods\Get-RealRepoTestPlan.ps1 | Out-Host
.\.copilot\Methods\Get-RealRepoTargetProfile.ps1 | Out-Host
.\.copilot\Methods\Invoke-RealRepoDryRun.ps1 | Out-Host
.\.copilot\Methods\Generate-Log.ps1
.\.copilot\Methods\Advance-Governance.ps1

Write-Host 'Workspace_GC readiness self-test: OK'