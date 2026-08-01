param([hashtable]$rules)

foreach ($key in $rules.Keys) {
    if (-not $rules[$key] -or $rules[$key].Count -eq 0) {
        throw "Rule set '$key' is empty or missing."
    }
}

"OK"
