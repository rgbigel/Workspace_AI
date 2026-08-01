# ============================================
# File: 01_Export_Paketquellen.ps1
# Module: SystemRekonstruktion
# Purpose: Exportiert Paketlisten fuer WinGet, Chocolatey und pip
# Path: scripts/01_Export_Paketquellen.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Exportiert Paketlisten fuer Rebuild. Version 1.0.0

.DESCRIPTION
Erzeugt ein System- und Zeitstempel-spezifisches Paketbackup unter:
D:\SystemRekonstruktion_Backup\<Systemname> <Timestamp>\packages\

.PARAMETER HelpMode
Zeigt die Hilfe an.
Alias: h, ?

.EXAMPLE
.\01_Export_Paketquellen.ps1

.NOTES
Erfordert WinGet 1.4+, optional Chocolatey/pip.
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
    Write-Log "Paketverzeichnis erstellt: $packagesDir"
}

$WinGetFile = Join-Path $packagesDir "packages_winget.json"
$ChocoFile = Join-Path $packagesDir "packages_choco.txt"
$PipFile = Join-Path $packagesDir "packages_pip.txt"

Write-Log "Exportiere WinGet-Pakete"
try {
    winget export --output $WinGetFile --include-versions --accept-source-agreements --accept-package-agreements
} catch {
    Write-Log "Fehler bei WinGet-Export: $_" "ERROR"
}

if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Log "Exportiere Chocolatey-Pakete"
    choco list --local-only | Out-File -FilePath $ChocoFile -Encoding ASCII
} else {
    Write-Log "Chocolatey nicht gefunden" "WARN"
}

if (Get-Command pip -ErrorAction SilentlyContinue) {
    Write-Log "Exportiere pip-Pakete"
    pip list --format=freeze | Out-File -FilePath $PipFile -Encoding ASCII
} else {
    Write-Log "pip nicht gefunden" "WARN"
}

Write-Log "Paketexport abgeschlossen"
