#!/bin/bash
# YouTube Learn Pipeline
# Input: YouTube URL
# Output: Transcript + Summary + Action items
# Usage: bash youtube_learn.sh <youtube_url>

URL="$1"
WORKDIR="/s/hermes/workspace/youtube-sessions"
mkdir -p "$WORKDIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SESSION_DIR="$WORKDIR/$TIMESTAMP"
mkdir -p "$SESSION_DIR"

echo "=== YouTube Learn Pipeline ==="
echo "URL: $URL"
echo "Session: $SESSION_DIR"

# Step 1: Download audio
echo "[1/4] Downloading audio..."
yt-dlp -x --audio-format mp3 -o "$SESSION_DIR/audio.%" "$URL" 2>&1 | tail -3

# Step 2: Transcribe with Whisper
echo "[2/4] Transcribing..."
cd "$SESSION_DIR"
whisper audio.mp3 --model medium --output_format txt --output_dir . 2>&1 | tail -5

# Step 3: Create summary prompt
echo "[3/4] Preparing summary..."
cat > "$SESSION_DIR/transcript.txt" << TRANSEOF
$(cat *.txt 2>/dev/null)
TRANSEOF

echo "[4/4] Done! Files in $SESSION_DIR:"
ls -la "$SESSION_DIR/"

echo ""
echo "=== NEXT ==="
echo "Ask Hermes to read $SESSION_DIR/transcript.txt and:"
echo "1. Summarize key concepts"
echo "2. Extract actionable steps"
echo "3. Create implementation scripts"
