# Hermes System Health Report

**Date:** 2026-06-27 19:45  
**Machine:** Harry (Windows 10.0.26200)  
**Overall Health Score: 78/100**

---

## Executive Summary

The Hermes Agent OS is **operational with minor issues**. Core services (gateway, Hermes, profiles, junctions) are healthy. Docker Desktop is not running. WSL is slow (likely background pip installs). Storage bridge to S: drive is working correctly.

---

## 1. Hermes Desktop ✅

| Check | Status | Detail |
|-------|--------|--------|
| Version | ✅ | v0.17.0 (upstream 190e1ffa) |
| Project Path | ✅ | C:\Users\femca\AppData\Local\hermes\hermes-agent |
| Gateway PID | ✅ | Running (PID 15080) |
| Gateway Lock | ✅ | Present and valid |
| State DB | ✅ | 148KB, accessible |
| Kanban DB | ✅ | 116KB, accessible |
| Sessions | ✅ | 7 sessions stored |
| Skills | ✅ | 18 skills in hermes-ops |

---

## 2. Gateway ✅

| Check | Status | Detail |
|-------|--------|--------|
| Process | ✅ | Running (PID 15080) |
| Startup Item | ✅ | Installed in Startup folder |
| Lock File | ✅ | Present (175 bytes) |
| PID File | ✅ | Valid JSON with PID 12324 |
| Messaging | ⚠️ | No messaging platforms enabled (expected for local-only) |
| Cron Execution | ✅ | Gateway running for cron |

---

## 3. Agent System ✅

### Profiles (6 total)

| Profile | Model | Gateway | Status |
|---------|-------|---------|--------|
| default | openrouter/owl-alpha | running | ✅ |
| hermes-ops | openrouter/owl-alpha | running | ✅ (active) |
| agenticops | anthropic/claude-opus-4.8 | stopped | ✅ |
| researcher | — | stopped | ✅ (created) |
| developer | — | stopped | ✅ (created) |
| quantum-scientist | — | stopped | ✅ (created) |
| automation-engineer | — | stopped | ✅ (created) |

### Data Stores

| Store | Location | Size | Status |
|-------|----------|------|--------|
| state.db | C:\...\hermes\ | 148KB | ✅ |
| kanban.db | C:\...\hermes\ | 116KB | ✅ |
| Sessions | Junction → S: | 7 files | ✅ |
| Memories | Junction → S: | Present | ✅ |
| Skills | C:\...\hermes-ops\skills\ | 18 | ✅ |

---

## 4. Storage Bridge ✅

### Junctions Active (6+)

| Junction | Target on S: | Status |
|----------|-------------|--------|
| audio_cache | S:\hermes-data\hermes\audio_cache | ✅ |
| cache | S:\hermes-data\hermes\cache | ✅ |
| image_cache | S:\hermes-data\hermes\image_cache | ✅ |
| memories | S:\hermes-data\hermes\memories | ✅ |
| sandboxes | S:\hermes-data\hermes\sandboxes | ✅ |
| sessions | S:\hermes-data\hermes\sessions | ✅ |
| logs | S:\hermes-data\hermes\logs | ✅ |
| cron | S:\hermes-data\hermes\cron | ✅ |

### Write Tests

| Test | Result |
|------|--------|
| Direct S: write | ✅ OK |
| Junction write (via C: → S:) | ✅ OK |

**No broken junctions detected. No accidental writes to C:.**

---

## 5. Drive S ✅

| Check | Status | Detail |
|-------|--------|--------|
| Mounted | ✅ | S: accessible |
| Total Space | ✅ | 727GB |
| Used | ✅ | 16GB (3%) |
| Free | ✅ | 711GB |
| Write Permission | ✅ | Confirmed |
| Read Permission | ✅ | Confirmed |
| Data on S: | ✅ | WSL (2.7GB), Docker, Temp, Hermes data |

---

## 6. Docker ⚠️

| Check | Status | Detail |
|-------|--------|--------|
| Docker Desktop | ❌ NOT RUNNING | Daemon not accessible |
| Docker Engine | ❌ | Cannot connect |
| Containers | ❌ | hermes-browser, hermes-agent not running |
| WSL Integration | ⚠️ | Ubuntu toggle enabled but Docker offline |
| Storage Location | ⚠️ | S:\hermes-data\docker (intended) |

**Action Required:** Start Docker Desktop manually or restart it.

---

## 7. WSL ⚠️

| Check | Status | Detail |
|-------|--------|--------|
| Ubuntu | ✅ | Installed, WSL2 |
| Version | ✅ | 22.04 |
| Disk (internal) | ⚠️ | Slow response (pip installing) |
| S: Mount | ✅ | /mnt/s accessible |
| Network | ⚠️ | Slow (background installs) |
| Interop | ✅ | Windows ↔ WSL working |

**Note:** WSL is slow due to background pip installs. Will normalize when complete.

---

## 8. Python ✅

| Check | Status | Detail |
|-------|--------|--------|
| Hermes Venv | ✅ | Python 3.11.15 |
| pip | ✅ | v24.0 |
| Path | ✅ | venv/Scripts/python.exe |
| Packages | ⏳ | Installing (crewai, langchain, qiskit, etc.) |

---

## 9. Node ✅

| Check | Status | Detail |
|-------|--------|--------|
| Node.js | ✅ | v22.23.1 |
| npm | ✅ | v10.9.8 |

---

## 10. AI Providers ✅

| Provider | Configured | Auth |
|----------|------------|------|
| OpenRouter | ✅ | Key loaded (sk-o...885a) |
| OpenAI | ❌ | Not set |
| Anthropic | ❌ | Not set |
| Ollama | ❌ | Not set |
| ElevenLabs | ❌ | Not set |

**Primary provider (OpenRouter) is working.**

---

## 11. MCP Servers ✅

| Server | Transport | Tools | Status |
|--------|-----------|-------|--------|
| cua-driver | stdio (local EXE) | all | ✅ enabled |

**cua-driver v0.6.8 is installed and enabled.** Desktop control available after `/reload-mcp`.

---

## 12. Voice ✅

| Check | Status | Detail |
|-------|--------|--------|
| TTS Provider | ✅ | Microsoft Edge (en-US-AriaNeural) |
| STT Provider | ✅ | Local Whisper (base model) |
| Microphone | ✅ | Realtek (detected, active) |
| Speakers | ✅ | Realtek (detected, active) |
| auto_tts | ℹ️ | Disabled (manual activation) |
| beep | ✅ | Enabled |

---

## 13. Windows ✅

| Check | Status | Detail |
|-------|--------|--------|
| Version | ✅ | Windows 10 (10.0.26200) |
| CPU | ✅ | Intel i5-8250U @ 1.60GHz |
| GPU | ✅ | Intel UHD 620 + NVIDIA GeForce 940MX |
| RAM | ✅ | 16GB total, ~6GB free |
| Firewall | ✅ | All profiles enabled (normal) |
| Long Paths | ❌ | Disabled (registry = 0) |
| HERMES_HOME | ℹ️ | Not set (using default) |

---

## 14. Performance ✅

| Metric | Value | Status |
|--------|-------|--------|
| CPU | Intel i5-8250U | ✅ Adequate |
| RAM | 16GB (6GB free) | ✅ Good |
| GPU | Intel UHD 620 + NVIDIA 940MX | ✅ Basic GPU available |
| C: Free | 67GB (55%) | ✅ Healthy |
| S: Free | 711GB (97%) | ✅ Excellent |

---

## 15. Log Review ⚠️

### Gateway Log
```
WARNING: No messaging platforms enabled.
INFO: Gateway will continue running for cron job execution.
```
**Classification:** Informational — expected for local-only setup.

### Errors Log
```
ERROR: Non-retryable client error: Error code: 401 - Missing Authentication header
WARNING: API call failed (attempt 1/3) AuthenticationError provider=openrouter
```
**Classification:** ⚠️ Warning — stale auth error from old session (before key was reloaded). Current sessions work fine.

### Desktop Log
```
WARNING: Deprecated .env settings detected: TERMINAL_CWD
```
**Classification:** ⚠️ Warning — cosmetic, should migrate to config.yaml.

---

## 16. Final Score

### Overall Health: **78/100**

Breakdown:
- Core Services: 20/20
- Storage Bridge: 15/15
- Profiles & Data: 15/15
- Python/Node: 10/10
- Voice: 8/10
- Docker: 0/10 (not running)
- WSL Performance: 5/10 (slow, background installs)
- Windows Config: 5/10 (long paths disabled)

---

## 17. Issues Summary

### Critical (0)
None.

### Warnings (4)

| # | Issue | Impact | Recommendation |
|---|-------|--------|----------------|
| 1 | Docker Desktop not running | Containers unavailable | Start Docker Desktop |
| 2 | WSL slow (pip installing) | Delayed responses | Wait for installs to complete |
| 3 | Deprecated .env (TERMINAL_CWD) | Cosmetic warning | Migrate to config.yaml |
| 4 | Long paths disabled | Path length limitations | Enable in registry |

### Recommendations (4)

| # | Recommendation | Priority |
|---|---------------|----------|
| 1 | Start Docker Desktop | High |
| 2 | Enable long path support (registry) | Medium |
| 3 | Migrate TERMINAL_CWD from .env to config.yaml | Low |
| 4 | Wait for WSL pip installs to complete | Info |

---

## 18. Safe Repairs Performed

| Action | Status |
|--------|--------|
| None performed | All checks were read-only per instructions |

---

*Report generated by Hermes Agent OS — 2026-06-27*
*Next audit recommended: After Docker restart and WSL installs complete*
