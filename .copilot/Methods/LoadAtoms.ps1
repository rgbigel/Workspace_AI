[CmdletBinding()]
param()

<#
Module: LoadAtoms.ps1
Purpose: Load atom files for Workspace_AC fix-module execution.
Path: .copilot/Methods/LoadAtoms.ps1
Authors: Workspace_AC Engine
Version: 1.0.0
Caller Contract: Called from APPLY/fix-module validation; returns a hashtable keyed by atom base name.
Changelog:
- 2026-07-31: Added deterministic atom loader for Fix_S1E03 deep consistency.
#>

$atomsRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'Atoms'
$atoms = @{}

Get-ChildItem -Path $atomsRoot -Filter '*.atom' -File | Sort-Object -Property Name | ForEach-Object {
  $atomFile = $_
  $atomName = [System.IO.Path]::GetFileNameWithoutExtension($atomFile.Name)
  $atoms[$atomName] = Get-Content -Path $atomFile.FullName
}

return $atoms
