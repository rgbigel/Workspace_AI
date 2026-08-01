<#
    Validate-CopilotProfile.ps1
    version: 3.0.0
    FORMAT: ascii-only, technical, deterministic
#>

$root = "D:\Git_Repositories\.copilot"

$files = @(
    "instructions.md",
    "config.json",
    "agent.json",
    "copilot365-agent.json",
    "macro-definitions.md",
    "InvariantRules.md",
    "Standards.md",
    "MEMORY.md",
    "MyTools.md",
    "version-consistency-check.md",
    "version-bump-procedure.md",
    "problems.md",
    "projects.md",
    "servicing-notes.md"
)

Write-Host "COPILOT VALIDATION -- REAL RUN"
Write-Host "version: 3.0.0"
Write-Host ""

# CHECK 1 -- durable-memory integrity
Write-Host "CHECK: durable-memory integrity"
$missing = @()

foreach ($f in $files) {
    $path = Join-Path $root $f
    if (-not (Test-Path $path)) {
        $missing += $f
    }
}

if ($missing.Count -eq 0) {
    Write-Host "RESULT: PASS"
} else {
    Write-Host "RESULT: FAIL"
    Write-Host "Missing files:"
    $missing | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host ""

# CHECK 2 -- MAJOR version alignment
Write-Host "CHECK: MAJOR version alignment"

$versionInfo = @()

foreach ($f in $files) {
    $path = Join-Path $root $f
    $content = Get-Content $path -ErrorAction Stop

    $major = $null
    $full  = $null

    if ($f.ToLower().EndsWith(".json")) {
        $line = $content | Select-String '"version"' | Select-Object -First 1
        if ($line) {
            $text = $line.ToString().Trim()
            $parts = $text.Split(":")[1].Trim().Trim(',').Trim()
            $full  = $parts.Trim('"')
            $major = $full.Split(".")[0]
        }
    } else {
        $line = $content | Select-String "version:" | Select-Object -First 1
        if ($line) {
            $text = $line.ToString().Trim()
            $full  = $text.Split(":")[1].Trim()
            $major = $full.Split(".")[0]
        }
    }

    if (-not $major) {
        Write-Host "RESULT: FAIL"
        Write-Host "Missing version block in: $f"
        exit 1
    }

    $versionInfo += [PSCustomObject]@{
        File  = $f
        Major = $major
        Full  = $full
    }
}

$uniqueMajors = $versionInfo.Major | Select-Object -Unique

if ($uniqueMajors.Count -eq 1) {
    Write-Host "RESULT: PASS"
    Write-Host "MAJOR version = $($uniqueMajors[0])"
} else {
    Write-Host "RESULT: FAIL"
    Write-Host "Detected MAJOR version mismatch:"
    foreach ($v in $versionInfo) {
        Write-Host ("- {0} : {1}" -f $v.File, $v.Full)
    }
    exit 1
}

Write-Host ""

# CHECK 3 -- test-suite presence
Write-Host "CHECK: test-suite presence"

$testPath = "D:\Git_Repositories\.copilot\tests\profile-tests.md"

if (Test-Path $testPath) {
    Write-Host "RESULT: PASS"
} else {
    Write-Host "RESULT: FAIL"
    Write-Host "Missing: tests/profile-tests.md"
    exit 1
}

Write-Host ""

# CHECK 4 -- workspace-location
Write-Host "CHECK: workspace-location"

if ($root -eq "D:\Git_Repositories\.copilot") {
    Write-Host "RESULT: PASS"
} else {
    Write-Host "RESULT: FAIL"
    exit 1
}

Write-Host ""
Write-Host "FINAL RESULT: PASS"
