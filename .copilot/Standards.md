# STANDARDS-METADATA
# version: 3.0.0
# scope: durable-memory
# location: Standards.md
# update-policy: manual
# FORMAT: ascii-only, technical, deterministic

STANDARDS
- naming: ascii-only, deterministic
- structure: sections, lists, code blocks
- documentation: reproducible, rule-driven
- modules: versioned, deterministic headers
- durable-memory: strict versioning required
- variable-memory: patch-only versioning

VERSIONING-STANDARDS
- MAJOR: breaking change, structural change
- MINOR: new feature, new durable-memory file
- PATCH: corrections, additions, revision-cycle
- durable-memory: increment on any change
- variable-memory: increment PATCH only
- version-parity: all control files share MAJOR
- version-format: MAJOR.MINOR.PATCH
