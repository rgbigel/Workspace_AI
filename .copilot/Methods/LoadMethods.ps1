[CmdletBinding()]
param()

<#
Module: LoadMethods.ps1
Purpose: Load method script metadata for Workspace_AC fix-module execution.
Path: .copilot/Methods/LoadMethods.ps1
Authors: Workspace_AC Engine
Version: 1.0.0
Caller Contract: Called from APPLY/fix-module validation; returns a hashtable keyed by method file name.
Changelog:
- 2026-07-31: Added deterministic method loader for Fix_S1E03 deep consistency.
#>

$methodsRoot = $PSScriptRoot
$methods = @{}

Get-ChildItem -Path $methodsRoot -Filter '*.ps1' -File | Sort-Object -Property Name | ForEach-Object {
  $methodFile = $_
  $methods[$methodFile.Name] = [pscustomobject]@{
    Name = $methodFile.Name
    Path = $methodFile.FullName
  }
}

return $methods
