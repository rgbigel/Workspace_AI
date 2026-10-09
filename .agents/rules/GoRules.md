<!--
================================================================================
FILE NAME      : GoRules.md
DOCUMENT ID    : LCM-RULE-GO-001
REPOSITORY     : LCM_AI
LOCATION       : "D:\Git_Repositories\LCM_AI\.agents\rules\GoRules.md"
DESCRIPTION    : Automated AI agent governance directive and strict coding
                 constraints for Go source code generation and refactoring.
AUTHOR         : Rolf
DATE CREATED   : 2026-10-08
LAST MODIFIED  : 2026-10-08
VERSION        : 1.0.0
ENCODING       : ASCII (No BOM)
================================================================================
CHANGE LOG:
2026-10-08 - v1.0.0: Initial release of automated Go coding rules for IDE agents.
================================================================================
-->

---
description: Automated code generation and refactoring rules for Go source files.
globs: ["**/*.go"]
alwaysApply: true
---

# Directive for AI Agents: Go Code Generation Standards

You are operating as an automated coding engine within this workspace. When generating, updating, or refactoring Go source files, you MUST strictly adhere to the following rules without exception.

## 1. Mandatory File Header Block
Every `.go` file generated must start with this exact comment structure prior to the `package` statement. Compute the filename, date (YYYY-MM-DD), and description accurately:

/*
================================================================================
FILE NAME      : <filename>.go
PACKAGE        : <packagename>
DESCRIPTION    : <precise description of file responsibility>
AUTHOR         : Rolf
DATE CREATED   : <YYYY-MM-DD>
LAST MODIFIED  : <YYYY-MM-DD>
VERSION        : 1.0.0
GO VERSION     : 1.22+
ENCODING       : ASCII (No BOM)
================================================================================
CHANGE LOG:
<YYYY-MM-DD> - v1.0.0: Initial implementation.
================================================================================
*/

## 2. Automated Generation Constraints

### 2.1 Error Handling & Control Flow
- NEVER ignore returned errors. Discarding errors via `_ = fn()` is strictly forbidden for I/O, OS, processes, and network operations.
- ALWAYS wrap errors using `%w` when bubbling errors up boundaries:
  `return fmt.Errorf("<context>: %w", err)`
- NEVER access fields or defer cleanup methods on returned objects before validating that `err == nil`.
- NEVER generate `panic()` in application logic or libraries. Restrict panics solely to package-level initialization (`regexp.MustCompile`).

### 2.2 Resource Discipline
- NEVER generate `defer` statements inside loop iterations. Extract the loop body into an explicit helper function or handle close calls imperatively.
- Defer calls requiring dynamic or exit-time arguments MUST be enclosed in anonymous closures:
  `defer func() { ... }()`

### 2.3 Memory, Slices & Types
- NEVER take the address of the loop value variable (`&item`) in a `range` loop. Always index the slice directly: `&items[i]`.
- When generating structs that serialize to JSON arrays, initialize empty slices with `make([]T, 0)` so they serialize to `[]` instead of `null`.
- Structs containing `sync.Mutex` or `sync.RWMutex` MUST always use pointer receivers (`func (s *Service) ...`). Never pass mutexes by value.

### 2.4 Windows OS & Platform Rules
- NEVER concatenate filesystem paths with string operators (`+` or `fmt.Sprintf`). Always use `filepath.Join(...)`.
- NEVER pass unsanitized single-string command lines to shells. Always pass discrete argument slices using `exec.CommandContext(ctx, name, arg1, arg2, ...)`.
- All generated files must be plain ASCII without UTF Byte Order Marks (BOM).