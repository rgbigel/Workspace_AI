# Implementation Plan for Post-Restructruring Checks

Module: docs/Optimizations/Implementation-Plan-for-Post-Restructruring-Checks.md
Authors: GitHub Copilot
Version: 1.0.0
Status: Proposed Implementation Plan
Date: 2026-09-29

---

## 1. Purpose

This plan implements the findings in `Post-Restructruring-Checks.md`. Its goal is to make the rule-junction topology, Git ownership, discovery documentation, and whitespace quality gates consistent before a governance commit.

## 2. Scope and Decision

### In Scope

- Make `Workspace_AI` the only Git owner of canonical files under `.agents\rules`.
- Preserve the existing physical junction topology, which already resolves rules correctly.
- Synchronize the root quick reference and cross-reference matrix with `Workspace_AI\.agents\rules` as the canonical rule hub.
- Remove unintended trailing whitespace from changed files.
- Re-run non-mutating structural, syntax, JSON, catalog, launcher, and whitespace checks.

### Out of Scope

- Changing rule semantics.
- Rebuilding the tool catalog or executing mutating readiness workflows.
- Moving tool implementations between repository targets.
- Committing, pushing, or launching Beyond Compare review.

### Required Ownership Decision

`Workspace_AI` is the canonical physical rule host and the sole repository permitted to track `.agents\rules` files. `Workspace_Inventory` retains only its `.agents\rules` junction and must not retain those paths in its Git index.

## 3. Implementation Steps

### Step 1: Capture Pre-Change Evidence

1. Record `git status --short` for the root workspace, `Workspace_AI`, and `Workspace_Inventory`.
2. Record the current junction targets for:
   - `D:\Git_Repositories\.agents`
   - `Workspace_Inventory\.agents\rules`
   - `Workspace_Supervision\.agents\rules`
3. Record the list of rules tracked by each authority repository and their overlap.

Success condition: the evidence confirms that the physical targets already converge on `Workspace_AI\.agents\rules` and identifies the Git-index overlap to remove.

### Step 2: Remove Duplicate Rule Tracking from Workspace_Inventory

1. Confirm that every `Workspace_Inventory\.agents\rules` file is supplied by the existing junction to `Workspace_AI\.agents\rules`.
2. Remove only `.agents\rules` paths from the `Workspace_Inventory` Git index while preserving the live junction and target files.
3. Add `.agents\rules/` to `Workspace_Inventory/.gitignore` so the junctioned files cannot be re-added to its Git index.
4. Do not remove or rewrite files in `Workspace_AI\.agents\rules`.
5. Verify that `git -C Workspace_Inventory ls-files .agents/rules` returns no canonical rule files, `check-ignore` matches the junctioned rule files, and `git -C Workspace_AI ls-files .agents/rules` remains complete.

Success condition: rule content remains visible through the `Workspace_Inventory` junction, but only `Workspace_AI` tracks canonical rule files.

### Step 3: Synchronize Authority Documentation

Update these documentation entrypoints in the same change set:

1. `Workspace_AI/docs/LCM-Rules-Cross-Reference.md`
   - Replace the obsolete `Workspace_Inventory\.agents\rules` physical-authority statement with `Workspace_AI\.agents\rules`.
   - Update the authority diagram and any related explanatory prose.
   - Update baseline/version and date metadata to reflect the authority migration.
2. `D:\Git_Repositories/AGENTS.md`
   - Verify that its quick-reference wording and topology section identify `Workspace_AI` as the canonical physical host.
   - Correct any remaining references that identify `Workspace_Inventory` as the rule source rather than its consumer junction.
3. `Workspace_AI/.agents/rules/RuleAuthority.md`
   - Verify its wording still matches the final junction implementation; edit only if the final topology differs from its existing `Workspace_AI` declaration.

Success condition: all discovery entrypoints name `Workspace_AI\.agents\rules` as the canonical physical hub, and no entrypoint claims `Workspace_Inventory` is the physical rule host.

### Step 4: Normalize Whitespace

1. Remove trailing whitespace from changed root files:
   - `.lcm/docs/README.md`
   - `.lcm/tools/hub/Show-Subsystems.ps1`
2. Remove unintended trailing whitespace from changed `Workspace_AI` files:
   - `AGENTS.md`
   - `.agents/rules/ProposalReviewFlowPolicy.md`
3. Remove unintended trailing whitespace from `Workspace_Inventory/data/proposals/proposals.json` and its changed rule file.
4. Preserve UTF-8 without BOM and CRLF line endings.

Success condition: `git diff --check` passes independently in the root workspace, `Workspace_AI`, and `Workspace_Inventory`.

## 4. Verification Plan

Run the following read-only checks after implementation:

1. Resolve the root and child `.agents\rules` junction targets and confirm convergence on `Workspace_AI\.agents\rules`.
2. Compare `git ls-files .agents/rules` in `Workspace_AI` and `Workspace_Inventory`; overlap must be zero.
3. Parse all changed standalone PowerShell files with the PowerShell AST parser.
4. Import `LcmDaemon.psm1` to validate daemon class-loading order.
5. Parse changed JSON files with `ConvertFrom-Json`.
6. Validate every `.lcm/config/tool_catalog.json` target exists and every short name has a matching `.lcm/Cmd/<ShortName>.cmd` launcher.
7. Run `git diff --check` in all three affected repositories.
8. Validate edited text files are UTF-8 without BOM with CRLF line endings.

## 5. Review Gate

This document is a plan only. Do not execute the implementation steps, run mutating readiness tools, stage files, commit, push, or initiate the visual review workflow until the plan is explicitly approved.