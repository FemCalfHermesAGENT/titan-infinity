# Hermes Workspace

This is the primary workspace for Hermes automation agents.

## Directory Structure
- `/s/hermes/workspace/` - Project files and agent scripts
- `/s/hermes/logs/` - All log files
- `/s/hermes/cron/` - Cron job scripts
- `/s/hermes/.hermes/` - Hermes configuration
- `/s/hermes/.env` - Environment variables
- `/s/hermes/docker-compose.yml` - Docker orchestration

## Getting Started
1. Set your API keys in `/s/hermes/.env`
2. Start services: `docker-compose up -d`
3. Check logs: `tail -f /s/hermes/logs/agent.log`
