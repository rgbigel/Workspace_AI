# Catalog of Execution Errors & Failure Modes

Module: docs/Optimizations/Catalog-of-Errors-and-Failure-Modes.md  
Authors: Rolf, LCM_AI Engine  
Version: 1.0.0  
Status: Authoritative Analysis Document  
Date: 2026-09-28  

---

## 1. Executive Summary

During prolonged autonomous and paired execution sessions, transient automation scripts, ad-hoc shell commands, and background tasks frequently encounter recurring failure modes. This catalog documents the comprehensive taxonomy of execution errors observed across both the active session (`f0c912b4...`) and the preceding session (`d70cb53b...`), detailing their exact technical root causes and the required defensive engineering countermeasures.

---

## 2. Taxonomy of Observed Failure Modes

### Category A: Shell Quoting & CLI Interpolation Traps

#### 1. Pipeline Variable Stripping (`The term '.Property' is not recognized`)
* **Observed Errors**:
  * `.Name: The term '.Name' is not recognized as a name of a cmdlet, function, script file...` (`task-4463.log`, `task-9043.log`)
  * `.FullName: The term '.FullName' is not recognized...` (`task-555.log`)
  * `.id: The term '.id' is not recognized...` (`task-1734.log`)
  * `.MainWindowTitle: The term '.MainWindowTitle' is not recognized...` (`task-1868.log`)
* **Root Cause**:
  When invoking PowerShell inline via `pwsh -Command "..."` using double quotes, the outer shell (or invoking language runtime) expands `$_.Property` before passing the command to PowerShell. Because `$_` is not defined in the invoking shell context, it expands to an empty string, transforming `$_.Name` into the bare command `.Name`.
* **Countermeasure**:
  1. Always use single-quoted script blocks for outer CLI invocations: `pwsh -NoProfile -Command 'Get-ChildItem | ForEach-Object { $_.Name }'`.
  2. In nested or parameterized environments, escape the variable with a backtick: `` `$_.Name ``.
  3. Prefer self-contained `.ps1` scratch files in `scratch/` instead of complex multi-line inline CLI strings.

#### 2. Bare Assignment Stripping (`The term '=' is not recognized`)
* **Observed Errors**:
  * `= : The term '=' is not recognized as the name of a cmdlet, function, script file...` (`task-2865.log`, `task-3645.log`, `task-8151.log`)
* **Root Cause**:
  Executing `$myVar = Get-ChildItem` within double-quoted inline commands where `$myVar` expands to an empty string prior to execution, passing `= Get-ChildItem` as the statement.
* **Countermeasure**:
  Always use single quotes (`'...'`) for command line strings containing variable assignments, or escape variable prefixes (`` `$myVar = ... ``).

---

### Category B: PowerShell StrictMode & Variable Traps

#### 3. StrictMode Uninitialized Variable Traps (`VariableIsUndefined`)
* **Observed Errors**:
  * `The variable '$oldShortName' cannot be retrieved because it has not been set.`
  * Script termination in loops iterating over cleaned or conditionally defined arrays: `foreach ($dir in @($a, $b))`.
* **Root Cause**:
  `Set-StrictMode -Version Latest` combined with `$ErrorActionPreference = 'Stop'` converts any read of an uninitialized variable into an immediate fatal terminating error. When code is refactored to remove an obsolete variable, leaving references to that variable in subsequent array initializers or logging statements halts execution.
* **Countermeasure**:
  1. Always declare and initialize variables (`$target = $null` or `$list = @()`) before conditional blocks.
  2. Use `Get-Variable -Name 'varName' -ErrorAction SilentlyContinue` or `$PSBoundParameters.ContainsKey('param')` to test existence without triggering StrictMode.
  3. Validate AST before executing modified scripts using `[System.Management.Automation.Language.Parser]::ParseFile`.

---

### Category C: Process Lifecycle & File System Contention

#### 4. File Lock Violations during Runtime Cleanups (`SharingViolationException`)
* **Observed Errors**:
  * `The process cannot access the file because it is being used by another process` during catalog regeneration or log removal.
* **Root Cause**:
  Long-running background services (such as `LcmDesktopDaemon.ps1` listening on port 9876 or active file watchers) hold open read/write handles on `tool_catalog.json` or active log streams (`LcmDesktopDaemon-*.log`). Attempting to delete, overwrite, or truncate these files without cleanly stopping the owning background process causes sharing violations.
* **Countermeasure**:
  1. Check process ownership before mutating shared runtime resources:
     `Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'LcmDesktopDaemon' }`.
  2. Gracefully signal or terminate the daemon prior to structural migrations.
  3. Isolate runtime dynamic state into append-only or process-keyed log paths (`<Script>-<yyyyMMdd_HHmmss>.log`) to prevent multi-process handle contention.

#### 5. Elevated Dispatch Permission Boundaries (`Access is denied`)
* **Observed Errors**:
  * `Failed to dispatch interactive task 'LCM_DesktopDispatch_...': Access is denied.` (`task-3711.log`)
* **Root Cause**:
  Invoking scheduled task creation or cross-session interactive desktop dispatching (`Invoke-InteractiveDesktop.ps1`) from a standard un-elevated user context without delegating to `Start-ScriptProcessElevated.ps1`.
* **Countermeasure**:
  Strictly adhere to `ElevationPolicy.md` (`RULE-ELEV-001` - `006`). Privilege-requiring scripts must auto-detect elevation and route through the designated elevation runner rather than attempting direct privileged Task Scheduler mutations.

---

### Category D: Regex & String Parsing Traps

#### 6. Greedy / Repeated Capturing Group Duplication
* **Observed Errors**:
  * Runaway recursive prefixing in tool names: `LCMLCMLCMLCM...ClearBCReviewTemp.cmd`.
* **Root Cause**:
  Using `$name -replace "^($prefix)+", ""` inside a loop or trampoline generator. In regex, `($prefix)+` matches multiple repetitions, but captures only the *last* iteration into group 1. If replaced incorrectly or evaluated iteratively with string concatenation, prefixes multiply exponentially.
* **Countermeasure**:
  1. Use non-capturing groups for repetition: `^(?:$prefix)+`.
  2. In procedural string trimming, use a `while ($name.StartsWith($prefix)) { $name = $name.Substring($prefix.Length) }` loop for deterministic prefix removal.

---

### Category E: IDE Review Diff Stacking & Stale Buffer Overwrites

#### 7. Rapid Sequential Edits Causing Stacked Review Diff Overwrites
* **Observed Errors**:
  * Multiple overlapping "Accept" review banners for the same open document in the IDE editor tabs with ambiguous chronological ordering.
  * Risk of silent regression: accepting an older review diff snapshot flushes its intermediate state over the file on disk, obliterating newer edits made in subsequent tool calls.
  * Stale in-memory buffer race: saving an open editor tab containing pre-edit content overwrites the agent's disk modifications.
* **Root Cause**:
  When an agent makes rapid sequential modifications to the same file across successive turns (e.g. `LCM_Inventory\docs\Requirements.md`), the IDE creates separate pending diff review sessions for each edit against the editor's in-memory buffer. Because the editor does not automatically close or coalesce prior unaccepted diffs upon receiving a newer disk version, multiple review decorations accumulate. Accepting an older diff out of order executes a backward state flush.
* **Countermeasure**:
  1. **Atomic Edit Consolidation**: The agent `MUST` consolidate all modifications to a file into a single, comprehensive edit per turn, preventing rapid back-to-back edits on unreviewed buffers.
  2. **Fresh Disk Ingestion**: Before modifying any file that was recently touched, verify disk state against git working tree.
  3. **Auto-Save Hygiene**: Configure `"files.autoSave": "off"` in `.vscode/settings.json` to prevent background window-blur auto-saves from flushing stale editor buffers over freshly written files.

---

## 3. Systematic Corrective Rules Summary

| Error Pattern | Root Cause | Mandatory Defensive Pattern |
| :--- | :--- | :--- |
| `.Property: term not recognized` | Double-quote expansion of `$_` | Single quotes `'...'` for inline pwsh commands. |
| `= : term not recognized` | Double-quote expansion of `$var` | Single quotes `'...'` or escape `` `$var ``. |
| Undefined variable in StrictMode | `Set-StrictMode` on uninitialized vars | Explicit variable initialization and AST pre-flight checks. |
| Sharing violation on catalog/logs | Background daemon holding file handle | Inspect process handles before mutation; gracefully stop daemon. |
| Access denied on Task Scheduler | Un-elevated execution of system dispatch | Route through `Start-ScriptProcessElevated.ps1` (`RULE-ELEV-001`). |
| Recursive prefix multiplication | Regex capturing group repetition | Non-capturing group `^(?:$prefix)+` or explicit `StartsWith` loop. |
| Stacked IDE diffs & buffer clobber | Rapid sequential edits on open files | Atomic single-edit consolidation; `"files.autoSave": "off"`. |
