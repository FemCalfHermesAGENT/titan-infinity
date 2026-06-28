#!/bin/bash
# Monitor C: drive usage and alert if it grows beyond expected
LOGFILE="/mnt/s/hermes/logs/c-drive-monitor.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Get C: usage percentage
C_USAGE=$(df /c 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')

if [ -n "$C_USAGE" ]; then
    echo "[$TIMESTAMP] C: drive usage: ${C_USAGE}%" >> "$LOGFILE"
    
    # Alert if above 50%
    if [ "$C_USAGE" -gt 50 ]; then
        echo "[$TIMESTAMP] ⚠️ WARNING: C: drive above 50%!" >> "$LOGFILE"
    fi
else
    echo "[$TIMESTAMP] Could not check C: drive" >> "$LOGFILE"
fi
