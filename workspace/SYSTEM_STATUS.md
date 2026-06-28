# Hermes Agent OS — System Status
**Last Updated: 2026-06-27 17:30**

## Architecture
```
C: (SSD 119GB) → OS + Programs + Hermes CODE (fast loading)
S: (HDD 727GB) → Data + Cache + Containers + Downloads + WSL
```

## Disk Status
- C: 52GB/119GB (44%) — clean
- S: 12GB/727GB (2%) — growing

## Profiles (6 total)
| Profile | Purpose | Status |
|---------|---------|--------|
| hermes-ops | Main operator | Running |
| researcher | AI + Quantum research | Ready |
| developer | Full-stack development | Ready |
| quantum-scientist | Quantum computing | Ready |
| automation-engineer | DevOps + monitoring | Ready |
| agenticops | Multi-agent orchestration | Ready |

## Gateway
- Status: Installed as startup item
- Auto-starts on Windows login
- PID: 18536

## Voice
- TTS: Microsoft Edge (en-US-AriaNeural)
- STT: Local Whisper (base model)
- Microphone: Realtek (detected, working)

## GitHub
- Account: FemCalfHermesAGENT
- Auth: SSH key (ed25519)
- Email: femcalfhermes@gmail.com

## Docker
- Containers: hermes-browser, hermes-agent
- Data: S:\hermes-data\docker

## WSL
- Ubuntu 22.04 on S: drive (2.7GB)
- Python packages: installing (crewai, langchain, openai, etc.)

## Cron Jobs (5)
| Job | Schedule |
|-----|----------|
| system_health.sh | Every 30 min |
| docker_cleanup.sh | Every 6 hours |
| log_rotate.sh | Daily 3 AM |
| hourly_agent.sh | Daily 4 AM |
| self_upgrade.sh | Daily 5 AM |

## Installed Skills (64+)
AI/ML, GitHub, YouTube, arXiv, HuggingFace, Google Workspace,
Notion, OCR, Maps, Docker, Browser automation, Computer use

## YouTube Pipeline
- Script: S:\workspace\scripts\youtube_master.py
- Process: URL → Audio → Whisper transcript → Analysis → Actions

## Key Commands
- Open terminal in Hermes: Ctrl+`
- Reload MCP: /reload-mcp
- Switch profile: hermes -p <profile-name> chat
- Check status: hermes status

## Backup Location
- S:\hermes-backup\ (config.yaml.bak, .env.bak, ubuntu-backup.tar)
