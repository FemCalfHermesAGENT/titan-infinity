#!/bin/bash
# Smart log rotation - archives logs over 10MB, deletes archives over 30 days
LOGDIR="/mnt/s/hermes/logs"
ARCHIVE="/mnt/s/hermes/logs/archive"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$ARCHIVE"

# Rotate: if log > 10MB, compress to archive and truncate
for logfile in "$LOGDIR"/*.log; do
    [ -f "$logfile" ] || continue
    SIZE=$(stat -c%s "$logfile" 2>/dev/null || echo 0)
    if [ "$SIZE" -gt 10485760 ]; then
        FNAME=$(basename "$logfile")
        gzip -c "$logfile" > "$ARCHIVE/${FNAME}.$(date +%Y%m%d-%H%M%S).gz"
        : > "$logfile"
        echo "[$TIMESTAMP] Rotated: $FNAME ($(($SIZE/1024/1024))MB)" 
    fi
done >> "$LOGDIR/rotation.log" 2>&1

# Delete archives older than 30 days
find "$ARCHIVE" -name "*.gz" -mtime +30 -delete 2>/dev/null
echo "[$TIMESTAMP] Old archives cleaned" >> "$LOGDIR/rotation.log"
