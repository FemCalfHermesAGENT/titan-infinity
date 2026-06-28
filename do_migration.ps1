$ErrorActionPreference = "Continue"

# Create junctions for Hermes data
$junctions = @(
    @('C:\Users\femca\AppData\Local\hermes\cache', 'S:\hermes-data\hermes\cache'),
    @('C:\Users\femca\AppData\Local\hermes\image_cache', 'S:\hermes-data\hermes\image_cache'),
    @('C:\Users\femca\AppData\Local\hermes\audio_cache', 'S:\hermes-data\hermes\audio_cache'),
    @('C:\Users\femca\AppData\Local\hermes\sandboxes', 'S:\hermes-data\hermes\sandboxes'),
    @('C:\Users\femca\AppData\Local\hermes\sessions', 'S:\hermes-data\hermes\sessions'),
    @('C:\Users\femca\AppData\Local\hermes\logs', 'S:\hermes-data\hermes\logs'),
    @('C:\Users\femca\AppData\Local\hermes\memories', 'S:\hermes-data\hermes\memories'),
    @('C:\Users\femca\AppData\Local\hermes\cron', 'S:\hermes-data\hermes\cron')
)
foreach ($j in $junctions) {
    $src = $j[0]; $dst = $j[1]
    if ((Test-Path $dst) -and !(Test-Path $src)) {
        cmd /c "mklink /J `"$src`" `"$dst`"" | Out-Null
        Write-Host "JUNCTION: $(Split-Path $src -Leaf)"
    } elseif (Test-Path $src) {
        Write-Host "EXISTS: $(Split-Path $src -Leaf)"
    } else {
        Write-Host "MISSING DEST: $(Split-Path $src -Leaf)"
    }
}

# Move Docker
if (Test-Path 'C:\Users\femca\AppData\Local\Docker') {
    Move-Item 'C:\Users\femca\AppData\Local\Docker' 'S:\hermes-data\docker-data' -Force -ErrorAction SilentlyContinue
    if (Test-Path 'S:\hermes-data\docker-data') {
        cmd /c 'mklink /J "C:\Users\femca\AppData\Local\Docker" "S:\hermes-data\docker-data"' | Out-Null
        Write-Host "DOCKER -> S:"
    }
}

# Move Downloads
if (Test-Path 'C:\Users\femca\Downloads') {
    Move-Item 'C:\Users\femca\Downloads' 'S:\hermes-data\downloads' -Force -ErrorAction SilentlyContinue
    if (Test-Path 'S:\hermes-data\downloads') {
        cmd /c 'mklink /J "C:\Users\femca\Downloads" "S:\hermes-data\downloads"' | Out-Null
        Write-Host "DOWNLOADS -> S:"
    }
}

# Move Temp
if (Test-Path 'C:\Users\femca\AppData\Local\Temp') {
    Move-Item 'C:\Users\femca\AppData\Local\Temp' 'S:\hermes-data\temp' -Force -ErrorAction SilentlyContinue
    if (Test-Path 'S:\hermes-data\temp') {
        cmd /c 'mklink /J "C:\Users\femca\AppData\Local\Temp" "S:\hermes-data\temp"' | Out-Null
        Write-Host "TEMP -> S:"
    }
}

# Clean C:
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Write-Host "C: CLEANED"

# Results
Write-Host ""
Write-Host "=== FINAL DISK SPACE ===" -ForegroundColor Cyan
Get-PSDrive C, S | Format-Table Name,@{N='Used(GB)';E={[math]::Round($_.Used/1GB,2)}},@{N='Free(GB)';E={[math]::Round($_.Free/1GB,2)}} -AutoSize
