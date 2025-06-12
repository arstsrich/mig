# download_upmw.ps1
# Downloads UPMW Professional Edition components to C:\

# --- RAW GitHub URLs ---
$profwizExeUrl   = "https://raw.githubusercontent.com/arstsrich/mig/main/Profwiz.exe"
$configFileUrl   = "https://raw.githubusercontent.com/arstsrich/mig/main/profwiz.config"
$userListXmlUrl  = "https://raw.githubusercontent.com/arstsrich/mig/main/upmw.xml"

# --- Local Destination Paths ---
$exePath    = "C:\Profwiz.exe"
$configPath = "C:\profwiz.config"
$xmlPath    = "C:\upmw.xml"

# --- Begin Downloads ---
try {
    Write-Host "📥 Downloading Profwiz.exe..."
    Invoke-WebRequest -Uri $profwizExeUrl -OutFile $exePath -UseBasicParsing

    Write-Host "📥 Downloading profwiz.config..."
    Invoke-WebRequest -Uri $configFileUrl -OutFile $configPath -UseBasicParsing

    Write-Host "📥 Downloading upmw.xml..."
    Invoke-WebRequest -Uri $userListXmlUrl -OutFile $xmlPath -UseBasicParsing
}
catch {
    Write-Error "❌ One or more downloads failed: $_"
    exit 1
}

# --- Validate Completion ---
if ((Test-Path $exePath) -and (Test-Path $configPath) -and (Test-Path $xmlPath)) {
    Write-Host "✅ UPMW files successfully downloaded to C:\"
} else {
    Write-Error "❌ One or more files are missing after download."
    exit 1
}
