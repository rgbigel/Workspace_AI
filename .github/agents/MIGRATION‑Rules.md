# MIGRATION-Rules

Module: MIGRATION-Rules.md
Purpose: Defines workspace documentation and operational rules for MIGRATION-Rules.
Path: D:/Git_Repositories/Workspace_AI/.github/agents/MIGRATION-Rules.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

## 1. Purpose
Define unified rules for cleaning, normalizing, and migrating repositories. Combine invariant rules, module rules, SharedModules rules, atom rules, ACTIONS.md rules, and inventory rules.

## 2. Scope
Applies to all repositories under D:\Git_Repositories. Covers cleanup, normalization, atom discovery, SharedModules reuse, atom promotion, ACTIONS.md generation, inventory updates, and migration execution.

## 3. Migration Workflow
Migration is executed repo-by-repo.

Steps:
1. Load MIGRATION-Rules
2. Load ATOM-Building
3. Load SharedModules rules
4. Load invariant rules
5. Generate or open ACTIONS.md
6. Execute ACTIONS.md
7. Update MODULES_INVENTORY_REPORT.md
8. Commit changes
9. Continue with next repo

## 4. Repo Structure Rules
Required structure:
- /src
- /docs
- /contracts
- ACTIONS.md
- AGENTS.md

Required properties:
- deterministic script headers
- no backticks
- explicit $_ assignment
- stable naming
- stable versioning

## 5. Script Header Rules
Every CMD/PS1 file must contain:

<#
Module: <filename.ext>
Purpose: <one sentence>
Path: <relative path>
Authors: <list>
Version: <semantic version>
Changelog:
  - <entry>
#>

Placement:
- If param() exists ? header immediately after
- Otherwise ? header at top

## 6. Invariant Rules
- no backticks
- assign $_ to a variable before use
- correct header placement
- module names include extension
- headers use <# ... #>
- deterministic naming
- deterministic versioning

## 7. SharedModules Rules
SharedModules is the cross-repo utility library.

Migration must:
- detect reuse
- detect conflicts
- detect overrides
- promote atoms when appropriate
- maintain stable interfaces
- maintain versioned modules

Structure:
SharedModules/Modules/Discovery
SharedModules/Modules/Evaluation
SharedModules/Modules/Reporting

## 8. Atom Rules
Atoms follow ATOM-Building.

### 8.1 Definition
Atoms must be single-responsibility, deterministic, stable interface, no hidden state, pure (except logging atoms), reusable across repos.

### 8.2 Categories
Discovery, Evaluation, Reporting, SharedModules.

### 8.3 Validation
Check responsibility, determinism, interface stability, hidden state, side-effect policy, cross-repo reusability.

### 8.4 Placement
Modules/Discovery
Modules/Evaluation
Modules/Reporting
SharedModules/Modules

## 9. ACTIONS.md Rules
Every repo must have an ACTIONS.md containing:

### 9.1 Cleanup Steps
Normalize modules, apply invariant rules, apply header rules, classify modules, detect deprecated modules, detect missing documentation.

### 9.2 Atom Discovery
Identify standalone functions, evaluate atom criteria, classify atoms, flag SharedModules candidates.

### 9.3 SharedModules Reuse Analysis
Detect reuse, detect conflicts, detect overrides, recommend promotion.

### 9.4 Inventory Update Steps
Add atoms, add modules, mark deprecated modules, mark promoted atoms, update version numbers, update migration status.

### 9.5 Completion Criteria
Repo is migrated when modules normalized, atoms classified, SharedModules reuse resolved, inventory updated, documentation complete, versioning updated, ACTIONS.md marked complete.

## 10. Inventory Rules
Inventory file: D:\Git_Repositories\MODULES_INVENTORY_REPORT.md

Must track modules, atoms, SharedModules atoms, version numbers, repo migration status, atom promotion history, deprecated modules, reuse relationships.

Updated repo-by-repo during migration.

## 11. Repo Awareness
Repos inherit rules through:

### 11.1 Workspace .github/agents
MIGRATION-Rules.md is globally applied.

### 11.2 Repo AGENTS.md
Each repo must include:
rules:
  - ../../.github/agents/MIGRATION-Rules.md

### 11.3 ACTIONS.md
Generated using MIGRATION-Rules.

## 12. Migration Execution Model
Migration is manual-supervised and deterministic.

Steps:
1. Open repo
2. Open ACTIONS.md
3. Execute steps
4. Update inventory
5. Commit
6. Continue

Guarantees:
no premature migration, SharedModules grows only when needed, atoms discovered systematically, inventory consistent, migration reversible, migration traceable.

## 13. Versioning
Semantic versioning. Current version: 1.0.0
