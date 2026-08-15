[CmdletBinding()]
param(
    [hashtable]$rules
)

<#
Module: ValidateRules.ps1
Purpose: Validate that loaded Workspace_AI rule sets are present and non-empty.
Path: tools/ValidateRules.ps1
Authors: Workspace_AI Engine
Version: 1.0.0
Caller Contract: Called with a hashtable returned by LoadRules.ps1; throws on missing or empty rule sets.
Changelog:
- 2026-08-12: Added standard Workspace_AI script header.
#>

foreach ($key in $rules.Keys) {
    if (-not $rules[$key] -or $rules[$key].Count -eq 0) {
        throw "Rule set '$key' is empty or missing."
    }
}

"OK"
