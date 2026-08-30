<#
.SYNOPSIS
  Orchestrates complete Gemini AI context synchronization, rule export, knowledge mirroring, and inbox intake.
.DESCRIPTION
  Module: tools/Update-Gemini.ps1
  Purpose: Executes the full Gemini AI integration pipeline:
           1. Consolidates all 17+ LCM governance policies via Export-LCMRules.ps1.
           2. Mirrors workspace repository code and tripartite docs to Google Drive (D:\GDrive\LCM)
              with .txt normalization via Export-LcmKnowledgeBase.ps1.
           3. Ingests instructions and bug reports from D:\GDrive\LCM\INBOX via Sync-GeminiInbox.ps1.
           Conforms to RULE-PS-008 (Metadata Headers), RULE-PS-009 (Audit Logging), and RULE-PS-010 (CLI Help).
  Path: Workspace_AI/tools/Update-Gemini.ps1
  Authors: Rolf, Workspace_AI Engine
  Version: 1.0.0
  Date: 2026-08-30
.PARAMETER Force
  Forces a full clean export of knowledge base files.
.PARAMETER ToClipboard
  Copies the consolidated governance rules to clipboard for instant pasting.
.PARAMETER Help
  Displays this command syntax and parameter reference (-h / -Help / -?).
.EXAMPLE
  updategemini
.EXAMPLE
  pwsh tools/Update-Gemini.ps1 -ToClipboard
#>

[CmdletBinding()]
param(
  [switch]$Force,
  [Alias('c', 'CopyToClipboard')]
  [switch]$ToClipboard,
  [Alias('h', '?')]
  [switch]$Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptVersion = "1.0.0"
$scriptName = "Update-Gemini"
$workspaceRoot = 'D:\Git_Repositories'
$lcdInternal = Join-Path $workspaceRoot '.lcd\tools\internal'

if ($Help) {
  Write-Host "==========================================================================" -ForegroundColor Cyan
  Write-Host " GEMINI AI CONSOLIDATED CONTEXT & GOVERNANCE PIPELINE (v$($scriptVersion))" -ForegroundColor Cyan
  Write-Host "==========================================================================" -ForegroundColor Cyan
  Write-Host "SYNOPSIS:" -ForegroundColor Yellow
  Write-Host "  Synchronizes rules, knowledge base, and inbox queue for Gemini AI integration."
  Write-Host ""
  Write-Host "USAGE:" -ForegroundColor Yellow
  Write-Host "  updategemini [-Force] [-ToClipboard] [-h]"
  Write-Host "==========================================================================" -ForegroundColor Cyan
  return
}

Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host " GEMINI AI CONSOLIDATED CONTEXT & GOVERNANCE PIPELINE (v$($scriptVersion))" -ForegroundColor Cyan
Write-Host " Workspace : $workspaceRoot"
Write-Host " Timestamp : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "==========================================================================" -ForegroundColor Cyan

# ------------------------------------------------------------------------------
# 1. Consolidate Authoritative Governance Rules
# ------------------------------------------------------------------------------
Write-Host "`n[1/3] Consolidating & Exporting Authoritative LCM Rules..." -ForegroundColor Yellow
$exportRulesScript = Join-Path $lcdInternal 'Export-LCMRules.ps1'
if (Test-Path -LiteralPath $exportRulesScript) {
  $clipArg = if ($ToClipboard) { "-ToClipboard" } else { "" }
  if ($ToClipboard) {
    & $exportRulesScript -ToClipboard
  } else {
    & $exportRulesScript
  }
} else {
  Write-Warning "Export-LCMRules.ps1 not found in $lcdInternal"
}

# ------------------------------------------------------------------------------
# 2. Mirror Workspace Knowledge Base to Google Drive with .txt Normalization
# ------------------------------------------------------------------------------
Write-Host "`n[2/3] Mirroring Workspace Knowledge Base to Google Drive (D:\GDrive\LCM)..." -ForegroundColor Yellow
$exportKbScript = Join-Path $lcdInternal 'Export-LcmKnowledgeBase.ps1'
if (Test-Path -LiteralPath $exportKbScript) {
  if ($Force) {
    & $exportKbScript -Force
  } else {
    & $exportKbScript
  }
} else {
  Write-Warning "Export-LcmKnowledgeBase.ps1 not found in $lcdInternal"
}

# ------------------------------------------------------------------------------
# 3. Synchronize Gemini Google Drive Inbox Queue
# ------------------------------------------------------------------------------
Write-Host "`n[3/3] Synchronizing Gemini Google Drive Inbox Queue (D:\GDrive\LCM\INBOX)..." -ForegroundColor Yellow
$syncInboxScript = Join-Path $lcdInternal 'Sync-GeminiInbox.ps1'
if (Test-Path -LiteralPath $syncInboxScript) {
  & $syncInboxScript
} else {
  Write-Warning "Sync-GeminiInbox.ps1 not found in $lcdInternal"
}

Write-Host "`n==========================================================================" -ForegroundColor Cyan
Write-Host " [SUMMARY] Gemini AI Context & Knowledge Base Pipeline Completed" -ForegroundColor Green
Write-Host " Consolidated Rules : Workspace_AI/docs/LCM_Rules_Gemini_Export.md"
Write-Host " Google Drive Mirror: D:\GDrive\LCM (Code & Tripartite Docs with .txt)"
Write-Host " Google Drive Inbox : D:\GDrive\LCM\INBOX"
Write-Host "==========================================================================" -ForegroundColor Cyan
