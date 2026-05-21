@echo off
chcp 65001 >nul
setlocal

set "REPO_DIR=C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"
set "BRANCH=main"
set "REMOTE=origin"
set "LOG=%TEMP%\push_github_log.txt"

echo Dang push len GitHub...
echo Log luu tai: %LOG%
echo ============================== > "%LOG%"
echo Bat dau push GitHub: %date% %time% >> "%LOG%"
echo ============================== >> "%LOG%"

cd /d "%REPO_DIR%" || (
    echo [ERROR] Khong vao duoc thu muc project.
    echo [ERROR] Khong vao duoc thu muc project. >> "%LOG%"
    pause
    exit /b 1
)

git checkout %BRANCH% >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [ERROR] Khong checkout duoc branch %BRANCH%.
    pause
    exit /b 1
)

git rebase --abort >> "%LOG%" 2>&1

git reset -- push_github_log.txt >> "%LOG%" 2>&1

git add -A >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [ERROR] git add that bai. Xem log: %LOG%
    pause
    exit /b 1
)

git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Update QR images" >> "%LOG%" 2>&1
    if errorlevel 1 (
        echo [ERROR] git commit that bai. Xem log: %LOG%
        pause
        exit /b 1
    )
) else (
    echo Khong co thay doi moi de commit. >> "%LOG%"
)

git fetch %REMOTE% %BRANCH% >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [ERROR] git fetch that bai. Kiem tra internet / remote. Xem log: %LOG%
    pause
    exit /b 1
)

git push --force-with-lease %REMOTE% %BRANCH% >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [ERROR] Push that bai. Xem log: %LOG%
    pause
    exit /b 1
)

echo.
echo Push thanh cong!
echo Log: %LOG%
pause
endlocal
