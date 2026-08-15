# ============================================
# File: 04_Rebuild_System.ps1
# Module: SystemReconstruction
# Purpose: Reinstalls software from package lists
# Path: tools/04_Rebuild_System.ps1
# Authors: Rolf, Copilot
# Version: 1.0.0
# Changelog:
#   1.0.0 - Initial version translated to English per workspace invariant
# ============================================

<#
.SYNOPSIS
Rebuild of software installation. Version 1.0.0

.DESCRIPTION
Reinstalls WinGet, Chocolatey, and pip packages from a BackupRoot directory.
The system name is automatically extracted from the backup path.

.PARAMETER BackupRoot
Path to the backup directory.

.PARAMETER HelpMode
Displays help information.
Alias: h, ?

.EXAMPLE
.\04_Rebuild_System.ps1 -BackupRoot "D:\SystemRekonstruktion_Backup\D5P0 20260612_1530"

.NOTES
Chocolatey and pip optional.
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

$packagesDir = Join-Path $BackupRoot "packages"

$wingetPath = Join-Path $packagesDir "packages_winget.json"
$chocoPath = Join-Path $packagesDir "packages_choco.txt"
$pipPath = Join-Path $packagesDir "packages_pip.txt"

if (Test-Path $wingetPath) {
    Write-Log "Installing WinGet packages"
    winget import --import-file $wingetPath --accept-source-agreements --accept-package-agreements
}

if (Test-Path $chocoPath -and (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Log "Installing Chocolatey packages"
    $pkgs = Get-Content $chocoPath | Where-Object { 
        $pkgLine = $_
        $pkgLine -and ($pkgLine -notmatch "packages found") 
    }
    foreach ($p in $pkgs) {
        $name = $p.Split()[0]
        Write-Log "choco install $name"
        choco install $name -y --ignore-checksums | Out-Null
    }
}

if (Test-Path $pipPath -and (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Log "Installing pip packages"
    pip install -r $pipPath | Out-Null
}

Write-Log "Rebuild completed"
