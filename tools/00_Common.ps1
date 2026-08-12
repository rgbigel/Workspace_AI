# ============================================
# File: 00_Common.ps1
# Module: SystemRekonstruktion
# Purpose: Gemeinsame Pfad- und Logging-Funktionen
# Path: tools/00_Common.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Basisfunktionen fuer Logging und Pfadlogik. Version 1.0.0

.DESCRIPTION
Dieses Modul stellt zentrale Funktionen fuer alle Skripte bereit:
- Zeitstempel
- SystemName-Autodetektion
- BackupRoot-Erzeugung
- Logging

.PARAMETER SystemName
Optionaler Systemname. Default: COMPUTERNAME.

.EXAMPLE
. .\00_Common.ps1

.NOTES
Erfordert PowerShell 5+.
#>

[CmdletBinding()]
param(
    [string]$SystemName = $env:COMPUTERNAME,
    [string]$BaseBackupRoot = "D:\SystemRekonstruktion_Backup",
    [string]$BaseLogRoot = "D:\SystemRekonstruktion_Logs",
    [Alias("h","?")]
    [switch]$HelpMode
)

if ($HelpMode) {
    Get-Help $PSCommandPath -Full
    exit 0
}

$Global:SR_Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$Global:SR_SystemRoot = Join-Path $BaseBackupRoot ("{0} {1}" -f $SystemName, $Global:SR_Timestamp)

if (!(Test-Path $BaseLogRoot)) {
    New-Item -Path $BaseLogRoot -ItemType Directory -Force | Out-Null
}
$Global:SR_LogRoot = $BaseLogRoot
$scriptName = (Split-Path -Leaf $PSCommandPath)
$Global:SR_LogFile = Join-Path $Global:SR_LogRoot ("{0}_{1}.log" -f $scriptName, $Global:SR_Timestamp)

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[{0}] [{1}] {2}" -f $ts, $Level, $Message
    Write-Host $line
    Add-Content -Path $Global:SR_LogFile -Value $line
}

Write-Log "Common initialisiert. SystemRoot: $Global:SR_SystemRoot"
