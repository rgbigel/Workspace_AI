# SystemRekonstruktion

Module: README.md
Purpose: Defines workspace documentation and operational rules for README.
Path: D:/Git_Repositories/Workspace_AC/docs/README.md
Authors: Rolf
Version: 1.0.0
Changelog:
- 2026-07-27: Normalized Markdown metadata header.

Dieses Repository enthaelt Skripte zur vollautomatischen Sicherung und Rekonstruktion
von Windows-Systemen in Multi-Boot-Umgebungen.

## Komponenten

- Paketlisten-Export (WinGet, Chocolatey, pip)
- Settings-Backup (AppData, ProgramData, Registry)
- Automatischer Rebuild nach Clean-Install
- Logging
- Multi-Boot-Pfadlogik
- Runtime-Skripte unter D:\cmd
- Workspace_GC real-repository dry-run cases: [real-repo-dry-run.md](real-repo-dry-run.md)

## Phasen

### Sicherung
- 01_Export_Paketquellen.ps1
- 02_Backup_Settings.ps1

### Wiederherstellung / Rebuild
- 03_Restore_Settings.ps1
- 04_Rebuild_System.ps1

### Setup
- 90_Setup_Runtime.ps1

Alle Skripte unterstuetzen das Flag `-h` fuer Hilfe.
