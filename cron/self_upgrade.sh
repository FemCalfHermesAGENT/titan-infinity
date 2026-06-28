#!/bin/bash
# Self-Upgrade Cron Job
# Runs daily to update tools, skills, and knowledge

LOGFILE="/mnt/s/hermes/logs/upgrade.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
WORKDIR="/s/hermes/workspace"

echo "[$TIMESTAMP] ═══ SELF-UPGRADE STARTED ═══" >> "$LOGFILE"

# 1. Update pip packages
echo "[$TIMESTAMP] Updating Python packages..." >> "$LOGFILE"
pip3 install --break-system-packages --upgrade qiskit pennylane cirq transformers 2>&1 | tail -3 >> "$LOGFILE"

# 2. Update git repos
echo "[$TIMESTAMP] Pulling latest repos..." >> "$LOGFILE"
cd "$WORKDIR/github-repos"
for repo in */; do
    cd "$repo"
    git pull --quiet 2>&1 | tail -1 >> "$LOGFILE"
    cd ..
done

# 3. Update yt-dlp
pip3 install --break-system-packages --upgrade yt-dlp 2>&1 | tail -1 >> "$LOGFILE"

# 4. Record system state
echo "[$TIMESTAMP] System state:" >> "$LOGFILE"
echo "  S: drive: $(df -h /mnt/s | tail -1 | awk '{print $3 " used, " $4 " free"}')" >> "$LOGFILE"
echo "  C: drive: $(df -h /c 2>/dev/null | tail -1 | awk '{print $3 " used, " $4 " free"}')" >> "$LOGFILE"
echo "  Docker: $(docker ps -q | wc -l) containers running" >> "$LOGFILE"

echo "[$TIMESTAMP] ═══ UPGRADE COMPLETE ═══" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
