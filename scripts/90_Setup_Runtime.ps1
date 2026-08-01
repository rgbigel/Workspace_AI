# ============================================
# File: 90_Setup_Runtime.ps1
# Module: SystemRekonstruktion
# Purpose: Kopiert Runtime-Skripte nach D:\cmd
# Path: scripts/90_Setup_Runtime.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Richtet Runtime-Skripte ein. Version 1.0.0

.DESCRIPTION
Kopiert die wichtigsten Skripte nach D:\cmd, damit sie auch bei defektem C:
verfuegbar bleiben.

.PARAMETER HelpMode
Zeigt die Hilfe an.
Alias: h, ?

.EXAMPLE
.\90_Setup_Runtime.ps1

.NOTES
D:\cmd wird automatisch erstellt.
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
    Write-Log "CmdRoot erstellt: $CmdRoot"
}

$runtimeScripts = @(
    "00_Common.ps1",
    "01_Export_Paketquellen.ps1",
    "02_Backup_Settings.ps1",
    "03_Restore_Settings.ps1",
    "04_Rebuild_System.ps1"
)

foreach ($script in $runtimeScripts) {
    $src = Join-Path $PSScriptRoot $script
    if (Test-Path $src) {
        $dest = Join-Path $CmdRoot $script
        Copy-Item $src $dest -Force
        Write-Log "Kopiert: $src -> $dest"
    } else {
        Write-Log "Fehlt: $src" "WARN"
    }
}

Write-Log "Setup-Runtime abgeschlossen"
