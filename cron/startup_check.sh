#!/bin/bash
# Startup verification - run when Hermes launches
LOGFILE="/mnt/s/hermes/logs/startup.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] ╔══════════════════════════════════════╗" >> "$LOGFILE"
echo "[$TIMESTAMP] ║   HERMES STARTUP VERIFICATION        ║" >> "$LOGFILE"
echo "[$TIMESTAMP] ╚══════════════════════════════════════╝" >> "$LOGFILE"

# 1. Cron
if service cron status 2>&1 | grep -q "active (running)"; then
    JOBS=$(crontab -l 2>/dev/null | grep -v '^#' | grep -v '^$' | wc -l)
    echo "[$TIMESTAMP] [OK] Cron: Running ($JOBS jobs)" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] [FAIL] Cron: Not running" >> "$LOGFILE"
fi

# 2. S: Drive
if [ -d /mnt/s/hermes ]; then
    FREE=$(df -h /mnt/s 2>/dev/null | tail -1 | awk '{print $4}')
    echo "[$TIMESTAMP] [OK] S: Drive accessible ($FREE free)" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] [FAIL] S: Drive not accessible" >> "$LOGFILE"
fi

# 3. Hermes
if command -v hermes &>/dev/null; then
    echo "[$TIMESTAMP] [OK] Hermes: $(hermes --version 2>&1 | head -1 | awk '{print $3}')" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] [FAIL] Hermes: Not found" >> "$LOGFILE"
fi

# 4. Docker
if command -v docker &>/dev/null; then
    echo "[$TIMESTAMP] [OK] Docker: $(docker --version 2>&1 | awk '{print $3}' | tr -d ',')" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] [WARN] Docker: Not available in WSL" >> "$LOGFILE"
fi

# 5. API Key
if grep -q "sk-or" /root/.hermes/.env 2>/dev/null; then
    echo "[$TIMESTAMP] [OK] API Key: Loaded" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] [WARN] API Key: Not found" >> "$LOGFILE"
fi

# 6. Memory
MEM=$(free -h 2>/dev/null | grep Mem | awk '{print $3"/"$2" used, "$4" free"}')
echo "[$TIMESTAMP] [INFO] Memory: $MEM" >> "$LOGFILE"

echo "[$TIMESTAMP] ═══ STARTUP CHECK COMPLETE ═══" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
