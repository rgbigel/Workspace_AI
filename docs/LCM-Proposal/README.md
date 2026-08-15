# Workspace_AI Lifecycle Model Documentation Proposal

Module: LCM-Proposal/README.md
Purpose: Defines the scope, status, and adoption path of the proposed Workspace_AI Lifecycle Model documentation.
Path: docs/LCM-Proposal/README.md
Authors: Workspace_AI documentation proposal
Version: 0.1.0
Status: Proposal
Date: 2026-08-15

## Purpose

This proposal documents the current Workspace_AI Lifecycle Model (LCM) in two levels:

1. [Requirements](Requirements.md) defines the normative outcomes, constraints, lifecycle states, and acceptance conditions.
2. [Implementation and Tooling](Implementation-and-Tooling.md) identifies the artifacts, scripts, agents, state files, and quality gates that currently implement or support those requirements.

The separation is intentional. A requirement describes what the model must guarantee. An implementation entry describes how the current repository attempts to provide evidence for that guarantee.

## Proposal Status

These files are editable review artifacts. They do not replace or override the current authority chain while their status is `Proposal`.

Adoption requires an explicit review decision and reconciliation with the canonical governance files. Until then:

- `.copilot/Rules/` remains the rule source identified by `.copilot/Rules/RuleAuthority.md`.
- Existing lifecycle state files and tools retain their current behavior.
- No target-repository write capability is created by this proposal.
- A statement marked `Policy only`, `Partial`, or `Not supported` must not be represented as an enforced control.

## Documentation Model

The proposed LCM documentation uses these terms:

| Term | Meaning |
|---|---|
| `MUST` | Required for LCM conformance. |
| `MUST NOT` | Prohibited for LCM conformance. |
| `SHOULD` | Expected unless a documented exception is approved. |
| `MAY` | Optional behavior that does not weaken a requirement. |
| Requirement | A stable, testable statement identified by `LCM-REQ-*`. |
| Control | A rule, tool, review gate, or state constraint that implements a requirement. |
| Evidence | An inspectable artifact proving that a control ran or a decision occurred. |
| Method baseline | Generic lifecycle rules, templates, and validation logic owned by Workspace_AI. |
| Method instance | Target-local application of the baseline, including target-specific proposals, logs, results, and decisions. |

## Current Model Summary

The current LCM is a human-gated governance process with these major stages:

```text
discover
  -> classify
  -> select candidate
  -> prepare target-local method instance
  -> perform read-only analysis
  -> create documentation-first proposals
  -> review and accept one step
  -> implement the accepted step
  -> verify and record evidence
  -> accept or reject the result
  -> clean up void working proposals
```

The current Workspace_AI implementation supports incubation, stabilization, candidate selection, target-local method initialization, read-only dry-run, proposal review support, validation, and governance evidence. It does not provide a general write-enabled real-repository transition.

## Findings Requiring Reconciliation

The source set contains identity and authority conflicts that prevent it from serving as a single precise LCM specification without review:

1. Files in Workspace_AI still contain canonical `Workspace_AI` names and absolute paths.
2. `.copilot/Rules/RuleAuthority.md` identifies `.copilot/Rules/` as canonical, while `.github/agents/Workspace-Rules.md` places itself and the agent index above `.copilot` files.
3. `AGENTS.md` identifies `.copilot/Rules/` as canonical but links active rules under `.agents/rules/`.
4. Documentation is declared immutable outside Reconciliation Phase, while the concrete change-request flow requires approved documentation changes.
5. The per-step `Accept` gate is defined as policy, but its user interaction, durable decision schema, and failure behavior are not specified as one end-to-end protocol.
6. Existing names such as `Test-WorkspaceReadiness.ps1` and `WorkspaceQualityGates.psm1` preserve the previous model identity.

These conflicts are recorded as gaps. This proposal does not resolve them by choosing a winner implicitly.

## Proposed Adoption Sequence

1. Review the requirement language and assign an owner to every requirement.
2. Decide the canonical authority order and Workspace_AI identity migration policy.
3. Confirm which `Partial` and `Policy only` controls are acceptable for the next LCM version.
4. Reconcile current governance files during an explicitly approved Reconciliation Phase.
5. Add or update executable checks for requirements promoted to enforced status.
6. Run the readiness suite and retain the resulting evidence.
7. Change these files from `Proposal` to `Active` only through an explicit acceptance decision.

## Out of Scope

- Enabling writes to target repositories.
- Renaming existing tools or state schemas.
- Replacing historical logs.
- Automatically repairing stale Workspace_AI references.
- Defining product-specific requirements for repositories governed by the LCM.
