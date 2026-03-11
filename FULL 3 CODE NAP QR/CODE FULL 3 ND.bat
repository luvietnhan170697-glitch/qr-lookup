@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

REM ====== CAU HINH ======
set "REPO_DIR=C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"
set "QR_DIR=%REPO_DIR%\qr_images"
set "BRANCH=main"

:menu
cls
echo ============================================
echo           QR IMAGES GITHUB MANAGER
echo ============================================
echo.
echo Repo    : %REPO_DIR%
echo Folder  : %QR_DIR%
echo Branch  : %BRANCH%
echo.
echo 1 - Replace QR images
echo 2 - Add more images
echo 3 - Clear qr_images
echo 4 - Exit
echo.
set /p choice=Nhap lua chon cua ban ^(1/2/3/4^): 

if "%choice%"=="1" goto replace_images
if "%choice%"=="2" goto add_images
if "%choice%"=="3" goto clear_images
if "%choice%"=="4" goto end
goto menu

:check_repo
if not exist "%REPO_DIR%\.git" (
    echo.
    echo [ERROR] Khong tim thay repo Git:
    echo %REPO_DIR%
    pause
    goto menu
)
cd /d "%REPO_DIR%"
goto :eof

:pull_latest
echo.
echo [1/4] Pull code moi nhat...
git pull origin %BRANCH% --rebase
if errorlevel 1 (
    echo [ERROR] pull that bai.
    pause
    goto menu
)
goto :eof

:replace_images
call :check_repo
if not exist "%QR_DIR%" mkdir "%QR_DIR%"

echo.
echo ============================================
echo REPLACE QR IMAGES
echo ============================================
echo.
echo Hay lam nhu sau:
echo  - Xoa tat ca anh cu trong folder qr_images
echo  - Copy batch anh moi vao folder qr_images
echo.
echo Nhan phim bat ky khi da copy xong...
pause >nul

call :pull_latest

echo [2/4] Add thay doi trong qr_images...
git add -A qr_images
if errorlevel 1 (
    echo [ERROR] git add that bai.
    pause
    goto menu
)

echo [3/4] Commit...
git commit -m "Replace QR images batch"
if errorlevel 1 (
    echo [INFO] Khong co gi de commit.
)

echo [4/4] Push len GitHub...
git push origin %BRANCH%
if errorlevel 1 (
    echo [ERROR] push that bai.
    pause
    goto menu
)

echo.
echo [DONE] Da replace qr_images thanh cong.
pause
goto menu

:add_images
call :check_repo
if not exist "%QR_DIR%" mkdir "%QR_DIR%"

echo.
echo ============================================
echo ADD MORE IMAGES
echo ============================================
echo.
echo Hay lam nhu sau:
echo  - Copy anh moi vao folder qr_images
echo  - Anh cu se duoc giu nguyen
echo.
echo Nhan phim bat ky khi da copy xong...
pause >nul

call :pull_latest

echo [2/4] Add thay doi trong qr_images...
git add -A qr_images
if errorlevel 1 (
    echo [ERROR] git add that bai.
    pause
    goto menu
)

echo [3/4] Commit...
git commit -m "Add more QR images"
if errorlevel 1 (
    echo [INFO] Khong co gi de commit.
)

echo [4/4] Push len GitHub...
git push origin %BRANCH%
if errorlevel 1 (
    echo [ERROR] push that bai.
    pause
    goto menu
)

echo.
echo [DONE] Da them anh moi vao qr_images.
pause
goto menu

:clear_images
call :check_repo
if not exist "%QR_DIR%" mkdir "%QR_DIR%"

echo.
echo ============================================
echo CLEAR QR_IMAGES
echo ============================================
echo.
set /p confirm=Ban co chac chan muon xoa toan bo anh trong qr_images khong? ^(Y/N^): 
if /I not "%confirm%"=="Y" goto menu

call :pull_latest

echo [2/4] Xoa toan bo file trong qr_images...
del /q "%QR_DIR%\*" >nul 2>nul

echo [3/4] Tao file .gitkeep de giu folder...
echo.> "%QR_DIR%\.gitkeep"

echo [4/4] Add, commit, push...
git add -A qr_images
git commit -m "Clear qr_images"
if errorlevel 1 (
    echo [INFO] Khong co gi de commit.
)
git push origin %BRANCH%
if errorlevel 1 (
    echo [ERROR] push that bai.
    pause
    goto menu
)

echo.
echo [DONE] Da xoa toan bo anh trong qr_images va giu lai folder.
pause
goto menu

:end
echo.
echo Thoat chuong trinh.
timeout /t 1 >nul
endlocal
exit /b