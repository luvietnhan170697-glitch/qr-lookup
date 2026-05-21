@echo off
setlocal EnableExtensions
chcp 65001 >nul

REM ===== Cau hinh thu muc project =====
cd /d "C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"

set LOG=push_github_log.txt

echo =============================== > "%LOG%"
echo Bat dau push GitHub: %date% %time% >> "%LOG%"
echo =============================== >> "%LOG%"
echo.
echo Dang push len GitHub...
echo Log se luu tai: %CD%\%LOG%
echo.

REM Kiem tra co dung thu muc Git khong
git rev-parse --is-inside-work-tree >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [LOI] Thu muc nay khong phai Git repo.
    echo [LOI] Thu muc nay khong phai Git repo. >> "%LOG%"
    pause
    exit /b 1
)

REM Neu lan truoc dang rebase do dang, huy de chay lai sach
git rebase --abort >> "%LOG%" 2>&1

REM Dam bao o nhanh main
git checkout main >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [LOI] Khong checkout duoc nhanh main.
    echo Hay mo file %LOG% de xem chi tiet.
    pause
    exit /b 1
)

REM Dua tat ca thay doi local vao commit truoc, de pull khong bi loi unstaged changes
git add -A >> "%LOG%" 2>&1
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Update QR images" >> "%LOG%" 2>&1
    if errorlevel 1 (
        echo [LOI] Commit that bai.
        echo Hay mo file %LOG% de xem chi tiet.
        pause
        exit /b 1
    )
) else (
    echo Khong co thay doi moi de commit.
    echo Khong co thay doi moi de commit. >> "%LOG%"
)

REM Lay code moi tu GitHub va rebase commit local len tren
echo Dang cap nhat tu GitHub...
git pull --rebase origin main >> "%LOG%" 2>&1
if errorlevel 1 (
    echo.
    echo [LOI] Pull/Rebase that bai. Co the dang bi conflict.
    echo Mo file %LOG% de xem file nao conflict.
    echo Sau khi sua conflict, chay: git add .
    echo Roi chay: git rebase --continue
    echo.
    pause
    exit /b 1
)

REM Push len GitHub
echo Dang day len GitHub...
git push origin main >> "%LOG%" 2>&1
if errorlevel 1 (
    echo.
    echo [LOI] Push that bai.
    echo Hay mo file %LOG% de xem chi tiet.
    echo.
    pause
    exit /b 1
)

echo.
echo Push thanh cong!
echo Push thanh cong! >> "%LOG%"
echo.
pause
