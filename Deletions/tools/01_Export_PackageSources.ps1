# ============================================
# File: 01_Export_PackageSources.ps1
# Module: SystemReconstruction
# Purpose: Exports package lists for WinGet, Chocolatey, and pip
# Path: tools/01_Export_PackageSources.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version translated to English per workspace invariant
# ============================================

<#
.SYNOPSIS
Exports package lists for system rebuild. Version 1.0.0

.DESCRIPTION
Generates a system- and timestamp-specific package backup under:
D:\SystemRekonstruktion_Backup\<SystemName> <Timestamp>\packages\

.PARAMETER HelpMode
Displays help information.
Alias: h, ?

.EXAMPLE
.\01_Export_PackageSources.ps1

.NOTES
Requires WinGet 1.4+, optional Chocolatey/pip.
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

$packagesDir = Join-Path $Global:SR_SystemRoot "packages"
if (!(Test-Path $packagesDir)) {
    New-Item -Path $packagesDir -ItemType Directory -Force | Out-Null
    Write-Log "Package directory created: $packagesDir"
}

$WinGetFile = Join-Path $packagesDir "packages_winget.json"
$ChocoFile = Join-Path $packagesDir "packages_choco.txt"
$PipFile = Join-Path $packagesDir "packages_pip.txt"

Write-Log "Exporting WinGet packages"
try {
    winget export --output $WinGetFile --include-versions --accept-source-agreements --accept-package-agreements
} catch {
    Write-Log "Error during WinGet export: $_" "ERROR"
}

if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Log "Exporting Chocolatey packages"
    choco list --local-only | Out-File -FilePath $ChocoFile -Encoding ASCII
} else {
    Write-Log "Chocolatey not found" "WARN"
}

if (Get-Command pip -ErrorAction SilentlyContinue) {
    Write-Log "Exporting pip packages"
    pip list --format=freeze | Out-File -FilePath $PipFile -Encoding ASCII
} else {
    Write-Log "pip not found" "WARN"
}

Write-Log "Package export completed"
