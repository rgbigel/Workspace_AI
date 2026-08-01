# SharedModulesRule

Module: SharedModulesRule.md
Purpose: Defines workspace documentation and operational rules for SharedModulesRule.
Path: D:/Git_Repositories/Workspace_AC/.github/agents/SharedModulesRule.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

## 1. Purpose
Define deterministic rules for identifying, reusing, promoting, and maintaining SharedModules across repositories.

## 2. Scope
Applies to all repositories under D:\Git_Repositories. Used during migration, cleanup, atom discovery, and ACTIONS.md execution.

## 3. SharedModules Structure
SharedModules contains reusable cross-repo modules.

Structure:
SharedModules/Modules/Discovery
SharedModules/Modules/Evaluation
SharedModules/Modules/Reporting

## 4. Reuse Rules
A repo must reuse a SharedModule when:
- the interface matches
- the behavior matches
- the module is stable
- the module is versioned
- the module does not require repo-specific logic

Reuse is mandatory when compatibility is confirmed.

## 5. Override Rules
A repo may override a SharedModule only when:
- repo-specific behavior is required
- interface differences are necessary
- the SharedModule cannot be modified without breaking other repos

Overrides must be documented in ACTIONS.md.

## 6. Conflict Rules
Conflicts occur when:
- a repo has a module identical to a SharedModule
- a repo has a module partially overlapping with a SharedModule
- a repo has a module that should be promoted

Conflicts must be resolved during migration.

## 7. Promotion Rules
A repo module is promoted to SharedModules when:
- it is an atom
- it is reusable
- it has a stable interface
- it has no repo-specific dependencies
- it is used or needed in multiple repos

Promotion requires:
- interface validation
- version assignment
- placement in correct SharedModules category

## 8. Versioning Rules
SharedModules must use semantic versioning. Version increments occur when:
- interface changes
- behavior changes
- new atoms added
- deprecated atoms removed

## 9. ACTIONS.md Integration
ACTIONS.md must include:
- SharedModules reuse analysis
- SharedModules conflict detection
- SharedModules override justification
- SharedModules promotion candidates
- SharedModules version updates

## 10. Migration Requirements
During migration:
- detect SharedModules reuse
- detect SharedModules conflicts
- detect SharedModules overrides
- detect SharedModules promotion candidates
- update inventory
- update version numbers

## 11. Inventory Rules
Inventory must track:
- SharedModules atoms
- SharedModules modules
- version numbers
- promotion history
- reuse relationships
- conflicts
- overrides

## 12. Completion Criteria
SharedModules tasks are complete when:
- reuse resolved
- conflicts resolved
- overrides documented
- promotions completed
- inventory updated
- versioning updated
