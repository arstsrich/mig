# schedule_upmw.ps1
# Schedules UPMW (Professional) to run silently on July 4, 2025 at 9:00 AM

# File checks
$exePath    = "C:\Profwiz.exe"
$configPath = "C:\profwiz.config"
$xmlPath    = "C:\upmw.xml"

if (!(Test-Path $exePath)) {
    Write-Error "❌ Missing: Profwiz.exe"
    exit 1
}
if (!(Test-Path $configPath)) {
    Write-Error "❌ Missing: profwiz.config"
    exit 1
}
if (!(Test-Path $xmlPath)) {
    Write-Error "❌ Missing: upmw.xml"
    exit 1
}

# Task setup
$taskName = "UPMW_Profile_Migration"
$taskTime = "09:00"
$taskDate = "2025-07-04"
$arguments = "/quiet"

$action = New-ScheduledTaskAction -Execute $exePath -Argument $arguments
$trigger = New-ScheduledTaskTrigger -Once -At "$taskDate $taskTime"
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

try {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Force
    Write-Host "✅ Scheduled task '$taskName' set for $taskDate at $taskTime"
}
catch {
    Write-Error "❌ Failed to register task: $_"
    exit 1
}
