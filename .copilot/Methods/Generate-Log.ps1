[CmdletBinding()]
param(
  [string]$OutputPath,

  [string]$StepLogPath,

  [string]$PermanentLogPath,

  [string]$ProposalLogPath
)

<#
Module: Generate-Log.ps1
Purpose: Generate native Workspace_GC step and permanent governance logs.
Path: .copilot/Methods/Generate-Log.ps1
Authors: Workspace_GC Engine
Version: 1.1.0
Caller Contract: Called from VS Code tasks or terminal; writes deterministic checkpoint and accepted-change governance logs.
Changelog:
- 2026-08-01: Loaded step proposal records from GC-Proposals.json instead of hardcoding entries.
- 2026-08-01: Added separate step-oriented and permanent accepted-change log outputs.
- 2026-08-01: Added native governance log generator for Gemini/Continue migration.
#>

$workspaceRoot = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$copilotRoot = Join-Path $workspaceRoot '.copilot'

if (-not $OutputPath) {
  $OutputPath = Join-Path $copilotRoot 'Logs\Workspace_GC.log'
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

$rulesPath = Join-Path $workspaceRoot '.github\agents\Workspace-Rules.md'
$agentIndexPath = Join-Path $workspaceRoot '.github\agents\WorkspaceAgentIndex.md'
$ruleAuthorityPath = Join-Path $copilotRoot 'Rules\RuleAuthority.md'
$s1LogPath = Join-Path $copilotRoot 'Methods\Logs\S1.log'
$s2LogPath = Join-Path $copilotRoot 'Methods\Logs\S2.log'

$requiredPaths = @($rulesPath, $agentIndexPath, $ruleAuthorityPath, $s1LogPath, $s2LogPath, $ProposalLogPath)
foreach ($requiredPath in $requiredPaths) {
  if (-not (Test-Path -LiteralPath $requiredPath)) {
    throw "Required governance input missing: $requiredPath"
  }
}

$latestCommit = git -C $workspaceRoot log -1 --oneline
$baselineCommit = git -C $workspaceRoot rev-list --max-parents=0 HEAD
$acceptedCommits = git -C $workspaceRoot log --reverse --format='%h %ad %s' --date=format:'%Y%m%d_%H%M%S' "$baselineCommit..HEAD"
$status = git -C $workspaceRoot status --short
$generatedAt = Get-Date -Format 'yyyyMMdd_HHmmss'
$proposalState = Get-Content -Raw -Path $ProposalLogPath | ConvertFrom-Json
$stepEntries = @($proposalState.proposals)

$content = @(
  'Workspace_GC Governance Log',
  '===========================',
  '',
  '1. Header',
  '---------',
  'Workspace name: Workspace_GC',
  "Generated at: $generatedAt",
  "Latest commit at generation: $latestCommit",
  '',
  '2. Rule Authority',
  '-----------------',
  "Rule authority: $ruleAuthorityPath",
  "Workspace rules: $rulesPath",
  "Agent index: $agentIndexPath",
  '',
  '3. Native Governance Status',
  '----------------------------',
  'Native Generate-Log.ps1: available',
  'Native Advance-Governance.ps1: available when this log is generated through the governance task',
  'Step-oriented log: .copilot/Logs/Workspace_GC.step.log',
  'Permanent accepted log: .copilot/Logs/Workspace_GC.accepted.log',
  'Proposal registry: .copilot/Methods/Logs/GC-Proposals.json',
  '',
  '4. Git Status',
  '-------------'
)

if ($status) {
  $content += $status
} else {
  $content += 'Clean'
}

$content += @(
  '',
  '5. Footer',
  '---------',
  'Workspace_GC native governance log generation complete.'
)

$outputDirectory = Split-Path $OutputPath -Parent
if (-not (Test-Path -LiteralPath $outputDirectory)) {
  New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

Set-Content -Path $OutputPath -Value $content -Encoding utf8

$stepContent = @(
  'Workspace_GC Step-Oriented Governance Log',
  '=========================================',
  '',
  '1. Header',
  '---------',
  'Purpose: Checkpoint log for proposed changes, reasons, and dispositions.',
  'Lifecycle: May be overwritten at checkpoint regeneration.',
  "Generated at: $generatedAt",
  "Latest commit at generation: $latestCommit",
  '',
  '2. Change Proposals',
  '-------------------'
)

foreach ($stepEntry in $stepEntries) {
  $currentStepEntry = $stepEntry
  $fileList = @($currentStepEntry.files) -join '; '
  $stepContent += @(
    "Id: $($currentStepEntry.id)",
    "Proposal: $($currentStepEntry.proposal)",
    "Reason: $($currentStepEntry.reason)",
    "Files: $fileList",
    "Disposition: $($currentStepEntry.disposition)",
    ''
  )
}

$stepContent += @(
  '3. Current Git Status',
  '---------------------'
)

if ($status) {
  $stepContent += $status
} else {
  $stepContent += 'Clean'
}

$stepContent += @(
  '',
  '4. Footer',
  '---------',
  'Workspace_GC step-oriented governance log generation complete.'
)

Set-Content -Path $StepLogPath -Value $stepContent -Encoding utf8

$permanentContent = @(
  'Workspace_GC Permanent Accepted Change Log',
  '==========================================',
  '',
  '1. Header',
  '---------',
  'Purpose: Permanent log for accepted changes represented by local commits after the baseline.',
  'Lifecycle: Pushed accepted entries may be archived or reset to an initialized push reference.',
  "Generated at: $generatedAt",
  "Baseline commit: $baselineCommit",
  "Latest commit at generation: $latestCommit",
  '',
  '2. Accepted Local Commits Since Baseline',
  '---------------------------------------'
)

if ($acceptedCommits) {
  $permanentContent += $acceptedCommits
} else {
  $permanentContent += 'No accepted post-baseline commits recorded yet.'
}

$permanentContent += @(
  '',
  '3. Footer',
  '---------',
  'Workspace_GC permanent accepted change log generation complete.'
)

Set-Content -Path $PermanentLogPath -Value $permanentContent -Encoding utf8
Write-Host "Generated governance log: $OutputPath"
Write-Host "Generated step governance log: $StepLogPath"
Write-Host "Generated permanent accepted log: $PermanentLogPath"