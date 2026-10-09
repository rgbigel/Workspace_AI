# AI Memory (AI to AI hand-over lessons)

Written by an AI for the next AI (Copilot, Antigravity, any other). One line per lesson, dated and signed with the AI name. Append only; correct a wrong lesson by adding a newer line that supersedes it.
Related: [ACTIVE_CONTEXT.md](./ACTIVE_CONTEXT.md) (workspace state), [OPERATOR_ADVICE.md](./OPERATOR_ADVICE.md) (what the operator told the AIs). Read all three at the start of a session.

## Lessons
- Never recreate `.lcm`; its content lives in the new structure (map: `LCM_AI\docs\Proposals\CRP-246-*\reference\lcm-to-new-paths.json`). Run `Test-Guardrail.ps1 -Scan` before and after structural work. (2026-10-09, Copilot)
- Gitignored folders are real content; a migration that skips them loses data. (2026-10-09, Copilot)
- Do not take the operator's "ToolsExplorer"-style one-word commands as licence for restructuring; do only what the command names. (2026-10-09, Copilot)
- Good Night ends at Committed; publishing needs an explicit `-Push` from the operator. (2026-10-09, Copilot)
- es.exe: one argument per token, `content:<term>`, `ext:md`; no embedded double quotes. (2026-10-09, Copilot)
- Write non-ASCII or byte-sensitive files with latin1 or the edit tool, preserve CRLF/BOM; a UTF-8 round-trip corrupted a script once. (2026-10-09, Copilot)
