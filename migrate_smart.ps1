# ============================================================
# SMART MIGRATION - SSD Speed + HDD Storage
# C: stays fast (OS + programs), S: gets all data/storage
# ============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SMART MIGRATION: SSD Speed + HDD Storage" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "C: (SSD) = OS + Programs + Hermes CODE" -ForegroundColor Green
Write-Host "S: (HDD) = Data + Cache + Containers + Downloads" -ForegroundColor Green
Write-Host ""

$ErrorActionPreference = "Continue"
$success = 0
$failed = 0
$skipped = 0

function Move-WithJunction {
    param($Source, $Dest, $Description)
    
    Write-Host "Moving $Description..." -ForegroundColor Yellow
    Write-Host "  From (C: SSD): $Source"
    Write-Host "  To   (S: HDD): $Dest"
    
    if (!(Test-Path $Source)) {
        Write-Host "  SKIP (not found)" -ForegroundColor Gray
        $script:skipped++
        Write-Host ""
        return
    }
    
    # Create destination parent
    $parent = Split-Path $Dest -Parent
    if (!(Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    
    # Move data
    Move-Item -Path $Source -Destination $Dest -Force -ErrorAction SilentlyContinue
    
    if (Test-Path $Dest) {
        # Create junction so programs still find it at C:
        cmd /c "mklink /J `"$Source`" `"$Dest`"" | Out-Null
        if (Test-Path $Source) {
            Write-Host "  DONE + Junction created" -ForegroundColor Green
            $script:success++
        } else {
            Write-Host "  MOVED (junction failed - data safe on S:)" -ForegroundColor DarkYellow
            $script:success++
        }
    } else {
        Write-Host "  FAILED" -ForegroundColor Red
        $script:failed++
    }
    Write-Host ""
}

# ============================================
# TIER 1: MOVE TO S: (HDD) - Bulk Storage
# These are large, grow frequently, don't need SSD speed
# ============================================

Write-Host "--- TIER 1: Moving bulk data to S: (HDD) ---" -ForegroundColor Cyan
Write-Host ""

# 1. Hermes CACHE and RUNTIME DATA (keep code on C:)
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\cache" "S:\hermes-data\hermes\cache" "Hermes Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\image_cache" "S:\hermes-data\hermes\image_cache" "Hermes Image Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\audio_cache" "S:\hermes-data\hermes\audio_cache" "Hermes Audio Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\models_dev_cache.json" "S:\hermes-data\hermes\models_dev_cache.json" "Hermes Model Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\sandboxes" "S:\hermes-data\hermes\sandboxes" "Hermes Sandboxes"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\sessions" "S:\hermes-data\hermes\sessions" "Hermes Sessions"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\logs" "S:\hermes-data\hermes\logs" "Hermes Logs"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\memories" "S:\hermes-data\hermes\memories" "Hermes Memories"
Move-WithJunction "C:\Users\femca\AppData\Local\hermes\cron" "S:\hermes-data\hermes\cron" "Hermes Cron"

# 2. Docker ALL data (images, containers, volumes)
Move-WithJunction "C:\Users\femca\AppData\Local\Docker" "S:\hermes-data\docker" "Docker All Data"

# 3. WSL virtual disk (ext4.vhdx - can be 10+ GB)
$wslBase = (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss' -ErrorAction SilentlyContinue).BasePath
if ($wslBase -and (Test-Path $wslBase)) {
    Move-WithJunction $wslBase "S:\hermes-data\wsl" "WSL Virtual Disk"
}

# 4. Downloads folder
Move-WithJunction "C:\Users\femca\Downloads" "S:\hermes-data\downloads" "Downloads"

# 5. Browser caches (large, regenerates automatically)
Move-WithJunction "C:\Users\femca\AppData\Local\Microsoft\Edge\User Data\Default\Cache" "S:\hermes-data\cache\edge" "Edge Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\Google\Chrome\User Data\Default\Cache" "S:\hermes-data\cache\chrome" "Chrome Cache"

# 6. Windows Temp
Move-WithJunction "C:\Users\femca\AppData\Local\Temp" "S:\hermes-data\temp\user-temp" "User Temp"

# 7. npm/pip caches
Move-WithJunction "C:\Users\femca\AppData\Local\npm-cache" "S:\hermes-data\cache\npm" "npm Cache"
Move-WithJunction "C:\Users\femca\AppData\Local\pip\cache" "S:\hermes-data\cache\pip" "pip Cache"

# ============================================
# TIER 2: KEEP ON C: (SSD) - Speed Critical
# These need fast I/O for responsiveness
# ============================================

Write-Host "--- TIER 2: Keeping on C: (SSD) for speed ---" -ForegroundColor Cyan
Write-Host ""
Write-Host "  [KEEP] C:\Users\femca\AppData\Local\hermes\hermes-agent\" -ForegroundColor Green
Write-Host "         (Python venv - needs fast import loading)" -ForegroundColor Gray
Write-Host "  [KEEP] C:\Users\femca\AppData\Local\hermes\profiles\" -ForegroundColor Green
Write-Host "         (Active config - needs fast read/write)" -ForegroundColor Gray
Write-Host "  [KEEP] C:\Users\femca\AppData\Local\hermes\skills\" -ForegroundColor Green
Write-Host "         (Skill loading - needs fast access)" -ForegroundColor Gray
Write-Host "  [KEEP] C:\Users\femca\AppData\Local\hermes\bin\" -ForegroundColor Green
Write-Host "         (Binaries - needs fast execution)" -ForegroundColor Gray
Write-Host "  [KEEP] C:\Users\femca\AppData\Local\hermes\config.yaml" -ForegroundColor Green
Write-Host "         (Main config - read on every startup)" -ForegroundColor Gray
Write-Host ""

# ============================================
# RESULTS
# ============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  RESULTS" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Succeeded: $success" -ForegroundColor Green
Write-Host "  Failed:    $failed" -ForegroundColor $(if($failed -gt 0){"Red"}else{"Green"})
Write-Host "  Skipped:   $skipped" -ForegroundColor Gray
Write-Host ""

# Show new disk space
Write-Host "--- DISK SPACE AFTER MIGRATION ---" -ForegroundColor Cyan
Get-PSDrive C, S | Format-Table Name,@{N='Used(GB)';E={[math]::Round($_.Used/1GB,2)}},@{N='Free(GB)';E={[math]::Round($_.Free/1GB,2)}} -AutoSize

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  DONE! Reopen Hermes." -ForegroundColor Green
Write-Host "  C: = Fast (OS + Programs + Hermes code)" -ForegroundColor Green
Write-Host "  S: = Storage (Data + Cache + Containers)" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

pause
