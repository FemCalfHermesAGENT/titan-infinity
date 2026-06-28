# Agent Memory and Learning Log

## System Profile
- Machine: Harry (Windows 10, WSL2 Ubuntu)
- Primary Drive: S: (727GB, dedicated to agent)
- C: Drive: OS only, keep clean
- User Focus: AI + Quantum Research, deep analysis, development

## Available Skills
- Computer Use (cua-driver): screen capture, click, type
- GitHub (gh CLI): repos, PRs, issues
- YouTube Content: transcript extraction
- arXiv: paper search
- HuggingFace: models/datasets
- Google Workspace: Gmail, Calendar, Drive
- Maps: geocoding, routes
- Notion: pages, databases
- OCR: PDF text extraction
- Browser automation
- Docker, Cron, WSL

## Lessons Learned
- PowerShell heredocs from bash get mangled, use file-based approach
- WSL paths use /mnt/s/ not /s/
- write_file tool resolves /s/ to C:s, use terminal cat for S: drive
- cua-driver needs manual install via PowerShell script

## Active Cron Jobs
- system_health.sh: every 30 min
- docker_cleanup.sh: every 6 hours
- log_rotate.sh: daily 3 AM
- hourly_agent.sh: daily 4 AM

---
Last updated: 2026-06-27
