---
title: "OneDrive Sync Engine Diagnostic and Ghost Repair Runbook"
description: "Authoritative technical reference and runbook for diagnosing stuck OneDrive sync loops (0.0 KB remaining 100%), SQLite database inspection, and ghost queue remediation."
author: "Rolf, Workspace_AI Governance"
version: "1.0.0"
date: "2026-08-24"
status: "Authoritative Runbook"
---

# OneDrive Sync Engine Diagnostic and Ghost Repair Runbook

Module: OneDrive-Sync-Diagnostic-and-Repair-Guide  
Path: `Workspace_AI/docs/OneDrive-Sync-Diagnostic-and-Repair-Guide.md`  
Authors: Rolf, Workspace_AI Governance  
Date: 2026-08-24  
Version: 1.0.0  

---

## 1. Executive Summary & Root Cause Analysis

When using multi-device file synchronization (such as Samsung Galaxy S24+ with OneSync, PhoneLink, and Windows OneDrive), files deleted or moved on the mobile device asynchronously can leave stale **"unrealized download intents"** in the Windows OneDrive client database.

### The "0.0 KB Remaining (100%)" Symptom:
1. **The State**: OneDrive tray status reports *"Downloading 9 files, 0.0 KB remaining (100%)"* and remains stuck indefinitely.
2. **The Cause**: The local client database (`SyncEngineDatabase.db`) marks the file with `fileStatus = 3` (*Incomplete Download Stream*). However, the cloud server reports `ServerSize: None (0 bytes)` because the payload was purged upstream.
3. **The Loop**: Because 0 bytes remain to be received, the progress bar calculates 100% completion, but the download stream cannot finish.

---

## 2. Technical Architecture: SQLite Sync Database

OneDrive manages its state via a multi-table SQLite 3 database located at:
`%LOCALAPPDATA%\Microsoft\OneDrive\settings\Personal\SyncEngineDatabase.db`

### Key Database Tables Inspected:
| Table | Description | Critical Fields |
| :--- | :--- | :--- |
| `od_ClientFile_Records` | Active file state tracking. | `fileName`, `fileStatus` (`3` = stuck download), `size`, `serverSize`, `parentResourceID`. |
| `od_ClientFolder_Records` | Cloud-to-local folder hierarchy. | `resourceID`, `parentResourceID`, `folderName`. |
| `od_ClientFilePostponedChange_Records` | Queue of postponed local mutations. | Change records pending resolution. |

---

## 3. Tool Suite & Usage

### 1. `Diagnose-OneDriveSync.ps1` (or `Test-OneDriveSync.ps1`)
Located at:
- `D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1`
- `D:\Git_Repositories\tools\Diagnose-OneDriveSync.ps1`

#### A. Diagnostic Mode (Audit Only):
Deep-inspects the SQLite database in `mode=ro` (read-only) without modifying files or processes:
```powershell
pwsh D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1
```

#### B. Safe Remediation Mode (`-Reset`):
Executes Microsoft's official cache reset to clear dead download intents and rebuild the cloud index:
```powershell
pwsh D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1 -Reset
```

---

## 4. Remediation Invariants & Safety Guarantees

1. **Read-Only Database Queries**: All inspection queries connect with SQLite URI `mode=ro` to ensure no database file lock contention with running `OneDrive.exe`.
2. **Dynamic Executable Resolution**: Supports modern 64-bit Windows 11 paths (`C:\Program Files\Microsoft OneDrive\OneDrive.exe`) and legacy AppData user paths.
3. **Zero Data Loss Guarantee**: Running `onedrive.exe /reset` only clears the local SQLite index cache and forces a cloud manifest comparison. It does **not** delete local documents, repositories, or photos.
