[CmdletBinding()]
param()

<#
Module: LoadRules.ps1
Purpose: Load Workspace_AI rule files for native governance validation.
Path: tools/LoadRules.ps1
Authors: Workspace_AI Engine
Version: 1.0.0
Caller Contract: Called by validation scripts; returns a hashtable keyed by rule family.
Changelog:
- 2026-08-12: Added standard Workspace_AI script header.
#>

$workspaceRoot = Split-Path $PSScriptRoot -Parent
$root = Join-Path $workspaceRoot ".copilot\Rules"

$rules = @{
    invariant  = Get-Content (Join-Path $root "InvariantRules.md")
    powershell = Get-Content (Join-Path $root "PowerShellRules.md")
    cmd        = Get-Content (Join-Path $root "CMDRules.md")
    json       = Get-Content (Join-Path $root "JsonRules.md")
}

return $rules
