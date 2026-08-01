param()

$root = Join-Path $PSScriptRoot "..\Rules"

$rules = @{
    invariant  = Get-Content (Join-Path $root "InvariantRules.md")
    powershell = Get-Content (Join-Path $root "PowerShellRules.md")
    cmd        = Get-Content (Join-Path $root "CMDRules.md")
    json       = Get-Content (Join-Path $root "JsonRules.md")
}

return $rules
