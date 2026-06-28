#!/bin/bash
# Hermes Hourly Agent - System Health Monitor
# Runs every hour via WSL cron
# Logs to /mnt/s/hermes/logs/agent.log

LOGFILE="/mnt/s/hermes/logs/agent.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] ═══ HOURLY AGENT RUN ═══" >> "$LOGFILE"

# Source .env
if [ -f /mnt/s/hermes/.env ]; then
    export $(grep -v '^#' /mnt/s/hermes/.env | grep -v '^\s*$' | sed 's/"//g' | xargs) 2>/dev/null
fi

export HERMES_HOME=/root/.hermes

# System stats
echo "[$TIMESTAMP] Host: $(hostname) | Uptime: $(uptime -p 2>/dev/null || uptime)" >> "$LOGFILE"
echo "[$TIMESTAMP] Disk S: $(df -h /mnt/s 2>/dev/null | tail -1 | awk '{print $5 " used (" $4 " free)"}')" >> "$LOGFILE"
echo "[$TIMESTAMP] Memory: $(free -h 2>/dev/null | grep Mem | awk '{print $3"/"$2" used"}')" >> "$LOGFILE"
echo "[$TIMESTAMP] Docker: $(docker ps --format '{{.Names}}' 2>/dev/null | tr '\n' ' ' || echo 'N/A (WSL integration off)')" >> "$LOGFILE"

# Check if Hermes is responsive
if hermes --version &>/dev/null; then
    echo "[$TIMESTAMP] Hermes: OK ($(hermes --version 2>&1 | head -1 | awk '{print $3}'))" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] Hermes: NOT RESPONDING" >> "$LOGFILE"
fi

echo "[$TIMESTAMP] ═══ RUN COMPLETE ═══" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
