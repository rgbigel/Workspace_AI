[CmdletBinding()]
param(
  [string]$LogPath,

  [string]$StepLogPath,

  [string]$PermanentLogPath,

  [string]$ProposalLogPath
)

<#
Module: Advance-Governance.ps1
Purpose: Validate native Workspace_GC governance readiness and log separation without staging or committing changes.
Path: .copilot/Methods/Advance-Governance.ps1
Authors: Workspace_GC Engine
Version: 1.1.0
Caller Contract: Called from VS Code tasks or terminal; validates native governance inputs and reports status.
Changelog:
- 2026-08-01: Added validation for structured step proposal registry.
- 2026-08-01: Added validation for step-oriented and permanent accepted governance logs.
- 2026-08-01: Added native governance advancement check for Gemini/Continue migration.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$copilotRoot = Join-Path $workspaceRoot '.copilot'

if (-not $LogPath) {
  $LogPath = Join-Path $copilotRoot 'Logs\Workspace_GC.log'
}

if (-not $StepLogPath) {
  $StepLogPath = Join-Path $copilotRoot 'Logs\Workspace_GC.step.log'
}

if (-not $PermanentLogPath) {
  $PermanentLogPath = Join-Path $copilotRoot 'Logs\Workspace_GC.accepted.log'
}

if (-not $ProposalLogPath) {
  $ProposalLogPath = Join-Path $copilotRoot 'Methods\Logs\GC-Proposals.json'
}

$requiredPaths = @(
  (Join-Path $workspaceRoot '.continuerules'),
  (Join-Path $workspaceRoot '.continue\rules\Workspace_GC.md'),
  (Join-Path $workspaceRoot '.github\agents\Workspace-Rules.md'),
  (Join-Path $workspaceRoot '.copilot\Rules\RuleAuthority.md'),
  (Join-Path $workspaceRoot '.copilot\Rules\InvariantRules.md'),
  $ProposalLogPath,
  $LogPath,
  $StepLogPath,
  $PermanentLogPath
)

foreach ($requiredPath in $requiredPaths) {
  if (-not (Test-Path -LiteralPath $requiredPath)) {
    throw "Required governance artifact missing: $requiredPath"
  }
}

$status = git -C $workspaceRoot status --short
$proposalState = Get-Content -Raw -Path $ProposalLogPath | ConvertFrom-Json
if (-not $proposalState.PSObject.Properties['proposals'] -or @($proposalState.proposals).Count -eq 0) {
  throw "Proposal registry is empty: $ProposalLogPath"
}

Write-Host 'Workspace_GC native governance check: OK'
Write-Host "Governance log: $LogPath"
Write-Host "Step governance log: $StepLogPath"
Write-Host "Permanent accepted log: $PermanentLogPath"
Write-Host "Proposal registry: $ProposalLogPath"

if ($status) {
  Write-Host 'Pending review changes:'
  $status | ForEach-Object {
    $statusLine = $_
    Write-Host $statusLine
  }
} else {
  Write-Host 'Git status: clean'
}