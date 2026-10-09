# Learned Advice

Knowledge gained in sessions, by the operator or by any AI, kept so the next session starts with it. Part of the hand-over set with [ACTIVE_CONTEXT.md](./ACTIVE_CONTEXT.md) (workspace state). Governed by RULE-CTX-005.

How it works:
- `/learn <text>` (operator or AI) adds a **candidate**. Candidates are visible guidance but not binding.
- A review accepts, rejects or promotes each candidate. It happens no later than push: publishing is refused while candidates are pending.
- **Accepted** entries are binding for every AI. Entries marked `[->rule]` are to be moved into the rules.
- Append only; correct a wrong entry with a newer one that supersedes it.
- Tool: `LCM_Inventory\tools\Invoke-LearnedAdviceReview.ps1` (list, accept, reject, promote).

## Accepted

### Working agreement
- For a large or complex query or repair, describe the intended approach and ask the operator first; the operator often knows a faster trick. (2026-10-09, operator)
- Do not take a one-word command (such as ToolExplorer) as licence for restructuring; do only what the command names. (2026-10-09, Copilot)
- Never recreate `.lcm`; its content lives in the new structure (map: `LCM_AI\docs\Proposals\CRP-246-*\reference\lcm-to-new-paths.json`). Run `Test-Guardrail.ps1 -Scan` before and after structural work. (2026-10-09, Copilot)
- Gitignored folders are real content; a migration that skips them loses data. (2026-10-09, Copilot)
- Good Night ends at Committed; publishing needs an explicit `-Push` from the operator. (2026-10-09, Copilot)

### Everything / es.exe
- `ext:md` is faster than `.md`. (2026-10-09, operator)
- Pass one argument per token: `es -n 5 D:\Git_Repositories ext:json content:Shell`. A single combined string or embedded double quotes finds nothing. (2026-10-09, Copilot)
- Multi-word content terms: `content:<two words>`. (2026-10-09, Copilot)
- A backslash escapes special characters in a query. (2026-10-09, operator)
- `,` works as a list separator in es.exe; `;` should but probably does not (mixed-language settings). (2026-10-09, operator)
- Content changes reach the index with a delay, usually under 1 second. (2026-10-09, operator)

### Files
- Write byte-sensitive files with latin1 or the edit tool and keep CRLF/BOM; a UTF-8 round-trip corrupted a script once. (2026-10-09, Copilot)

## Candidates (pending review)
