#!/usr/bin/env python3
"""
YouTube Master Pipeline
Input: YouTube URL
Process: Download → Transcribe → Analyze → Extract Actions → Upskill
Output: Transcript + Analysis + Action Items + Self-Improvement Plan
"""

import sys
import os
import json
import subprocess
from datetime import datetime

WORKSPACE = "/s/hermes/workspace"
SESSIONS_DIR = f"{WORKSPACE}/youtube-sessions"
REPOS_DIR = f"{WORKSPACE}/github-repos"

def youtube_master(url):
    """Full pipeline: URL → Knowledge → Action"""
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    session_dir = f"{SESSIONS_DIR}/{timestamp}"
    os.makedirs(session_dir, exist_ok=True)
    
    print(f"\n{'='*60}")
    print(f"  YOUTUBE MASTER PIPELINE")
    print(f"  URL: {url}")
    print(f"  Session: {session_dir}")
    print(f"{'='*60}\n")
    
    # Step 1: Get video info
    print("[1/6] Getting video info...")
    result = subprocess.run(
        ["yt-dlp", "--dump-json", "--no-download", url],
        capture_output=True, text=True, timeout=60
    )
    if result.returncode != 0:
        print(f"  ERROR: {result.stderr[:200]}")
        return
    
    info = json.loads(result.stdout)
    title = info.get("title", "Unknown")
    duration = info.get("duration", 0)
    channel = info.get("channel", "Unknown")
    
    print(f"  Title: {title}")
    print(f"  Channel: {channel}")
    print(f"  Duration: {duration//60}m {duration%60}s")
    
    # Save metadata
    with open(f"{session_dir}/metadata.json", "w") as f:
        json.dump({"title": title, "channel": channel, "duration": duration, "url": url}, f, indent=2)
    
    # Step 2: Download audio
    print("\n[2/6] Downloading audio...")
    subprocess.run(
        ["yt-dlp", "-x", "--audio-format", "mp3", "-o", f"{session_dir}/audio.%(ext)s", url],
        capture_output=True, timeout=300
    )
    print("  Audio downloaded")
    
    # Step 3: Transcribe
    print("\n[3/6] Transcribing with Whisper...")
    result = subprocess.run(
        ["whisper", f"{session_dir}/audio.mp3", "--model", "medium", 
         "--output_format", "txt", "--output_dir", session_dir],
        capture_output=True, text=True, timeout=600
    )
    
    transcript_file = f"{session_dir}/audio.txt"
    if os.path.exists(transcript_file):
        with open(transcript_file) as f:
            transcript = f.read()
        print(f"  Transcript: {len(transcript)} chars")
    else:
        transcript = "TRANSCRIPTION FAILED"
        print("  Transcription failed")
    
    # Step 4: Save transcript
    with open(f"{session_dir}/transcript.txt", "w") as f:
        f.write(transcript)
    
    # Step 5: Create analysis prompt for Hermes
    analysis_prompt = f"""Analyze this YouTube video transcript and provide:

1. **Summary**: 3-5 sentence overview of the video's core message
2. **Key Concepts**: List of important concepts/techniques covered
3. **Action Items**: Specific things to implement, install, or configure
4. **Tools/Libraries Mentioned**: Any software, libraries, or frameworks mentioned
5. **Upskill Opportunities**: What I should learn/install to apply this knowledge
6. **Relevant Repos**: GitHub repos that should be cloned based on this content
7. **Hermes Improvements**: Skills, tools, or configs I should add to my Hermes Agent OS

Video: {title} by {channel}
Duration: {duration//60}m {duration%60}s

TRANSCRIPT:
{transcript[:8000]}
"""
    
    with open(f"{session_dir}/analysis_prompt.txt", "w") as f:
        f.write(analysis_prompt)
    
    print(f"\n[4/6] Analysis prompt saved")
    print(f"\n[5/6] Next: Hermes will analyze and extract actions")
    print(f"\n[6/6] Session ready at: {session_dir}")
    print(f"\n{'='*60}")
    print(f"  Ask Hermes to read: {session_dir}/analysis_prompt.txt")
    print(f"  and execute the action items")
    print(f"{'='*60}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python youtube_master.py <youtube_url>")
        sys.exit(1)
    youtube_master(sys.argv[1])
