@echo off
chcp 65001 >nul
title Zen Temple Live - Chanh Dien Tinh Tam Pro
echo ======================================================
echo    ZEN TEMPLE LIVE - CHÁNH ĐIỆN TỊNH TÂM PRO
echo    Livestream Tuong Tac 2.5D Cho TikTok LIVE & OBS
echo ======================================================
echo.

where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [LOI] May chua cai dat Node.js!
    echo Vui long tai va cai dat Node.js tai: https://nodejs.org/ (Phien ban LTS hoac 20+)
    echo.
    pause
    exit /b 1
)

cd /d "%~dp0live"

if not exist "node_modules\" (
    echo [THONG BAO] Dang cai dat thu vien lan dau tien...
    npm install
    if %errorlevel% neq 0 (
        echo [LOI] Khong the cai dat dependencies. Kiem tra ket noi mang!
        pause
        exit /b 1
    )
)

echo [OK] Dang khoi chay Zen Temple Live Server...
start "" http://localhost:3300/live/control.html
node server.mjs
pause
