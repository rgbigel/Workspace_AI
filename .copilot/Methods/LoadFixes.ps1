[CmdletBinding()]
param()

<#
Module: LoadFixes.ps1
Purpose: Load fix-module descriptors for Workspace_AC fix-module execution.
Path: .copilot/Methods/LoadFixes.ps1
Authors: Workspace_AC Engine
Version: 1.0.0
Caller Contract: Called from APPLY/fix-module validation; returns a hashtable keyed by fix id and module name.
Changelog:
- 2026-07-31: Added deterministic fix-module loader for Fix_S1E03 deep consistency.
#>

$fixesRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'Fixes'
$fixes = @{}

Get-ChildItem -Path $fixesRoot -Filter '*.json' -File | Sort-Object -Property Name | ForEach-Object {
  $fixFile = $_
  $fixModule = Get-Content -Raw -Path $fixFile.FullName | ConvertFrom-Json
  $moduleName = [System.IO.Path]::GetFileNameWithoutExtension($fixFile.Name)
  $fixes[$moduleName] = $fixModule

  if ($fixModule.PSObject.Properties['id']) {
    $fixes[$fixModule.id] = $fixModule
  }
}

return $fixes
