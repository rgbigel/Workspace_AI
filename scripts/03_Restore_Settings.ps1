# ============================================
# File: 03_Restore_Settings.ps1
# Module: SystemRekonstruktion
# Purpose: Stellt Settings aus Backup wieder her
# Path: scripts/03_Restore_Settings.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Stellt Settings wieder her. Version 1.0.0

.DESCRIPTION
Stellt AppData, ProgramData und Registry-Dateien aus einem BackupRoot wieder her.
Systemname wird automatisch aus dem Backup-Pfad extrahiert.

.PARAMETER BackupRoot
Pfad zu einem Backup-Verzeichnis.

.PARAMETER HelpMode
Zeigt die Hilfe an.
Alias: h, ?

.EXAMPLE
.\03_Restore_Settings.ps1 -BackupRoot "D:\SystemRekonstruktion_Backup\D5P0 20260612_1530"

.NOTES
Registry-Import bleibt manuell.
#>

[CmdletBinding()]
param(
    [string]$BackupRoot,
    [Alias("h","?")]
    [switch]$HelpMode
)

if ($HelpMode) {
    Get-Help $PSCommandPath -Full
    exit 0
}

if (!(Test-Path $BackupRoot)) {
    Write-Host "BackupRoot nicht gefunden"
    exit 1
}

$folderName = Split-Path $BackupRoot -Leaf
$SystemName = $folderName.Split(" ")[0]

. "$PSScriptRoot\00_Common.ps1" -SystemName $SystemName

$settingsDir = Join-Path $BackupRoot "settings"
$registryDir = Join-Path $BackupRoot "registry"

$profileRoot = [Environment]::GetFolderPath("UserProfile")
$roamingDest = Join-Path $profileRoot "AppData\Roaming"
$localDest = Join-Path $profileRoot "AppData\Local"
$programDataDest = "C:\ProgramData"

Write-Log "Restore AppData Roaming"
robocopy (Join-Path $settingsDir "AppData_Roaming") $roamingDest /MIR /R:2 /W:5 | Out-Null

Write-Log "Restore AppData Local"
robocopy (Join-Path $settingsDir "AppData_Local") $localDest /MIR /R:2 /W:5 | Out-Null

Write-Log "Restore ProgramData"
robocopy (Join-Path $settingsDir "ProgramData") $programDataDest /MIR /R:2 /W:5 | Out-Null

Write-Log "Registry-Dateien zur manuellen Pruefung:"
Get-ChildItem $registryDir -Filter "*.reg" | ForEach-Object {
    Write-Log $_.FullName
}

Write-Log "Settings-Restore abgeschlossen"
