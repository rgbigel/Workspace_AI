[CmdletBinding()]
param()

<#
Module: LoadMethods.ps1
Purpose: Load method script metadata for Workspace_GC fix-module execution.
Path: tools/LoadMethods.ps1
Authors: Workspace_GC Engine
Version: 1.0.1
Caller Contract: Called from APPLY/fix-module validation; returns a hashtable keyed by method file name.
Changelog:
- 2026-08-01: Updated active loader identity from Workspace_AC to Workspace_GC.
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
