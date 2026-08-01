[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$Id,

  [ValidateSet('pending-review', 'accepted', 'rejected', 'modified')]
  [string]$Disposition,

  [string]$DispositionReason,

  [string]$FinalResult,

  [string]$ProposalLogPath
)

<#
Module: Update-Proposal.ps1
Purpose: Update Workspace_GC proposal disposition records deterministically.
Path: .copilot/Methods/Update-Proposal.ps1
Authors: Workspace_GC Engine
Version: 1.0.0
Caller Contract: Called with a proposal id and optional disposition fields; updates GC-Proposals.json without committing changes.
Changelog:
- 2026-08-01: Added native proposal registry update command.
#>

if (-not $ProposalLogPath) {
  $copilotRoot = Split-Path $PSScriptRoot -Parent
  $ProposalLogPath = Join-Path $PSScriptRoot 'Logs\GC-Proposals.json'
}

if (-not (Test-Path -LiteralPath $ProposalLogPath)) {
  throw "Proposal registry not found: $ProposalLogPath"
}

$proposalState = Get-Content -Raw -Path $ProposalLogPath | ConvertFrom-Json
$proposal = @($proposalState.proposals) | Where-Object { $_.id -eq $Id } | Select-Object -First 1

if (-not $proposal) {
  throw "Proposal not found: $Id"
}

if ($PSBoundParameters.ContainsKey('Disposition')) {
  $proposal.disposition = $Disposition
}

if ($PSBoundParameters.ContainsKey('DispositionReason')) {
  if ($proposal.PSObject.Properties['disposition_reason']) {
    $proposal.disposition_reason = $DispositionReason
  } else {
    $proposal | Add-Member -NotePropertyName 'disposition_reason' -NotePropertyValue $DispositionReason
  }
}

if ($PSBoundParameters.ContainsKey('FinalResult')) {
  if ($proposal.PSObject.Properties['final_result']) {
    $proposal.final_result = $FinalResult
  } else {
    $proposal | Add-Member -NotePropertyName 'final_result' -NotePropertyValue $FinalResult
  }
}

if (($proposal.disposition -eq 'rejected' -or $proposal.disposition -eq 'modified') -and -not $proposal.PSObject.Properties['disposition_reason']) {
  throw "Proposal requires disposition_reason for disposition '$($proposal.disposition)': $Id"
}

$proposalState | ConvertTo-Json -Depth 8 | Set-Content -Path $ProposalLogPath -Encoding utf8
Write-Host "Updated proposal: $Id"
Write-Host "Disposition: $($proposal.disposition)"