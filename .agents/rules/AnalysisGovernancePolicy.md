---
name: AnalysisGovernancePolicy
description: Authoritative analysis governance policy enforcing model-first read-only analysis protocol, provenance tagging, search fencing, implementation gating, and circuit breaker recovery.
globs: "*"
---
# File: AnalysisGovernancePolicy.md

Module: AnalysisGovernancePolicy  
Purpose: Defines modal separation between Read-Only Analysis and Governed Implementation, intent wake words, provenance tagging, search fencing, circuit breaker protocol, and Control Hub runtime state transparency.  
Path: .agents/rules/AnalysisGovernancePolicy.md  
Authors: Rolf, LCM_AI Engine  
Version: 9.0.0  
Status: Authoritative Invariant Rule  
Date: 2026-10-05  

---

## 1. Purpose & Motivation

In the Lifecycle Model (LCM), unconstrained speculative code modifications and premature implementations lead to architectural regressions and drift.

To establish predictable, disciplined pair-programming collaboration, this policy institutes strict modal separation between **READ-ONLY ANALYSIS** and **GOVERNED IMPLEMENTATION**. This guarantees that complex investigations produce verified, model-first analytical foundations before any source code, configuration, or governance files are modified.

---

## 2. Invariant Rules

### RULE-ANA-000 (Step 0 Rule-Baseline Equivalence Gate)
1. **Mandatory First Step**: Before beginning Level 1 or any later LCM analysis level, the analyst `MUST` compare the active `.copilot/Rules/` rule source with the authoritative `LCM_AI/.agents/rules/` source.
2. **Linkage Verification**: The comparison `MUST` verify the active rule directory's resolved junction or symbolic-link target when present. It `MUST` also compare the complete Markdown rule filename set and SHA-256 content hash of every corresponding file.
3. **Result Marker**: Record the result at the start of the analysis artifact as exactly one of:
   - `Check 0: OK` — linkage, filename set, and all hashes match.
   - `Check 0: not found` — the active or authoritative rule directory cannot be read.
   - `Check 0: mismatch` — linkage, filename set, or one or more hashes differ.
4. **Failure Gate**: `Check 0: not found` or `Check 0: mismatch` `MUST` halt downstream code-versus-documentation comparisons. The report `MUST` identify the divergent paths and defer all later results until the operator resolves the rule baseline.
5. **Artifact Requirement**: Retained analysis artifacts and their visualizations `MUST` include the active path, authoritative path, linkage result, compared rule count, mismatch count, and `Check 0` marker.

### RULE-ANA-001 (Intent Wake Word Gating & Read-Only Analysis Lock)
1. **`ANALYZE` Wake Word**: When an operator prompt or session begins with the intent wake word **`ANALYZE`**, the AI assistant and runtime environment are immediately locked into **`READ_ONLY_ANALYSIS`** mode.
2. **Strict Tool Restriction**: While in `READ_ONLY_ANALYSIS` mode, file modification tools (`write_to_file`, `replace_file_content`, `multi_replace_file_content`), destructive shell commands, and Git mutation commands (`git commit`, `git push`, `git merge`, `git checkout`) are **STRICTLY PROHIBITED**.
3. **Model-First Mandate**: The AI must first formulate a structured mental or formal model defining:
   - Entities involved in the problem domain
   - State variables and lifecycles
   - Allowed actions and state transitions
   - Constraints, assumptions, and boundary conditions
4. **No Premature Solutions**: The agent `MUST NOT` produce concrete code diffs or commit proposals during this phase.
5. **Operational Scope (Review Gates & Suggested State)**: Operating in `READ_ONLY_ANALYSIS` mode is explicitly expected during the initial `suggested` proposal state and whenever execution is paused at lifecycle review gates (Gate 1 Planning Gate per `RULE-LCM-014` and Gate 2 Visual Review Gate per `RULE-REV-001`). During these checkpoints, analysis and structured reasoning precede code mutation.

---

### RULE-ANA-002 (Provenance Tagging & 4-Part Output Contract)
During active `READ_ONLY_ANALYSIS`, all generated responses must adhere to the 4-part analytical output contract:

1. **Structured Model Formulation**: High-level definition of domain entities, state variables, invariants, and boundaries.
2. **Evidence & Findings with Provenance Tags**: Every empirical statement must include explicit verifiable provenance:
   - `[VERIFIED: <filepath#line>]`: Empirically confirmed by reading the current working copy or AST.
   - `[INFERRED]`: Deductions logically derived from verified facts but not directly asserted in text.
   - `[GAP: <missing_data>]`: Unconfirmed points, missing specifications, or unverified assumptions.
3. **State Delta & Settled Facts**: Explicit recording of newly settled facts (`LCM_SettledFacts`) and retired hypotheses.
4. **Interactive Decision Gate**: Each analytical turn `MUST` conclude with exactly 2 to 3 actionable, structured choices (`Option A`, `Option B`, `Option C`) and pause execution for explicit human operator steering.

---

### RULE-ANA-003 (Search Radius Fencing Standard)
1. **Fenced Discovery Radius**: When performing searches in `READ_ONLY_ANALYSIS` mode, search depth `MUST NOT` exceed `2` filesystem levels from the designated target component root (`LCM_SearchRadius = 2`).
2. **Match Capping**: File searches and grep queries must cap results to prevent unconstrained token floods (maximum 3 primary matches per query).
3. **Target Component Anchoring**: Searches must strictly originate from the specific repository or subsystem component directory under investigation, never traversing speculative relative paths across unrelated sibling repositories.

---

### RULE-ANA-004 (Implementation Transition & Phase Exclusion)
1. **`IMPLEMENT` Transition Word**: The session transitions from `READ_ONLY_ANALYSIS` to **`GOVERNED_IMPLEMENTATION`** solely upon receipt of the explicit operator transition word **`IMPLEMENT`** (or approval commands such as `do <ID>`).
2. **Path Binding**: Governed implementation `MUST` strictly follow and execute the consensus path, architecture decisions, and options settled during the prior `ANALYZE` phase.
3. **Phase Exclusion Invariant**: During active `READ_ONLY_ANALYSIS`, the formulation, staging, or execution of Implementation CRPs or code modification directives is **STRICTLY FORBIDDEN**.

---

### RULE-ANA-005 (Circuit Breaker Protocol & Resumption Gate)
1. **Automatic Trip Conditions**: If during `GOVERNED_IMPLEMENTATION`, the agent or runtime discovers:
   - An assumed API parameter, function, or symbol does not exist;
   - An environment path, configuration, or dependency is inaccessible;
   - The implementation requires invalidating an earlier verified consensus or constraint;
   Execution `MUST HALT IMMEDIATELY`. Guessing, speculative patching, or unverified workarounds are strictly forbidden.
2. **Immediate Mode Drop**: The session automatically transitions from `GOVERNED_IMPLEMENTATION` to **`CIRCUIT_BREAKER_HALT`** and drops back into `READ_ONLY_ANALYSIS`.
3. **Mandatory Output Header**: The assistant must output the standard circuit breaker notification:

```markdown
### [ANALYSIS RESUMED] - Implementation Block Encountered
Status: Implementation Halted | Reason: Ambiguity / Constraint Mismatch

1. Encountered Block
* [GAP / CONFLICT]: <Exact technical mismatch or undefined parameter>.
* Source Context: <File or component where divergence occurred>.

2. Impact on Previous Consensus
* Invalidation: <Why the previously chosen path cannot proceed as drafted>.

3. Recommended Next Steps (Decision Gate)
* Option A: <Alternative implementation branch addressing the gap>.
* Option B: <Re-open analysis of prerequisite components>.
* Option C: <Abort change and restore prior baseline>.
```
4. **Control Hub Flag**: The circuit breaker status is registered in the LCM Control Hub telemetry and halts execution runners until operator resolution.

---

### RULE-ANA-006 (Runtime State Telemetry & Control Hub Register Invariant)
The analysis engine and session runners must synchronize active governance variables to `active_session.json` and expose them to the LCM Control Hub:

| State Register | Type | Permitted Values | Enforcement & Display Rule |
|:---|:---|:---|:---|
| `LCM_OperatingMode` | String | `READ_ONLY_ANALYSIS`, `GOVERNED_IMPLEMENTATION`, `CIRCUIT_BREAKER_HALT` | Displayed in Control Hub topbar/status rail. If `READ_ONLY_ANALYSIS`, execution dispatchers reject write operations. |
| `LCM_ActiveGate` | String | `STEP_001` .. `STEP_nnn` | Identifies current node in the interactive decision DAG. |
| `LCM_SearchRadius` | Integer | Integer $\le 2$ (Default `2`) | Fences ripgrep / search tool exploration depth. |
| `LCM_SettledFacts` | Array[String] | Array of IDs (e.g. `["F-001", "F-002"]`) | Prevents redundant rediscovery of settled facts. |
| `LCM_OpenHypotheses`| Array[String] | Array of IDs (e.g. `["HYP-001", "HYP-002"]`) | Tracks open hypotheses currently under investigation. |
| `LCM_CircuitBreaker`| Boolean | `true`, `false` | True when tripped; displays resumption block alert. |

---

### RULE-ANA-007 (Analysis Evidence Artifact Retention Invariant)
1. **Persistent Analysis Artifacts**: Tool-generated inventories, correlation reports, evidence tables, and intermediate datasets that are required for a subsequent refinement step or analysis level `MUST` be stored in the active session workspace under `files/`, not in an ephemeral temporary directory.
2. **Retention Window**: An analysis artifact `MUST NOT` be deleted merely because one analysis level has concluded. Retain it until the operator explicitly requests disposal or the dependent refinement and follow-on analysis levels have completed.
3. **Regeneration Provenance**: If an artifact is lost and regenerated from current inputs, the regenerated artifact `MUST` record its generation timestamp, source scope, and deterministic generation method. It `MUST NOT` be represented as the original artifact.
4. **Refinement Accessibility**: When an analysis report is intended for operator review or a later refinement, provide a compact visualization derived from the retained machine-readable artifact. The visualization may summarize branch-level evidence but `MUST` preserve the source location and ordered check outcomes for every reported named functional element.

### RULE-ANA-008 (Level 1 Branch Refinement & Definition Separation)
1. **Definition and Evidence Separation**: A consistency analysis `MUST` store approved, operator-editable intent in a definition artifact and machine-generated findings in immutable run artifacts. Evidence artifacts `MUST NOT` be manually edited to redefine an analysis.
2. **Identifier Convention**: A definition uses `CON-nnn-Lnn`; its ordered steps use `CON-nnn-Lnn-Smmm`; each retained generated run uses `CON-nnn-Lnn-Rnnn`. A refinement `MUST` produce a new run and preserve its prior run.
3. **Public Parameter Gates**: Level 1 conditions that test parameters of public commands or exported module functions are documentation-traceable. The runner `MUST` record referenced public parameters and apply the ordered check hierarchy from `RULE-ANA-000`.
4. **Purpose and Design Comments**: Strong nearby comments that state a purpose, rationale, invariant, rule, safety boundary, gate, contract, compatibility constraint, design decision, or policy are semantic evidence. Deterministic literal matching `MUST NOT` claim semantic equivalence; unresolved semantic evidence is marked for semantic review.
5. **Internal Control Flow**: Conditions that only operate on local implementation state, iteration, cleanup, serialization, diagnostics, or other non-public mechanics are retained as navigational evidence but excluded from top-level documentation-completeness discrepancies.
6. **Parse-Limitation Transparency**: When AST construction reports unresolved cross-file type references but returns an AST, the runner `MAY` continue with that AST only after recording the source and limitation in the generated evidence/log. Any syntax or structural parser failure `MUST` halt the run.
7. **Alternative Branch Coverage**: For an `IfStatementAst`, the runner `MUST` retain a distinct branch record for its initial `if` condition and every `elseif` condition. Each condition record `MUST` include a stable branch kind and zero-based branch index. An `else` clause `MUST` be retained as an explicit fallback record with no predicate; it `MUST NOT` be classified as a public parameter documentation failure solely because an earlier conditional branch references a public parameter. Each branch record `MUST` retain the source extent of its enclosed body so Level 1 can analyze branch-contained functional elements with the same classification rules.
8. **Parameter-Presence Safety Nets**: A condition that tests only whether a public parameter is present, absent, null, empty, or whitespace is a safety-net mechanic, not a documentation-relevance gate. It is retained as navigational evidence and its enclosed body remains analyzable. A condition that combines parameter presence with any other state, value, authorization, or environmental predicate remains documentation-traceable.
9. **Deferred Control Constructs**: `try` / `catch` / `finally`, `trap`, and `switch` are separate control constructs. They require an explicit later definition revision and `MUST NOT` be inferred from the alternative-branch model.

### RULE-ANA-009 (Analysis Run Provenance & Retention)
1. **Immutable Run Location**: Generated evidence runs `MUST` be stored under `LCM_Inventory/data/analysis/history/`; only approved, operator-editable definitions reside under `LCM_Inventory/data/analysis/definitions/`.
2. **Immutable Provenance Minimum**: Every run `MUST` record its analysis and run identifiers, generation timestamp, definition path, definition version and SHA-256, baseline-evidence path and SHA-256, runner version, source scope, Step 0 rule-baseline result, matching method, parse limitations, summary counts, and per-element evidence.
3. **No Overwrite Rule**: A runner `MUST` calculate the next available `Rnnn` identifier by default and reject any attempt to overwrite an existing evidence artifact.
4. **Regenerable Presentation Artifacts**: HTML views, Markdown projections, and session-local copies are temporary visualizations. They `MAY` be deleted after the corresponding canonical JSON evidence has been retained and verified.
5. **Major-Release Cleanup**: At major release $M$, remove superseded, unreferenced analysis evidence older than the $M-2$ retention horizon. Preserve an evidence run when it is referenced by an active, completed, published, or permanent-evolution CRP/ledger record. Retain the active definition and its versioned history irrespective of this cleanup.
