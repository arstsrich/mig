# schedule_upmw.ps1
# Schedules UPMW to run silently on July 4, 2025 at 9:00 AM

# File locations
$exePath    = "C:\Profwiz.exe"
$configPath = "C:\profwiz.config"
$xmlPath    = "C:\upmw.xml"

# Validate presence
if (!(Test-Path $exePath)) {
    Write-Error "❌ Profwiz.exe not found at $exePath"
    exit 1
}
if (!(Test-Path $configPath)) {
    Write-Error "❌ profwiz.config not found at $configPath"
    exit 1
}
if (!(Test-Path $xmlPath)) {
    Write-Error "❌ upmw.xml not found at $xmlPath"
    exit 1
}

# Task details
$taskName = "UPMW_Profile_Migration"
$taskTime = "09:00"
$taskDate = "2025-07-04"
$arguments = "/quiet"

# Define task
$action = New-ScheduledTaskAction -Execute $exePath -Argument $arguments
$trigger = New-ScheduledTaskTrigger -Once -At "$taskDate $taskTime"
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

# Register task
try {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Force
    Write-Host "✅ Task '$taskName' scheduled for $taskDate at $taskTime"
}
catch {
    Write-Error "❌ Failed to schedule task: $_"
    exit 1
}
