<#
Module: WorkspaceGCQualityGates.psm1
Purpose: Provide reusable Workspace_GC readiness and stabilization quality gates.
Path: .copilot/Methods/QualityGates/WorkspaceGCQualityGates.psm1
Authors: Workspace_GC Engine
Version: 1.3.0
Caller Contract: Imported by native governance scripts; validates Workspace_GC state without writing to external repositories.
Changelog:
- 2026-08-01: Added dry-run target profile and adapter surface inventory checks.
- 2026-08-01: Added transition-policy and dry-run state consistency checks.
- 2026-08-01: Added real-repository test plan and dry-run policy quality gate.
- 2026-08-01: Consolidated helper Test-* scripts into one quality-gate module.
#>

function Get-WorkspaceGCRoot {
  [CmdletBinding()]
  param(
    [string]$ModuleRoot = $PSScriptRoot
  )

  return Split-Path (Split-Path (Split-Path $ModuleRoot -Parent) -Parent) -Parent
}

function Assert-WorkspaceGCIgnoredRepositories {
  [CmdletBinding()]
  param(
    [string]$SettingsPath,

    [string]$WorkspaceParent = 'D:\Git_Repositories',

    [string]$ActiveRepository = 'D:\Git_Repositories\Workspace_GC',

    [string]$WorkspaceRoot
  )

  if (-not $WorkspaceRoot) {
    $WorkspaceRoot = Get-WorkspaceGCRoot
  }

  if (-not $SettingsPath) {
    $SettingsPath = Join-Path $WorkspaceRoot '.vscode\settings.json'
  }

  if (-not (Test-Path -LiteralPath $SettingsPath)) {
    throw "Settings file not found: $SettingsPath"
  }

  $methodsRoot = Join-Path $WorkspaceRoot '.copilot\Methods'
  $discoveryPath = Join-Path $methodsRoot 'Get-WorkspaceRepositories.ps1'
  if (-not (Test-Path -LiteralPath $discoveryPath)) {
    throw "Repository discovery command not found: $discoveryPath"
  }

  $settings = Get-Content -Raw -Path $SettingsPath | ConvertFrom-Json
  $ignoredRepositories = @($settings.'git.ignoredRepositories')
  $repositories = @(& $discoveryPath -WorkspaceParent $WorkspaceParent -ActiveRepository $ActiveRepository)
  $missingRepositories = @()

  foreach ($repository in $repositories) {
    $currentRepository = $repository
    if ($ignoredRepositories -notcontains $currentRepository.Path) {
      $missingRepositories += $currentRepository.Path
    }
  }

  if ($missingRepositories.Count -gt 0) {
    throw ('Missing ignored repositories: ' + ($missingRepositories -join '; '))
  }

  return [pscustomobject]@{
    Status = 'OK'
    IgnoredRepositoryCount = $ignoredRepositories.Count
    DiscoveredSiblingRepositoryCount = $repositories.Count
  }
}

function Assert-WorkspaceGCStabilizationPolicy {
  [CmdletBinding()]
  param(
    [string]$StabilizationPath,

    [string]$RealRepoTestPlanPath,

    [string]$WorkspaceRoot
  )

  if (-not $WorkspaceRoot) {
    $WorkspaceRoot = Get-WorkspaceGCRoot
  }

  $copilotRoot = Join-Path $WorkspaceRoot '.copilot'

  if (-not $StabilizationPath) {
    $StabilizationPath = Join-Path $copilotRoot 'Methods\Logs\GC-Stabilization.json'
  }

  if (-not $RealRepoTestPlanPath) {
    $RealRepoTestPlanPath = Join-Path $copilotRoot 'Methods\Logs\GC-RealRepoTestPlan.json'
  }

  foreach ($requiredPath in @($StabilizationPath, $RealRepoTestPlanPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath)) {
      throw "Policy file missing: $requiredPath"
    }
  }

  $stabilizationState = Get-Content -Raw -Path $StabilizationPath | ConvertFrom-Json
  $realRepoPlan = Get-Content -Raw -Path $RealRepoTestPlanPath | ConvertFrom-Json
  $requiredOffLimits = @('D:\Git_Repositories\Workspace_AC', 'B:\Backups\Base_WS_AC')

  foreach ($requiredOffLimit in $requiredOffLimits) {
    if (@($stabilizationState.off_limits_paths) -notcontains $requiredOffLimit) {
      throw "Missing off-limits path in stabilization state: $requiredOffLimit"
    }
  }

  if ($stabilizationState.real_repository_testing_enabled -ne $false) {
    throw 'real_repository_testing_enabled must remain false during self-stabilization.'
  }

  if ($stabilizationState.external_repository_write_allowed -ne $false) {
    throw 'external_repository_write_allowed must remain false during self-stabilization.'
  }

  if ($realRepoPlan.enabled -ne $false -or $realRepoPlan.write_allowed -ne $false) {
    throw 'Real-repository test plan must remain disabled and read-only.'
  }

  return [pscustomobject]@{
    Status = 'OK'
    Phase = $stabilizationState.phase
    RealRepositoryTestingEnabled = $stabilizationState.real_repository_testing_enabled
    RealRepositorySelected = [bool]$realRepoPlan.selected_repository
    OffLimitsPathCount = @($stabilizationState.off_limits_paths).Count
  }
}

function Assert-WorkspaceGCRealRepoTestPlan {
  [CmdletBinding()]
  param(
    [string]$RealRepoTestPlanPath,

    [string]$StabilizationPath,

    [string]$WorkspaceRoot
  )

  if (-not $WorkspaceRoot) {
    $WorkspaceRoot = Get-WorkspaceGCRoot
  }

  $copilotRoot = Join-Path $WorkspaceRoot '.copilot'

  if (-not $RealRepoTestPlanPath) {
    $RealRepoTestPlanPath = Join-Path $copilotRoot 'Methods\Logs\GC-RealRepoTestPlan.json'
  }

  if (-not $StabilizationPath) {
    $StabilizationPath = Join-Path $copilotRoot 'Methods\Logs\GC-Stabilization.json'
  }

  foreach ($requiredPath in @($RealRepoTestPlanPath, $StabilizationPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath)) {
      throw "Real-repository policy file missing: $requiredPath"
    }
  }

  $realRepoPlan = Get-Content -Raw -Path $RealRepoTestPlanPath | ConvertFrom-Json
  $stabilizationState = Get-Content -Raw -Path $StabilizationPath | ConvertFrom-Json

  if (-not $realRepoPlan.PSObject.Properties['dry_run']) {
    throw 'Real-repository test plan is missing dry_run policy block.'
  }

  if (-not $realRepoPlan.PSObject.Properties['candidate_policy']) {
    throw 'Real-repository test plan is missing candidate_policy block.'
  }

  if (-not $realRepoPlan.PSObject.Properties['transition_policy']) {
    throw 'Real-repository test plan is missing transition_policy block.'
  }

  if (-not $realRepoPlan.PSObject.Properties['target_profile']) {
    throw 'Real-repository test plan is missing target_profile block.'
  }

  if (@($realRepoPlan.dry_run.adapter_surface_candidates).Count -eq 0) {
    throw 'Real-repository dry-run requires at least one adapter surface candidate.'
  }

  if ($realRepoPlan.write_allowed -ne $false -or $realRepoPlan.dry_run.write_allowed -ne $false) {
    throw 'Real-repository test plan must keep all write permissions disabled during self-stabilization.'
  }

  if ($realRepoPlan.candidate_policy.selection_does_not_enable_writes -ne $true) {
    throw 'Real-repository candidate selection must not enable writes.'
  }

  if ($realRepoPlan.transition_policy.write_enablement_supported -ne $false) {
    throw 'Workspace_GC transition policy must not support write enablement during self-stabilization.'
  }

  if ($realRepoPlan.mode -eq 'not-selected' -and $realRepoPlan.selected_repository) {
    throw 'Real-repository test plan cannot have mode not-selected while selected_repository is set.'
  }

  if ($realRepoPlan.mode -eq 'not-selected' -and $realRepoPlan.dry_run.enabled -ne $false) {
    throw 'Real-repository dry-run must be disabled when no repository is selected.'
  }

  if ($realRepoPlan.mode -eq 'dry-run' -and (-not $realRepoPlan.selected_repository -or $realRepoPlan.dry_run.enabled -ne $true)) {
    throw 'Real-repository dry-run mode requires a selected repository and dry_run.enabled true.'
  }

  if ($realRepoPlan.target_profile.write_probe_performed -ne $false) {
    throw 'Real-repository dry-run target profile must not perform write probes.'
  }

  if ($realRepoPlan.selected_repository) {
    $selectedRepository = [System.IO.Path]::GetFullPath([string]$realRepoPlan.selected_repository).TrimEnd('\')
    $workspaceRootPath = [System.IO.Path]::GetFullPath($WorkspaceRoot).TrimEnd('\')
    if ($selectedRepository.Equals($workspaceRootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
      throw 'Workspace_GC cannot be selected as its own real-repository test target.'
    }

    foreach ($offLimitsPath in @($stabilizationState.off_limits_paths)) {
      $normalizedOffLimitsPath = [System.IO.Path]::GetFullPath([string]$offLimitsPath).TrimEnd('\')
      if ($selectedRepository.Equals($normalizedOffLimitsPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Selected repository is off-limits: $selectedRepository"
      }
    }
  }

  return [pscustomobject]@{
    Status = 'OK'
    Mode = $realRepoPlan.mode
    DryRunEnabled = $realRepoPlan.dry_run.enabled
    DryRunStatus = $realRepoPlan.dry_run.status
    SelectedRepository = $realRepoPlan.selected_repository
    WriteAllowed = $realRepoPlan.write_allowed
    ConfirmationRequired = $realRepoPlan.transition_policy.dry_run_requires_read_only_confirmation
    AdapterSurfaceCandidateCount = @($realRepoPlan.dry_run.adapter_surface_candidates).Count
  }
}

function Assert-WorkspaceGCStaleAuthorityReferences {
  [CmdletBinding()]
  param(
    [string]$WorkspaceRoot
  )

  if (-not $WorkspaceRoot) {
    $WorkspaceRoot = Get-WorkspaceGCRoot
  }

  $scanRoots = @(
    (Join-Path $WorkspaceRoot '.vscode'),
    (Join-Path $WorkspaceRoot '.continue'),
    (Join-Path $WorkspaceRoot '.copilot\Methods')
  )

  $allowedFiles = @(
    '.continuerules',
    '.vscode/settings.json',
    '.continue/rules/Workspace_GC.md',
    '.copilot/Methods/Logs/GC-Stabilization.json',
    '.copilot/Methods/Logs/GC-Proposals.json',
    '.copilot/Methods/QualityGates/WorkspaceGCQualityGates.psm1'
  )

  $staleAuthorityPatterns = @(
    'Workspace_AC Engine',
    'Workspace_AC fix-module execution',
    'Path: D:/Git_Repositories/Workspace_AC',
    'Canonical workspace root:\s*D:\\Git_Repositories\\Workspace_AC',
    'authoritative path:\s*D:\\Git_Repositories\\.copilot'
  )

  $matches = @()
  foreach ($scanRoot in $scanRoots) {
    if (-not (Test-Path -LiteralPath $scanRoot)) {
      continue
    }

    $files = Get-ChildItem -Path $scanRoot -Recurse -File -Include *.ps1,*.psm1,*.json,*.md
    foreach ($file in $files) {
      $currentFile = $file
      $relativePath = $currentFile.FullName.Substring($WorkspaceRoot.Length).TrimStart('\').Replace('\', '/')
      if ($allowedFiles -contains $relativePath) {
        continue
      }

      $fileMatches = Select-String -Path $currentFile.FullName -Pattern $staleAuthorityPatterns -ErrorAction Stop
      foreach ($fileMatch in @($fileMatches)) {
        $currentMatch = $fileMatch
        $matches += [pscustomobject]@{
          Path = $relativePath
          Line = $currentMatch.LineNumber
          Text = $currentMatch.Line.Trim()
        }
      }
    }
  }

  if ($matches.Count -gt 0) {
    $message = ($matches | ForEach-Object { "$($_.Path):$($_.Line) $($_.Text)" }) -join '; '
    throw "Unexpected stale authority references found: $message"
  }

  return [pscustomobject]@{
    Status = 'OK'
    ScannedRoots = $scanRoots.Count
    UnexpectedReferenceCount = 0
  }
}

Export-ModuleMember -Function Get-WorkspaceGCRoot, Assert-WorkspaceGCIgnoredRepositories, Assert-WorkspaceGCStabilizationPolicy, Assert-WorkspaceGCRealRepoTestPlan, Assert-WorkspaceGCStaleAuthorityReferences