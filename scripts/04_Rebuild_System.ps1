# ============================================
# File: 04_Rebuild_System.ps1
# Module: SystemRekonstruktion
# Purpose: Installiert Software aus Paketlisten neu
# Path: scripts/04_Rebuild_System.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version
# ============================================

<#
.SYNOPSIS
Rebuild der Softwareinstallation. Version 1.0.0

.DESCRIPTION
Installiert WinGet-, Chocolatey- und pip-Pakete aus einem BackupRoot neu.
Systemname wird automatisch aus dem Backup-Pfad extrahiert.

.PARAMETER BackupRoot
Pfad zum Backup-Verzeichnis.

.PARAMETER HelpMode
Zeigt die Hilfe an.
Alias: h, ?

.EXAMPLE
.\04_Rebuild_System.ps1 -BackupRoot "D:\SystemRekonstruktion_Backup\D5P0 20260612_1530"

.NOTES
Chocolatey und pip optional.
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

$packagesDir = Join-Path $BackupRoot "packages"

$wingetPath = Join-Path $packagesDir "packages_winget.json"
$chocoPath = Join-Path $packagesDir "packages_choco.txt"
$pipPath = Join-Path $packagesDir "packages_pip.txt"

if (Test-Path $wingetPath) {
    Write-Log "Installiere WinGet-Pakete"
    winget import --import-file $wingetPath --accept-source-agreements --accept-package-agreements
}

if (Test-Path $chocoPath -and (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Log "Installiere Chocolatey-Pakete"
    $pkgs = Get-Content $chocoPath | Where-Object { $_ -and ($_ -notmatch "packages found") }
    foreach ($p in $pkgs) {
        $name = $p.Split()[0]
        Write-Log "choco install $name"
        choco install $name -y --ignore-checksums | Out-Null
    }
}

if (Test-Path $pipPath -and (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Log "Installiere pip-Pakete"
    pip install -r $pipPath | Out-Null
}

Write-Log "Rebuild abgeschlossen"
