# Architecture & Design Specification: LCM Deterministic Hook Engine

- **Module**: `Workspace_AI / LCM Governance`
- **Authors**: Rolf, Workspace_AI Engine
- **Version**: 1.0.0
- **Status**: Proposed / Design Specification
- **Date**: 2026-09-01
- **Domain**: Governance, Security, and Deterministic Enforcement

---

## 1. Executive Summary & Problem Statement

In an autonomous agentic development environment, natural language instructions and system prompts (declarative policies) provide behavioral guidance, but cannot provide mathematical or mechanical guarantees against drift, hallucinations, or accidental policy violations (such as unauthorized Git commits/pushes, UTF-8 BOM injection, cross-repository boundary breaches, or unreviewed destructive changes).

The **LCM Deterministic Hook Engine** introduces a deterministic execution boundary implemented through Antigravity/Gemini native hook lifecycles (`PreToolUse`, `PostToolUse`, `SessionStart`, `SessionResume`). It acts as a zero-trust gatekeeper that validates every tool invocation and payload before execution, rejecting non-compliant actions with actionable feedback to the agent.

---

## 2. Architecture & Interception Flow

```mermaid
graph TD
    AGENT["AI Agent (Antigravity)"] -->|Requests Tool Call<br/>(e.g., run_command, write_to_file)| HOOK_PRE["PreToolUse Hook Handler<br/>(Enforce-LcmPreToolPolicy.ps1)"]
    
    subgraph Deterministic_Validation ["Deterministic Policy Engine"]
        V_GIT["Commit & Push Gating<br/>(RULE-REV-001)"]
        V_BOUND["Repository Boundary Isolation<br/>(REPO-CONTEXT)"]
        V_ENC["Encoding Invariant (UTF-8 No BOM, CRLF)<br/>(INVARIANT-RULES)"]
        V_ELEV["Privilege & Elevation Guard<br/>(RULE-ELEV-001)"]
    end

    HOOK_PRE --> V_GIT
    HOOK_PRE --> V_BOUND
    HOOK_PRE --> V_ENC
    HOOK_PRE --> V_ELEV

    V_GIT -->|Pass| EXEC["Tool Execution Engine"]
    V_BOUND -->|Pass| EXEC
    V_ENC -->|Pass| EXEC
    V_ELEV -->|Pass| EXEC

    V_GIT -->|Block| REJECT["Deterministic Rejection<br/>(Returns Detailed Governance Error)"]
    V_BOUND -->|Block| REJECT
    V_ENC -->|Block| REJECT
    V_ELEV -->|Block| REJECT

    REJECT --> AGENT

    EXEC --> HOOK_POST["PostToolUse Hook Handler<br/>(Enforce-LcmPostToolPolicy.ps1)"]
    HOOK_POST --> AUDIT[("Audit Ledger<br/>(logs/hooks_audit.log)")]
    HOOK_POST --> LINT["Syntax & AST Lint Verification"]
    LINT --> AGENT
```

---

## 3. Core Hook Event Handlers

### 1. `PreToolUse` Lifecycle Handler (`Enforce-LcmPreToolPolicy.ps1`)
Intercepts all tool requests prior to execution:
* **Tool: `run_command`**:
  * **Git Guard**: Scans command string for `git commit` or `git push`. If a visual review gate (`Invoke-BeyondCompareReview.ps1`) has not recorded an `ACCEPTED` disposition in `Workspace_Inventory/data/reviews/`, the command is **blocked deterministically**.
  * **CD Prohibition Guard**: Blocks bare `cd` commands per shell invariant.
  * **Destructive Deletion Guard**: Blocks recursive forced deletions (`rmdir /s /q`, `rm -rf`) outside `scratch/` directories unless approved.
* **Tools: `write_to_file`, `replace_file_content`, `multi_replace_file_content`**:
  * **Boundary Guard**: Verifies target file is within valid workspace repositories and obeys repository boundary encapsulation (`REPO-CONTEXT`).
  * **Encoding & Formatting Guard**: Checks content for UTF-8 without BOM and Windows CRLF (`\r\n`) newlines.

### 2. `PostToolUse` Lifecycle Handler (`Enforce-LcmPostToolPolicy.ps1`)
Executes immediately following tool execution:
* **Syntax & AST Validator**: If a `.ps1` or `.py` file was modified, runs an instant non-destructive AST parser / linter (`PSScriptAnalyzer` or Python AST) and warns if syntax errors were introduced.
* **Audit Logger**: Appends execution telemetry to `Workspace_Inventory/logs/hooks_audit.log`.

### 3. `SessionStart` / `SessionResume` Handler (`Invoke-LcmSessionAudit.ps1`)
* Verifies health of all `.agents/rules` junctions across child repositories.
* Audits system hardware invariants (AMD ULPS, DWM MPO=5, PowerToys FindMyMouse=False, 54/54 Logitech suppressions).

---

## 4. Configuration Manifest: `.agents/hooks.json`

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "version": "1.0.0",
  "hooks": {
    "PreToolUse": [
      {
        "name": "LCM-Governance-PreToolGuard",
        "description": "Enforces review-gated commits, zero-trust boundary validation, and encoding invariants.",
        "command": "pwsh.exe",
        "args": [
          "-NoProfile",
          "-ExecutionPolicy", "Bypass",
          "-File", "D:/Git_Repositories/tools/hooks/Enforce-LcmPreToolPolicy.ps1"
        ],
        "timeoutSeconds": 5
      }
    ],
    "PostToolUse": [
      {
        "name": "LCM-Governance-PostToolAudit",
        "description": "Performs AST syntax verification and records deterministic audit logs.",
        "command": "pwsh.exe",
        "args": [
          "-NoProfile",
          "-ExecutionPolicy", "Bypass",
          "-File", "D:/Git_Repositories/tools/hooks/Enforce-LcmPostToolPolicy.ps1"
        ],
        "timeoutSeconds": 5
      }
    ],
    "SessionStart": [
      {
        "name": "LCM-Session-Initializer",
        "description": "Validates repository junctions and hardware invariants on startup.",
        "command": "pwsh.exe",
        "args": [
          "-NoProfile",
          "-ExecutionPolicy", "Bypass",
          "-File", "D:/Git_Repositories/tools/hooks/Invoke-LcmSessionAudit.ps1"
        ],
        "timeoutSeconds": 10
      }
    ]
  }
}
```

---

## 5. Implementation Roadmap & Milestones

1. **Phase 1 (Core PreToolUse Engine)**: Implement `Enforce-LcmPreToolPolicy.ps1` with Git commit/push gating and boundary validation.
2. **Phase 2 (AST & Quality PostToolUse)**: Implement `Enforce-LcmPostToolPolicy.ps1` with real-time PowerShell and Python AST linting.
3. **Phase 3 (Session Invariant Auditing)**: Implement `Invoke-LcmSessionAudit.ps1` to audit NTFS junctions and hardware invariants.
4. **Phase 4 (Manifest & Integration)**: Deploy `.agents/hooks.json` and register into global Antigravity config (`C:\Users\rgbig\.gemini\config\hooks.json`).
