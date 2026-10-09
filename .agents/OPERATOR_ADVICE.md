# Operator Advice (durable know-how)

Short, tested tips from the operator. Agents read this before using the tool concerned, and append new advice here (one line each, with date). Rules stay in `rules/`; this file holds hints, not obligations.

## Working agreement
- For a large or complex query or repair, describe the intended approach and ask the operator first; the operator often knows a faster trick. (2026-10-09)

## Everything / es.exe
- `ext:md` is faster than `.md`. (2026-10-09)
- Pass one argument per token: `es -n 5 D:\Git_Repositories ext:json content:Shell`. A single combined string or embedded double quotes finds nothing. (2026-10-09)
- Multi-word content terms: `content:<two words>`. (2026-10-09)
- A backslash escapes special characters in a query. (2026-10-09)
- `,` works as a list separator in es.exe; `;` should but probably does not (mixed-language settings). (2026-10-09)
- Content changes reach the index with a delay, usually under 1 second. (2026-10-09)
