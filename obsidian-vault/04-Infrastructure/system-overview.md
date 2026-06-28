# Infrastructure

## System Specs
- OS: Windows 10 (host: femca)
- CPU: 8 cores
- RAM: 16GB
- C: 119GB (45% used) â€” SYSTEM ONLY, NEVER TOUCH
- S: 727GB (2.2% used) â€” All tools/data here
- X: 205GB (1% used) â€” Downloads

## Toolchain
| Tool | Version | Path |
|------|---------|------|
| Python | 3.11.15 | S:\hermes\.venv\Scripts\python.exe |
| Node | 22.23.1 | system |
| Git | 2.54.0 | system |
| Docker | 29.5.3 | system |
| uv | 0.11.24 | system |
| gh | 2.95.0 | system |
| ffmpeg | 8.1.1 | system |
| yt-dlp | 2026.06.09 | uv tools |

## Python Packages (mem0 environment)
- mem0==2.0.10
- qdrant-client==1.18.0
- openai==2.44.0
- numpy==2.4.6
- sqlalchemy==2.0.51
- httpx==0.28.1
- pydantic==2.13.4

## Docker Containers
- hermes-agent (node:20-slim)
- hermes-browser (browserless/chrome:latest, port 3000)

## Cron Jobs
1. Control Tower Health Check â€” every 2h
2. Memory Maintenance â€” daily 4am
3. Daily System Report â€” daily 9am
4. Upskill Queue Processor â€” weekly Sunday 5am

## File Structure
```
S:\hermes\
â”œâ”€â”€ .venv/              # Python venv
â”œâ”€â”€ obsidian-vault/     # Obsidian knowledge base
â”œâ”€â”€ profiles/           # 6 agent profiles
â”œâ”€â”€ scripts/            # Automation scripts
â”œâ”€â”€ docs/               # Architecture docs
â”œâ”€â”€ skills/             # System + custom skills
â”œâ”€â”€ logs/               # All system logs
â””â”€â”€ tools/              # Cloned repos, installed tools
```
