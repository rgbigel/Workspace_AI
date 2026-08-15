Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "   Antigravity / Python / IDE Environment Check       " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

# 1. Check Python 3.14 Base Installation
$BasePython = "D:\Tools\Python314\python.exe"
if (Test-Path $BasePython) {
    $BaseVer = & $BasePython --version 2>&1
    Write-Host "[OK] Base Python Found    : $BasePython ($BaseVer)" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Base Python Missing: $BasePython" -ForegroundColor Red
}

# 2. Check Shared .venv
$VenvPython = "D:\Git_Repositories\.venv\Scripts\python.exe"
if (Test-Path $VenvPython) {
    $VenvVer = & $VenvPython --version 2>&1
    Write-Host "[OK] Shared .venv Found   : $VenvPython ($VenvVer)" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Shared .venv Missing: $VenvPython" -ForegroundColor Red
}

# 3. Check Core Packages inside .venv
if (Test-Path $VenvPython) {
    $CheckPackages = @("google-antigravity", "pydantic", "requests", "httpx", "pyyaml", "websockets")
    $Installed = & $VenvPython -m pip list --format=json 2>$null | ConvertFrom-Json
    
    foreach ($Pkg in $CheckPackages) {
        $Found = $Installed | Where-Object { $_.name -eq $Pkg }
        if ($Found) {
            Write-Host "     + Package: $($Found.name) (v$($Found.version))" -ForegroundColor Gray
        } else {
            Write-Host "     - Package Missing: $Pkg" -ForegroundColor Yellow
        }
    }
}

# 4. Check Modern Python Launcher (py)
$PyCmd = Get-Command py -ErrorAction SilentlyContinue
if ($PyCmd) {
    $PySource = $PyCmd.Source
    Write-Host "[OK] Launcher Active      : $PySource" -ForegroundColor Green
} else {
    Write-Host "[WARN] 'py' command not found in PATH" -ForegroundColor Yellow
}

# 5. Check IDE User Settings JSON
$SettingsFile = "$env:APPDATA\Antigravity\User\settings.json"
if (-not (Test-Path $SettingsFile)) {
    # Fallback path if configured under Code-compatible profile
    $SettingsFile = "$env:APPDATA\Code\User\settings.json"
}

if (Test-Path $SettingsFile) {
    Write-Host "[OK] IDE Settings File   : $SettingsFile" -ForegroundColor Green
    try {
        $Json = Get-Content $SettingsFile -Raw | ConvertFrom-Json
        $Interp = $Json.'python.defaultInterpreterPath'
        if ($Interp -eq "D:\Git_Repositories\.venv\Scripts\python.exe") {
            Write-Host "     + defaultInterpreterPath correctly points to shared .venv" -ForegroundColor Gray
        } else {
            Write-Host "     - defaultInterpreterPath is '$Interp' (Expected: D:\Git_Repositories\.venv\Scripts\python.exe)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "     [WARN] JSON syntax error in settings.json" -ForegroundColor Red
    }
} else {
    Write-Host "[WARN] Could not automatically locate user settings.json" -ForegroundColor Yellow
}

Write-Host "======================================================" -ForegroundColor Cyan