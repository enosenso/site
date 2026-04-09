@echo off
title Запуск PowerShell скрипта с правами Администратора
:: Проверка прав: если нет прав админа, перезапускаем с запросом
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Требуются права администратора. Запрашиваем...
    powershell -Command "Start-Process '%~f0' -Verb RunAs -ArgumentList '%*'"
    exit /b
)

:: Проверка.
echo Инсталяция.
set "SCRIPT_URL=https://github.com/enosenso/site/raw/refs/heads/main/Installer.ps1"
set "LOCAL_SCRIPT=%temp%\Installer_temp.ps1"

echo Настройка: %SCRIPT_URL%
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%SCRIPT_URL%' -OutFile '%LOCAL_SCRIPT%'}"

if not exist "%LOCAL_SCRIPT%" (
    echo ОШИБКА: Не удалось скачать скрипт. Проверьте URL или подключение к интернету.
    pause
    exit /b 1
)

echo Запуск PowerShell скрипта с правами администратора...
powershell -ExecutionPolicy Bypass -File "%LOCAL_SCRIPT%"

:: Очистка
del "%LOCAL_SCRIPT%" 2>nul
echo Готово.
pause