[CmdletBinding()]
param()

<#
Module: Test-WorkspaceGCReadiness.ps1
Purpose: Run native Workspace_GC self-readiness checks before real-repository testing.
Path: tools/Test-WorkspaceGCReadiness.ps1
Authors: Workspace_GC Engine
Version: 1.8.0
Caller Contract: Called manually before enabling real-repository tests; validates current native governance pipeline.
Changelog:
- 2026-08-02: Added target-local proposal cleanup scanner parsing.
- 2026-08-02: Added target-local method instance bootstrap command parsing.
- 2026-08-01: Added intended-action preview command parsing and readiness output.
- 2026-08-01: Added target-profile command parsing and readiness output.
- 2026-08-01: Added guarded real-repository transition command parsing and plan inspection.
- 2026-08-01: Added real-repository dry-run contract checks.
- 2026-08-01: Consolidated helper checks behind WorkspaceGCQualityGates module.
- 2026-08-01: Added stabilization policy and stale-reference checks.
- 2026-08-01: Added Workspace_GC readiness self-test wrapper.
#>

$workspaceRoot = Split-Path $PSScriptRoot -Parent
Set-Location $workspaceRoot

$qualityGateModulePath = Join-Path $PSScriptRoot 'QualityGates\WorkspaceGCQualityGates.psm1'
Import-Module $qualityGateModulePath -Force

Get-Content -Raw .\.vscode\settings.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\History\Logs\GC-Proposals.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\History\Logs\GC-Stabilization.json | ConvertFrom-Json | Out-Null
Get-Content -Raw .\.copilot\History\Logs\GC-RealRepoTestPlan.json | ConvertFrom-Json | Out-Null

$scriptFiles = @(
  '.\tools/APPLY.ps1',
  '.\tools/Generate-Log.ps1',
  '.\tools/Advance-Governance.ps1',
  '.\tools/Get-WorkspaceRepositories.ps1',
  '.\tools/Get-RealRepoTestPlan.ps1',
  '.\tools/Get-RealRepoTargetProfile.ps1',
  '.\tools/Get-RealRepoActionPlan.ps1',
  '.\tools/Set-RealRepoTestPlan.ps1',
  '.\tools/Initialize-RealRepoMethodInstance.ps1',
  '.\tools/Test-RealRepoProposalCleanup.ps1',
  '.\tools/Invoke-RealRepoDryRun.ps1',
  '.\tools/QualityGates\WorkspaceGCQualityGates.psm1',
  '.\tools/Update-Proposal.ps1'
)

foreach ($scriptFile in $scriptFiles) {
  $currentScriptFile = $scriptFile
  $parseErrors = @()
  [System.Management.Automation.PSParser]::Tokenize((Get-Content -Raw $currentScriptFile), [ref]$parseErrors) | Out-Null
  if ($parseErrors.Count -gt 0) {
    throw "PowerShell parse failed: $currentScriptFile"
  }
}

.\tools/APPLY.ps1 -FixName Fix_S3E03 -NoLog
Assert-WorkspaceGCIgnoredRepositories -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCStabilizationPolicy -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCRealRepoTestPlan -WorkspaceRoot $workspaceRoot | Out-Host
Assert-WorkspaceGCStaleAuthorityReferences -WorkspaceRoot $workspaceRoot | Out-Host
.\tools/Get-RealRepoTestPlan.ps1 | Out-Host
.\tools/Get-RealRepoTargetProfile.ps1 | Out-Host
.\tools/Get-RealRepoActionPlan.ps1 | Out-Host
.\tools/Invoke-RealRepoDryRun.ps1 | Out-Host
.\tools/Generate-Log.ps1
.\tools/Advance-Governance.ps1

Write-Host 'Workspace_GC readiness self-test: OK'