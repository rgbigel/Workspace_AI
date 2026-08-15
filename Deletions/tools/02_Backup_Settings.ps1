# ============================================
# File: 02_Backup_Settings.ps1
# Module: SystemReconstruction
# Purpose: Backs up AppData, ProgramData, and Registry hives
# Path: tools/02_Backup_Settings.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version translated to English per workspace invariant
# ============================================

<#
.SYNOPSIS
Backs up settings for system rebuild. Version 1.0.0

.DESCRIPTION
Generates a complete settings backup under:
D:\SystemRekonstruktion_Backup\<SystemName> <Timestamp>\settings\

.PARAMETER HelpMode
Displays help information.
Alias: h, ?

.EXAMPLE
.\02_Backup_Settings.ps1

.NOTES
Requires Administrator privileges.
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
        Write-Log "Directory created: $dir"
    }
}

$profileRoot = [Environment]::GetFolderPath("UserProfile")
$roaming = Join-Path $profileRoot "AppData\Roaming"
$local = Join-Path $profileRoot "AppData\Local"
$programData = "C:\ProgramData"

Write-Log "Backing up AppData Roaming"
robocopy $roaming (Join-Path $settingsDir "AppData_Roaming") /MIR /R:2 /W:5 | Out-Null

Write-Log "Backing up AppData Local"
robocopy $local (Join-Path $settingsDir "AppData_Local") /MIR /R:2 /W:5 | Out-Null

Write-Log "Backing up ProgramData"
robocopy $programData (Join-Path $settingsDir "ProgramData") /MIR /R:2 /W:5 | Out-Null

Write-Log "Exporting Registry"
reg export HKCU (Join-Path $registryDir "HKCU.reg") /y | Out-Null
reg export "HKLM\SOFTWARE" (Join-Path $registryDir "HKLM_SOFTWARE.reg") /y | Out-Null
reg export "HKLM\SYSTEM" (Join-Path $registryDir "HKLM_SYSTEM.reg") /y | Out-Null

Write-Log "Settings backup completed"
