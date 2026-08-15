# ATOM-Building

Module: ATOM-Building.md
Purpose: Defines workspace documentation and operational rules for ATOM-Building.
Path: D:/Git_Repositories/Workspace_AI/.github/agents/ATOM-Building.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

## 1. Purpose
Functional atoms are the smallest stable units of behavior inside modules. They enable predictable module design, cross-repo reuse, independent versioning, deterministic testing, and clean separation of concerns. Atoms form the foundation of SharedModules.

## 2. Definition of a Functional Atom
A functional atom is a minimal, deterministic function that:
- has one responsibility
- has a stable interface
- has no hidden dependencies
- is side-effect-free unless explicitly designated as a logging atom
- returns structured data or performs one controlled effect
- can be reused across repositories without modification

## 3. Preconditions for Atom Creation
A function qualifies as an atom only if all of these are true:

### 3.1 Single Responsibility
The function must do exactly one thing. If it does two things, split it.

### 3.2 Deterministic Behavior
Given the same inputs, it must always produce the same outputs.

### 3.3 Stable Interface
Parameters and return types must not change across repositories.

### 3.4 No Hidden State
Atoms must not rely on global variables, implicit module state, or environment-dependent values.

### 3.5 No Side Effects (except logging atoms)
Atoms must not write output, modify files, or modify system state. Logging atoms are the only exception.

### 3.6 Reusability
The atom must be useful in at least one other repository.

## 4. Identifying Atoms in Existing Code
Use these detection rules:

### 4.1 Repeated Logic
If a pattern appears in multiple places or repositories, it is an atom.

### 4.2 Verb-Noun Naming
Atoms naturally emerge around verbs such as `Get-DiskFacts`, `Classify-GPTType`, `Format-TableRow`, `Write-TraceLog`.

### 4.3 Mini-Pipelines
If a function internally gathers, transforms, and returns data, it is an atom.

### 4.4 Cross-Repo Candidates
If a function would be useful in multiple repositories, it is an atom.

## 5. Atom Categories

### 5.1 Discovery Atoms
Pure collectors that return raw facts.

### 5.2 Evaluation Atoms
Pure rule engines that transform raw facts into interpreted facts.

### 5.3 Reporting Atoms
Formatters and controlled side-effect functions.

### 5.4 SharedModules Atoms
Cross-repository utilities.

## 6. Atom Interface Specification
Every atom must define:
- a deterministic verb-noun name
- minimal, explicit, typed parameters
- a stable return type
- a side-effect policy (`Pure`, `Logging`, or `Formatting`)
- a version number

## 7. Atom Validation Checklist
Before accepting a function as an atom, validate:
- single responsibility
- deterministic output
- stable interface
- no hidden state
- correct side-effect policy
- cross-repo reusability

If any check fails, the function is not an atom.

## 8. Atom Placement
Atoms must be placed according to their category:
- Discovery atoms → `Modules/Discovery`
- Evaluation atoms → `Modules/Evaluation`
- Reporting atoms → `Modules/Reporting`
- Shared atoms → `SharedModules/Modules`

## 9. Atom Documentation
Each atom must have:
- a one-sentence purpose
- parameter list
- return type
- side-effect declaration
- usage example
- version number

## 10. Atom Lifecycle
Atoms evolve independently:
- new atoms can be added
- old atoms can be deprecated
- interfaces remain stable
- SharedModules atoms propagate across repositories
