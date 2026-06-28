#!/bin/bash
# System health check - comprehensive but lightweight
LOGFILE="/mnt/s/hermes/logs/health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] ═══ HEALTH CHECK ═══" >> "$LOGFILE"

# Disk
echo "[$TIMESTAMP] C: drive: $(df -h /c 2>/dev/null | tail -1 | awk '{print $5 " used"}')" >> "$LOGFILE"
echo "[$TIMESTAMP] S: drive: $(df -h /mnt/s 2>/dev/null | tail -1 | awk '{print $5 " used (" $4 " free)"}')" >> "$LOGFILE"

# Memory
echo "[$TIMESTAMP] Memory: $(free -h 2>/dev/null | grep Mem | awk '{print $3"/"$2", free: "$4}')" >> "$LOGFILE"

# WSL status
echo "[$TIMESTAMP] WSL: $(wsl -l --running 2>/dev/null | grep -c 'Running' || echo '0') distro(s) running" >> "$LOGFILE"

# Cron status
echo "[$TIMESTAMP] Cron: $(service cron status 2>&1 | grep -o 'active (running)\|inactive\|failed' || echo 'unknown')" >> "$LOGFILE"

# Docker
echo "[$TIMESTAMP] Docker images: $(docker images -q 2>/dev/null | wc -l) | containers: $(docker ps -q 2>/dev/null | wc -l)" >> "$LOGFILE"

# Hermes
if command -v hermes &>/dev/null; then
    echo "[$TIMESTAMP] Hermes: OK ($(hermes --version 2>&1 | head -1 | awk '{print $3}'))" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] Hermes: NOT FOUND" >> "$LOGFILE"
fi

echo "[$TIMESTAMP] ═══ END ═══" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
