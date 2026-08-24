---
title: "OneDrive Sync Engine Diagnostic and Ghost Repair Runbook"
description: "Authoritative technical reference and runbook for diagnosing stuck OneDrive sync loops (0.0 KB remaining 100%), SQLite database inspection, AuthorizeMasterUser ACL remediation, and ghost queue purge."
author: "Rolf, Workspace_AI Governance"
version: "2.1.0"
date: "2026-08-24"
status: "Authoritative Runbook"
---

# OneDrive Sync Engine Diagnostic and Ghost Repair Runbook

Module: OneDrive-Sync-Diagnostic-and-Repair-Guide  
Path: `Workspace_AI/docs/OneDrive-Sync-Diagnostic-and-Repair-Guide.md`  
Authors: Rolf, Workspace_AI Governance  
Date: 2026-08-24  
Version: 2.1.0  

---

## 1. Executive Summary & Root Cause Analysis

When using multi-device file synchronization (such as Samsung Galaxy S24+ with OneSync, PhoneLink, and Windows OneDrive), files deleted or moved on the mobile device asynchronously can leave stale **"unrealized download intents"** in the Windows OneDrive client database.

### The "0.0 KB Remaining (100%)" Symptom:
1. **The State**: OneDrive tray status reports *"Downloading 9 files, 0.0 KB remaining (100%)"* and remains stuck indefinitely.
2. **The Cause**: The local client database (`SyncEngineDatabase.db`) marks the file with `fileStatus = 3` (*Incomplete Download Stream*). However, the cloud server reports `ServerSize: None (0 bytes)` because the payload was purged upstream.
3. **The ACL Complication**: In addition to ghost download intents, asynchronous phone synchronization often creates target directories (e.g. `D:\OneDrive\Eigene Videos`) with broken or inaccessible ACL permissions. When OneDrive attempts to write, Windows throws `Access Denied`, causing an infinite retry loop.

---

## 2. ACL Standard Integration: `AuthorizeMasterUser`

The repair engine strictly conforms to the workspace's authoritative **`AuthorizeMasterUser`** security model:

| Property | AuthorizeMasterUser Standard (Inside OneDrive) |
| :--- | :--- |
| **Owner** | `NT AUTHORITY\Authenticated Users` |
| **User Access** | `Authenticated Users: (OI)(CI)F` (FullControl) |
| **System Access** | `NT AUTHORITY\SYSTEM: (OI)(CI)F` (FullControl - Untouched) |
| **Admin Access** | `BUILTIN\Administrators: (OI)(CI)F` (FullControl) |
| **Inheritance** | Enabled (`/inheritance:e`) from `D:\OneDrive` root |

---

## 3. Tool Suite & Usage

### `Diagnose-OneDriveSync.ps1` (v2.1.0)
Located at:
- `D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1`
- `D:\Git_Repositories\tools\Diagnose-OneDriveSync.ps1`

#### A. Diagnostic Mode (Audit Only):
Deep-inspects the SQLite database in `mode=ro` and scans target folders for ACL locks:
```powershell
pwsh D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1
```

#### B. ACL Repair Mode (`-FixAcl`):
Applies AuthorizeMasterUser ownership and permissions to all locked target folders:
```powershell
pwsh D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1 -FixAcl
```

#### C. Full Automated Remediation (`-All`):
Applies the AuthorizeMasterUser ACL fix, de-elevates, and dispatches the official cache reset in one unified command:
```powershell
pwsh D:\OneDrive\cmd\@Repair\Diagnose-OneDriveSync.ps1 -All
```

---

## 4. Remediation Invariants & Safety Guarantees

1. **Read-Only Database Queries**: All inspection queries connect with SQLite URI `mode=ro` to ensure no database file lock contention with running `OneDrive.exe`.
2. **Dynamic Executable Resolution**: Supports modern 64-bit Windows 11 paths (`C:\Program Files\Microsoft OneDrive\OneDrive.exe`) and legacy AppData user paths.
3. **Automatic De-Elevation via Shell COM**: If executed from an Administrator shell, the `/reset` trigger is automatically dispatched through Windows Explorer's non-elevated user token (`Shell.Application.ShellExecute`), completely bypassing Microsoft's administrator popup block.
4. **Zero Data Loss Guarantee**: Running `onedrive.exe /reset` only clears the local SQLite index cache and forces a cloud manifest comparison. It does **not** delete local documents, repositories, or photos.
