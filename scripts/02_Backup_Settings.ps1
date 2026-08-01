# ============================================
# File: 02_Backup_Settings.ps1
# Module: SystemRekonstruktion
# Purpose: Sichert AppData, ProgramData und Registry-Hives
# Path: scripts/02_Backup_Settings.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Sichert Settings fuer Rebuild. Version 1.0.0

.DESCRIPTION
Erzeugt ein vollstaendiges Settings-Backup unter:
D:\SystemRekonstruktion_Backup\<Systemname> <Timestamp>\settings\

.PARAMETER HelpMode
Zeigt die Hilfe an.
Alias: h, ?

.EXAMPLE
.\02_Backup_Settings.ps1

.NOTES
Erfordert Administratorrechte.
#>

[CmdletBinding()]
param(
    [Alias("h","?")]
    [switch]$HelpMode
)

if ($HelpMode) {
    Get-Help $PSCommandPath -Full
    exit 0
}

. "$PSScriptRoot\00_Common.ps1"

$settingsDir = Join-Path $Global:SR_SystemRoot "settings"
$registryDir = Join-Path $Global:SR_SystemRoot "registry"

foreach ($dir in @($settingsDir, $registryDir)) {
    if (!(Test-Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Log "Verzeichnis erstellt: $dir"
    }
}

$profileRoot = [Environment]::GetFolderPath("UserProfile")
$roaming = Join-Path $profileRoot "AppData\Roaming"
$local = Join-Path $profileRoot "AppData\Local"
$programData = "C:\ProgramData"

Write-Log "Sichere AppData Roaming"
robocopy $roaming (Join-Path $settingsDir "AppData_Roaming") /MIR /R:2 /W:5 | Out-Null

Write-Log "Sichere AppData Local"
robocopy $local (Join-Path $settingsDir "AppData_Local") /MIR /R:2 /W:5 | Out-Null

Write-Log "Sichere ProgramData"
robocopy $programData (Join-Path $settingsDir "ProgramData") /MIR /R:2 /W:5 | Out-Null

Write-Log "Exportiere Registry"
reg export HKCU (Join-Path $registryDir "HKCU.reg") /y | Out-Null
reg export "HKLM\SOFTWARE" (Join-Path $registryDir "HKLM_SOFTWARE.reg") /y | Out-Null
reg export "HKLM\SYSTEM" (Join-Path $registryDir "HKLM_SYSTEM.reg") /y | Out-Null

Write-Log "Settings-Backup abgeschlossen"
