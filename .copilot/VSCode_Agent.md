# Name: VSCode_Agent
# Version: 1.0.0
# Path: .copilot/VSCode_Agent.md
# Purpose: Define the execution model for fix-modules inside Workspace_GC.

=====================================================================
AGENT OVERVIEW
=====================================================================
The Workspace_GC agent executes fix-modules defined in:
    .copilot/Fixes/

Execution is triggered via:
    APPLY <module-name>

The agent resolves:
    .copilot/Fixes/<module-name>.json

The ".json" suffix is optional.

=====================================================================
MODULE RESOLUTION
=====================================================================
Resolution rules:
- Case-insensitive match.
- No fallback search outside .copilot/Fixes.
- No auto-generation of missing modules.
- No execution of seed files.

=====================================================================
MODULE STRUCTURE REQUIREMENTS
=====================================================================
Each fix-module must contain:

meta.module
meta.path
meta.version
meta.config_type
meta.description
meta.authors
meta.changelog

id
type
scope
requires
actions
logging

Missing fields cause immediate abort.

=====================================================================
EXECUTION PIPELINE
=====================================================================
1. Load Atoms
2. Load Methods
3. Load Rules
4. Load Fix module
5. Execute actions sequentially
6. Write log file

Atoms, Methods, Rules are resolved from:
    .copilot/Atoms/
    tools/
    .copilot/Rules/

=====================================================================
SUPPORTED ACTION TYPES
=====================================================================
normalize-script-header
normalize-json
normalize-cmd
apply-invariants
quality-check

No other action types are supported.

=====================================================================
TARGET RESOLUTION
=====================================================================
Targets use glob patterns:
    *.ps1
    *.json
    *.cmd
    **/*

Resolution is relative to the workspace root:
    Workspace_GC/

=====================================================================
LOGGING
=====================================================================
Logs are written to:
    .copilot/Logs/<module-name>.log

Log format:
- timestamp
- action id
- target file
- rule applied
- result

=====================================================================
SAFETY RULES
=====================================================================
- No deletion of files.
- No regeneration of folders.
- No overwriting unless rule explicitly modifies content.
- Seed files must not be executed.

=====================================================================
MULTI-MODULE EXECUTION
=====================================================================
Multiple modules may be executed sequentially:
    APPLY Fix_S1E01
    APPLY Fix_S1EQ
    APPLY Fix_Atomic

No implicit chaining unless defined in a wrapper module.

=====================================================================
END OF FILE
=====================================================================
