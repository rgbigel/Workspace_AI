# ============================================
# File: 90_Setup_Runtime.ps1
# Module: SystemReconstruction
# Purpose: Copies runtime scripts to D:\cmd
# Path: tools/90_Setup_Runtime.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version translated to English per workspace invariant
# ============================================

<#
.SYNOPSIS
Sets up runtime scripts. Version 1.0.0

.DESCRIPTION
Copies the most essential scripts to D:\cmd so they remain available even if C:
is damaged.

.PARAMETER HelpMode
Displays help information.
Alias: h, ?

.EXAMPLE
.\90_Setup_Runtime.ps1

.NOTES
D:\cmd is created automatically.
#>

[CmdletBinding()]
param(
    [string]$CmdRoot = "D:\cmd",
    [Alias("h","?")]
    [switch]$HelpMode
)

if ($HelpMode) {
    Get-Help $PSCommandPath -Full
    exit 0
}

. "$PSScriptRoot\00_Common.ps1" -SystemName "SETUP"

if (!(Test-Path $CmdRoot)) {
    New-Item -Path $CmdRoot -ItemType Directory -Force | Out-Null
    Write-Log "CmdRoot created: $CmdRoot"
}

$runtimeScripts = @(
    "00_Common.ps1",
    "01_Export_PackageSources.ps1",
    "02_Backup_Settings.ps1",
    "03_Restore_Settings.ps1",
    "04_Rebuild_System.ps1"
)

foreach ($script in $runtimeScripts) {
    $src = Join-Path $PSScriptRoot $script
    if (Test-Path $src) {
        $dest = Join-Path $CmdRoot $script
        Copy-Item $src $dest -Force
        Write-Log "Copied: $src -> $dest"
    } else {
        Write-Log "Missing: $src" "WARN"
    }
}

Write-Log "Setup runtime completed"
