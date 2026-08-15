# Workspace_AI Lifecycle Model Requirements

Module: LCM-Proposal/Requirements.md
Purpose: Defines normative requirements for the proposed Workspace_AI Lifecycle Model.
Path: docs/LCM-Proposal/Requirements.md
Authors: Workspace_AI documentation proposal
Version: 0.1.0
Status: Proposal
Date: 2026-08-15

## 1. Scope and Conformance

This document specifies lifecycle governance requirements for Workspace_AI itself and for any target repository operated on through a Workspace_AI method instance.

An LCM operation is conformant only when:

- all applicable `MUST` and `MUST NOT` requirements are satisfied;
- every approved exception is explicit, scoped, reasoned, and recorded;
- required evidence is stored by the owning repository;
- an unsupported transition is blocked rather than approximated.

Conformance is assessed per operation. Repository location under `D:\Git_Repositories` alone does not grant eligibility or permission.

## 2. Governance Authority

### LCM-REQ-001 - Single Canonical Authority

The LCM MUST identify one canonical root for rules, methods, state, and governance logs. Mirrors and adapters MUST identify their canonical source and regeneration method. They MUST NOT become independent rule authority.

Acceptance evidence: an authority declaration with canonical paths, precedence, mirror policy, and conflict behavior.

### LCM-REQ-002 - Unambiguous Precedence

The LCM MUST define one precedence order for workspace rules, agents, repository rules, documentation, and generated adapters. A conflict MUST stop the affected operation or produce an explicit review gate; it MUST NOT be resolved silently.

Acceptance evidence: a validation result showing no contradictory authority declarations, or a recorded blocking conflict.

### LCM-REQ-003 - Stable Workspace Identity

Active control files MUST identify the current method baseline as Workspace_AI. Legacy Workspace_AI identifiers MAY remain in historical evidence or compatibility interfaces only when clearly labeled.

Acceptance evidence: an identity scan with each legacy reference classified as active, compatibility, historical, or defect.

### LCM-REQ-004 - Repository-Local Overrides

A repository-local rule MAY override the method baseline only when the override is a confirmed repository requirement. The override MUST identify the baseline rule, reason, scope, owner, and review decision before taking effect.

Acceptance evidence: a target-local override record and workspace-level warning or approval record.

## 3. Lifecycle State Model

### LCM-REQ-010 - Explicit State

Every repository considered by the LCM MUST have one explicit operational state:

| State | Permitted activity |
|---|---|
| `discovered-only` | Identity discovery only. |
| `blocked-do-not-operate` | No governance, analysis, proposal, or modification operation. |
| `candidate` | Selection and eligibility checks; no dry-run or writes. |
| `read-only-dry-run` | Approved observation and analysis only. |
| `external-intake` | Structure, place incoming evidence, analyze, and propose; stop for review. |
| `cleanup-candidate` | Assess and propose cleanup actions only. |
| `active-governed` | Apply only the currently accepted step and its required verification. |
| `retired` | No further operation except status or historical inspection. |

Unknown or missing state MUST be treated as non-operable.

### LCM-REQ-011 - Guarded Transitions

A state transition MUST record source state, target state, repository identity, reason, operator decision, timestamp, and applicable preflight result. Selection MUST NOT imply dry-run approval, and dry-run approval MUST NOT imply write approval.

Acceptance evidence: a durable transition record and a state validation result.

### LCM-REQ-012 - Current Write Boundary

The current LCM MUST block general write-enabled adaptation of target repositories. A write-capable transition MUST NOT be inferred from candidate selection, method-instance creation, dry-run activation, action preview, or proposal acceptance.

Acceptance evidence: state and action-plan output reporting `write_allowed: false` or its equivalent.

### LCM-REQ-013 - Per-Step Acceptance

Promotion, implementation, and destructive cleanup MUST require an explicit user `Accept` decision for the current step. Rejection or modification MUST leave later steps blocked. Bundled multi-step acceptance MUST NOT be the default.

Acceptance evidence: a decision record tied to the exact proposal, files, action, and verification step.

## 4. Ownership and Artifact Placement

### LCM-REQ-020 - Baseline and Instance Separation

Workspace_AI MUST own generic rules, method definitions, templates, and validators. Each target repository MUST own its target-specific method state, dry-run outputs, proposals, logs, results, exceptions, and acceptance decisions.

Acceptance evidence: a target-local method manifest and absence of target-specific work products in the baseline repository.

### LCM-REQ-021 - Target-Local Method Structure

An ordinary target repository method instance MUST use this minimum structure unless an approved repository override exists:

```text
Docs/Methods/
Docs/Methods/DryRun/
Docs/Methods/Logs/
Docs/Methods/Results/
Docs/Methods/Proposals/
Docs/Methods/MethodInstance.json
```

Method initialization MUST require explicit approval and MUST NOT stage, commit, or modify unrelated files.

### LCM-REQ-022 - Human-Reviewable Proposal Authority

Target-repository proposals MUST be Markdown-first review artifacts under `Docs/Methods/Proposals/`. Optional machine-readable sidecars MUST be derived from the reviewed Markdown, MUST identify that source, and MUST be considered stale whenever the Markdown changes.

Acceptance evidence: a reviewed Markdown proposal and, when present, a matching generated sidecar.

### LCM-REQ-023 - Proposal Lifecycle

A proposal MUST have a stable identifier and an explicit disposition of `pending`, `accepted`, `rejected`, `modified`, or `superseded`. An accepted proposal MUST remain pending implementation until its implementation and verification are accepted. A void proposal SHOULD then be removed from the working queue without removing durable evidence.

Acceptance evidence: proposal metadata, implementation evidence, final decision, and cleanup result.

## 5. Analysis and Change Control

### LCM-REQ-030 - Documentation-First Impact Analysis

Before implementation, the LCM MUST identify affected requirements, documentation, source, modules, interfaces, installation behavior, tests, and governance controls. Documentation changes MUST be proposed before or together with implementation changes.

Acceptance evidence: an impact analysis linked to the change proposal.

### LCM-REQ-031 - No Invented Behavior

Automation MUST NOT invent missing product behavior, silently infer requirements, or treat incoming external code as authority. Ambiguity MUST produce a question, explicit assumption for review, or blocked result.

### LCM-REQ-032 - Interface Completeness

When a parameter, accepted value, default, schema, or behavior contract changes, the same accepted change set MUST update all affected callers, callees, launchers, help, documentation, and chain-level tests. A partial migration MUST be blocked.

Acceptance evidence: an impact list and verification covering each interface hop.

### LCM-REQ-033 - Destructive Action Isolation

A delete, move, replacement, or cleanup action MUST identify its exact target and expected effect and MUST receive a dedicated acceptance decision. Preview and scanner tools MUST remain non-destructive.

## 6. Safety and Integrity

### LCM-REQ-040 - Protected Paths

The LCM MUST support explicit protected paths. Discovery MAY report them, but selection, analysis, proposal generation, adapter comparison, and modification MUST be blocked while protection is active.

### LCM-REQ-041 - Cost-Tiered Preflight

Integrity checks MUST be event-triggered and cost-tiered. The first pass SHOULD use path existence, Git root, branch, HEAD, and short status. Expensive checks MUST require a trigger or ambiguous cheap result and MUST be announced before execution.

### LCM-REQ-042 - No Hidden Monitoring

The LCM MUST NOT perform hidden periodic scans, write probes, repository-wide hashes, or automatic repair. A detected restore, import, copy, or Git inconsistency MUST stop normal operation and produce a diagnostic path.

### LCM-REQ-043 - External Recovery Boundary

The LCM MAY rely on Git, repository restore, or system backup for recovery. When no internal rollback exists, that limitation and the required recovery procedure MUST be documented before a write-capable workflow is enabled.

## 7. Determinism and Technical Standards

### LCM-REQ-050 - Deterministic Operation

Given the same controlled inputs and repository state, an automated LCM operation MUST produce the same classification, plan, and generated content. Time, repository HEAD, operator decisions, and environment values used as inputs MUST be recorded when they affect output.

### LCM-REQ-051 - File Standards

Generated or modified Windows-native text MUST follow the active file-type rule. The current baseline requires UTF-8 without BOM and CRLF for PowerShell and deterministic JSON output; CMD files require ASCII-compatible deterministic content and CRLF unless an approved exception states otherwise.

### LCM-REQ-052 - PowerShell Contract

PowerShell controls MUST use PowerShell 7, valid advanced-script/function structure, explicit parameters, explicit error behavior, and no hidden dependency on caller scope. Trace mode, when offered, MUST report meaningful decisions and paths.

### LCM-REQ-053 - Metadata and Versioning

Governance artifacts MUST declare purpose, path, owner or authors, version, and change history where their active format requires it. Versions MUST use `MAJOR.MINOR.PATCH`; breaking structural changes increment MAJOR, compatible features increment MINOR, and corrections increment PATCH.

## 8. Validation, Evidence, and Audit

### LCM-REQ-060 - Readiness Gate

The method baseline MUST expose one public readiness command that validates active scripts, structured state, authority references, stabilization policy, and applicable quality gates. It MUST return a failing process status when a required check fails.

### LCM-REQ-061 - Before-and-After Verification

A significant accepted change MUST run the applicable focused check before broad promotion and MUST run the public readiness gate before final acceptance. Target-repository implementation MUST also run target-local tests required by the affected contract.

### LCM-REQ-062 - Evidence Integrity

Logs and result files MUST identify timestamp, repository, operation, inputs or assumptions, dry-run/write status, decision, outcome, and relevant artifact identifiers. Logs MUST be append-oriented or otherwise preserve prior accepted evidence.

### LCM-REQ-063 - Requirement Traceability

Each active requirement MUST map to at least one control and one verification method. Each control MUST identify the requirements it implements. Missing coverage MUST be reported as a gap, not as conformance.

### LCM-REQ-064 - Tool Failure Behavior

A validation, parser, state, or tool failure MUST block the dependent transition. Failure output MUST identify the failed control and a diagnostic next step. The LCM MUST NOT convert failure into success by skipping the control silently.

## 9. Review and Reconciliation

### LCM-REQ-070 - Controlled Documentation Editing

Normative documentation MUST change only through an explicitly identified documentation or Reconciliation Phase with manual review. The phase MUST define whether code is frozen, which trivial fixes remain allowed, and how the final documentation decision is recorded.

### LCM-REQ-071 - Proposal Does Not Imply Authority

A proposal MUST identify its status and MUST NOT override active rules until explicitly adopted. Adoption MUST include conflict reconciliation, version updates, validation, and a durable acceptance record.

### LCM-REQ-072 - Periodic Coverage Review

At a declared release or migration checkpoint, the LCM SHOULD review requirement-to-control coverage, stale compatibility names, unsupported transitions, stale proposal sidecars, and orphaned method artifacts.

## 10. Minimum Release Evidence

An LCM release or promoted governance checkpoint MUST provide:

1. the active requirement set and version;
2. the canonical authority declaration and precedence order;
3. a requirement-to-control matrix;
4. readiness output with a passing status;
5. unresolved gaps and accepted exceptions;
6. migration notes for changed schemas, commands, or paths;
7. a durable acceptance record.
