<#
.SYNOPSIS
    Initializes a central Python 3.14 virtual environment for D:\Git_Repositories,
    installs core automation & Google Antigravity dependencies, and configures .gitignore.
#>

$ErrorActionPreference = "Stop"

# Define Paths
$PythonBaseExe   = "D:\Tools\Python314\python.exe"
$RepoRoot        = "D:\Git_Repositories"
$VenvDir         = Join-Path -Path $RepoRoot -ChildPath ".venv"
$VenvPythonExe   = Join-Path -Path $VenvDir -ChildPath "Scripts\python.exe"
$GitIgnorePath   = Join-Path -Path $RepoRoot -ChildPath ".gitignore"

# Ensure base Python exists
if (-not (Test-Path -Path $PythonBaseExe)) {
    Write-Error "Python 3.14 was not found at '$PythonBaseExe'. Please verify the installation path."
    exit 1
}

# Ensure repository root directory exists
if (-not (Test-Path -Path $RepoRoot)) {
    New-Item -ItemType Directory -Path $RepoRoot -Force | Out-Null
    Write-Host "[+] Created directory: $RepoRoot" -ForegroundColor Cyan
}

# 1. Create .venv if it does not already exist
if (-not (Test-Path -Path $VenvPythonExe)) {
    Write-Host "[*] Creating shared .venv using Python 3.14..." -ForegroundColor Cyan
    & $PythonBaseExe -m venv $VenvDir
    Write-Host "[+] Virtual environment created at $VenvDir" -ForegroundColor Green
} else {
    Write-Host "[i] Virtual environment already exists at $VenvDir" -ForegroundColor Yellow
}

# 2. Upgrade pip, setuptools, and wheel
Write-Host "[*] Upgrading pip, setuptools, and wheel..." -ForegroundColor Cyan
$BootstrapPackages = @("pip", "setuptools", "wheel")
& $VenvPythonExe -m pip install --upgrade $BootstrapPackages

# 3. Install core libraries and Google Antigravity SDK
Write-Host "[*] Installing required SDK and automation packages..." -ForegroundColor Cyan
$TargetPackages = @(
    "google-antigravity",
    "pydantic",
    "requests",
    "httpx",
    "pyyaml",
    "websockets"
)
& $VenvPythonExe -m pip install $TargetPackages

# 4. Ensure .gitignore excludes .venv from Git tracking
Write-Host "[*] Updating root .gitignore..." -ForegroundColor Cyan
$IgnoreEntries = @(
    "# Central Python Virtual Environment",
    ".venv/",
    "__pycache__/",
    "*.pyc"
)

if (Test-Path -Path $GitIgnorePath) {
    $CurrentContent = Get-Content -Path $GitIgnorePath
    foreach ($Entry in $IgnoreEntries) {
        if ($CurrentContent -notcontains $Entry) {
            Add-Content -Path $GitIgnorePath -Value $Entry
        }
    }
} else {
    Set-Content -Path $GitIgnorePath -Value $IgnoreEntries
}

Write-Host "[+] Root .gitignore configured." -ForegroundColor Green
Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host "Shared Python Interpreter : $VenvPythonExe"
Write-Host "To activate in PS7       : & '$VenvDir\Scripts\Activate.ps1'"