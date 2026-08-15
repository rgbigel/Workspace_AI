[CmdletBinding(SupportsShouldProcess = $true)]
param(
  [Parameter(Mandatory = $true, Position = 0, HelpMessage = 'Path to target repository to onboard or update')]
  [string]$TargetRepositoryPath,

  [Parameter(Mandatory = $false)]
  [hashtable]$Parameters = @{},

  [Parameter(Mandatory = $false)]
  [switch]$Update,

  [Parameter(Mandatory = $false)]
  [switch]$StepByStep,

  [Parameter(Mandatory = $false)]
  [switch]$DryRun,

  [Parameter(Mandatory = $false)]
  [switch]$Force
)

<#
Module: Invoke-LCMOnboardRepo.ps1
Purpose: CLI entry point for the 4-Phase Lifecycle Model (LCM) Repository Onboarding Engine.
Path: tools/Invoke-LCMOnboardRepo.ps1
Authors: Rolf, Workspace_AI Engine
Version: 1.1.0
Changelog:
- 2026-08-15: Added -Update switch for refreshing/upgrading already onboarded repositories.
- 2026-08-15: Initial CLI wrapper for LCMOnboarding module.
#>

$modulePath = Join-Path $PSScriptRoot 'Onboarding\LCMOnboarding.psd1'
Import-Module $modulePath -Force

Invoke-LCMOnboardRepo -TargetRepositoryPath $TargetRepositoryPath -Parameters $Parameters -Update:$Update -StepByStep:$StepByStep -DryRun:$DryRun -Force:$Force
