#!/bin/bash
# Deep system verification - runs daily
LOGFILE="/mnt/s/hermes/logs/verify.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] ═══ DEEP VERIFICATION ═══" >> "$LOGFILE"

# 1. Check junctions
JUNCTIONS=$(ls -la /c/Users/femca/AppData/Local/hermes/ 2>/dev/null | grep -c "^l")
echo "[$TIMESTAMP] Junctions active: $JUNCTIONS" >> "$LOGFILE"

# 2. Check S: drive data
S_USED=$(df -h /mnt/s 2>/dev/null | tail -1 | awk '{print $3}')
S_FREE=$(df -h /mnt/s 2>/dev/null | tail -1 | awk '{print $4}')
echo "[$TIMESTAMP] S: drive: $S_USED used, $S_FREE free" >> "$LOGFILE"

# 3. Check C: drive
C_PCT=$(df /c 2>/dev/null | tail -1 | awk '{print $5}')
echo "[$TIMESTAMP] C: drive: $C_PCT used" >> "$LOGFILE"

# 4. Check Docker
DOCKER=$(docker ps --format '{{.Names}}' 2>/dev/null | tr '\n' ' ')
echo "[$TIMESTAMP] Docker: $DOCKER" >> "$LOGFILE"

# 5. Check Cron
CRON_JOBS=$(crontab -l 2>/dev/null | grep -c ".sh")
echo "[$TIMESTAMP] Cron jobs: $CRON_JOBS" >> "$LOGFILE"

# 6. Check GitHub
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "[$TIMESTAMP] GitHub: OK" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] GitHub: FAILED" >> "$LOGFILE"
fi

# 7. Check WSL
WSL_STATE=$(powershell.exe -NoProfile -Command "(wsl -l -v 2>&1 | Select-String 'Running').Line" 2>/dev/null | head -1)
echo "[$TIMESTAMP] WSL: $WSL_STATE" >> "$LOGFILE"

# 8. Check Gateway
GW=$(powershell.exe -NoProfile -Command "(Get-Process -Name '*hermes*' -ErrorAction SilentlyContinue).Count" 2>/dev/null)
echo "[$TIMESTAMP] Gateway processes: $GW" >> "$LOGFILE"

echo "[$TIMESTAMP] ═══ VERIFICATION COMPLETE ═══" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
