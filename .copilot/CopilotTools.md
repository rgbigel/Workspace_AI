# CopilotTools

Module: CopilotTools.md
Purpose: Defines workspace documentation and operational rules for CopilotTools.
Path: D:/Git_Repositories/Workspace_AI/.copilot/CopilotTools.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

TOOLS-CATEGORY: search-tools
TOOLS-ENTRY
- name: everything.exe
- type: search-indexer
- path: "D:\\Tools\\Everything 1.5a\\Everything.exe"
- alternate_path: "D:\\Tools\\Everything\\Everything.exe"
- usage: fast file search; content indexing enabled for D:\Git_Repositories
- version: 1.5.0.1418b (x64)+
- notes: Target production path is D:\Tools\Everything\Everything.exe

TOOLS-ENTRY
- name: es.exe
- type: cli-search
- path: "D:\\Tools\\Everything 1.5a\\es.exe"
- alternate_path: "D:\\Tools\\Everything\\es.exe"
- usage: command-line search; Everything IPC pipe (\\.\pipe\Everything IPC)
- version: 1.5.0.1418b (x64)+

TOOLS-CATEGORY: diff-tools
TOOLS-ENTRY
- name: BeyondCompare5
- type: diff-merge
- path: "D:\\Tools\\Beyond Compare 5\\BCompare.exe"
- usage: file diff, folder diff, merge tool; LCM visual review
- version: 5.0.0

