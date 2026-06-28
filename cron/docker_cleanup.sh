#!/bin/bash
# Safe Docker cleanup - removes only dangling images and build cache
# Does NOT touch running containers, named volumes, or used images
LOGFILE="/mnt/s/hermes/logs/docker-clean.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] Docker cleanup started" >> "$LOGFILE"

# Record space before
BEFORE=$(docker system df --format '{{.Size}}' 2>/dev/null | head -1)
echo "[$TIMESTAMP] Space before: $BEFORE" >> "$LOGFILE"

# Safe prune: only dangling images + build cache (no -a, no --volumes)
docker builder prune -f >> "$LOGFILE" 2>&1
docker image prune -f >> "$LOGFILE" 2>&1

# Record space after
AFTER=$(docker system df --format '{{.Size}}' 2>/dev/null | head -1)
echo "[$TIMESTAMP] Space after: $AFTER" >> "$LOGFILE"
echo "[$TIMESTAMP] Cleanup complete" >> "$LOGFILE"
echo "---" >> "$LOGFILE"
