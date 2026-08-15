[CmdletBinding()]
param(
  [string]$WorkspaceParent = 'D:\Git_Repositories',

  [string]$ActiveRepository = 'D:\Git_Repositories\Workspace_AI',

  [switch]$IncludeActiveRepository,

  [switch]$AsJson
)

<#
Module: Get-WorkspaceRepositories.ps1
Purpose: Discover sibling Git repositories read-only for Workspace_AI stabilization checks.
Path: tools/Get-WorkspaceRepositories.ps1
Authors: Workspace_AI Engine
Version: 1.0.0
Caller Contract: Called during Workspace_AI stabilization; returns direct child directories with .git folders without modifying them.
Changelog:
- 2026-08-01: Added read-only sibling repository discovery command.
#>

if (-not (Test-Path -LiteralPath $WorkspaceParent)) {
  throw "Workspace parent not found: $WorkspaceParent"
}

$activeRepositoryPath = [System.IO.Path]::GetFullPath($ActiveRepository).TrimEnd('\')
$repositories = Get-ChildItem -Path $WorkspaceParent -Directory | Where-Object {
  $candidate = $_
  Test-Path -LiteralPath (Join-Path $candidate.FullName '.git')
} | Where-Object {
  $candidate = $_
  $candidatePath = [System.IO.Path]::GetFullPath($candidate.FullName).TrimEnd('\')
  $IncludeActiveRepository -or -not $candidatePath.Equals($activeRepositoryPath, [System.StringComparison]::OrdinalIgnoreCase)
} | Sort-Object -Property FullName | ForEach-Object {
  $repository = $_
  [pscustomobject]@{
    Name = $repository.Name
    Path = $repository.FullName
  }
}

if ($AsJson) {
  $repositories | ConvertTo-Json -Depth 4
} else {
  $repositories
}