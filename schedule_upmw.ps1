# schedule_upmw.ps1
# Schedules Profwiz.exe (ForensiT UPMW Corporate Edition) to run silently at a specific time

# --- Configuration ---
$exePath    = "C:\UPMW\Profwiz.exe"
$taskName   = "UPMW_Profile_Migration"
$taskDate   = "2025-07-04"  # YYYY-MM-DD
$taskTime   = "09:00"       # HH:MM in 24-hour format
$arguments  = "/quiet"

# --- Validation ---
if (!(Test-Path $exePath)) {
    Write-Error "❌ Profwiz.exe not found at $exePath"
    exit 1
}

# --- Task Action ---
$action = New-ScheduledTaskAction -Execute $exePath -Argument $arguments

# --- Task Trigger ---
$trigger = New-ScheduledTaskTrigger -Once -At ([datetime]::Parse("$taskDate $taskTime"))

# --- Run as SYSTEM with elevated privileges ---
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# --- Register the task ---
try {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Force
    Write-Host "✅ Scheduled task '$taskName' set for $taskDate at $taskTime"
}
catch {
    Write-Error "❌ Failed to register task: $_"
    exit 1
}
