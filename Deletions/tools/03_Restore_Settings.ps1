# ============================================
# File: 03_Restore_Settings.ps1
# Module: SystemReconstruction
# Purpose: Restores settings from backup
# Path: tools/03_Restore_Settings.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version translated to English per workspace invariant
# ============================================

<#
.SYNOPSIS
Restores settings. Version 1.0.0

.DESCRIPTION
Restores AppData, ProgramData, and registry files from a BackupRoot directory.
The system name is automatically extracted from the backup path.

.PARAMETER BackupRoot
Path to a backup directory.

.PARAMETER HelpMode
Displays help information.
Alias: h, ?

.EXAMPLE
.\03_Restore_Settings.ps1 -BackupRoot "D:\SystemRekonstruktion_Backup\D5P0 20260612_1530"

.NOTES
Registry import remains manual.
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
    Write-Host "BackupRoot not found"
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

Write-Log "Registry files for manual verification:"
Get-ChildItem $registryDir -Filter "*.reg" | ForEach-Object {
    $fileItem = $_
    Write-Log $fileItem.FullName
}

Write-Log "Settings restore completed"
