@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

REM ==============================
REM CONFIG
REM ==============================

set REPO_DIR=C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR
set QR_DIR=%REPO_DIR%\qr_images
set BRANCH=main

:menu
cls
echo ====================================
echo         QR MANAGER PRO
echo ====================================
echo.
echo Repo   : %REPO_DIR%
echo Folder : %QR_DIR%
echo.
echo 1 Replace QR images
echo 2 Add more images
echo 3 Clear qr_images
echo 4 Upload ALL images
echo 5 Fix Git errors
echo 6 Open qr_images folder
echo 7 Exit
echo.
set /p choice=Nhap lua chon (1-7): 

if "%choice%"=="1" goto replace
if "%choice%"=="2" goto add
if "%choice%"=="3" goto clear
if "%choice%"=="4" goto uploadall
if "%choice%"=="5" goto fixgit
if "%choice%"=="6" goto openfolder
if "%choice%"=="7" exit

goto menu

:prepare
cd /d "%REPO_DIR%"

echo.
echo Updating Git...

git add -A >nul 2>nul
git commit -m "auto save" >nul 2>nul

git pull origin %BRANCH% --rebase

goto :eof

:replace
call :prepare

echo.
echo Xoa anh cu...

del /q "%QR_DIR%\*" >nul 2>nul

echo.
echo Copy anh moi vao folder qr_images
pause

git add qr_images
git commit -m "Replace QR images"
git push origin %BRANCH%

echo DONE
pause
goto menu

:add
call :prepare

echo.
echo Copy anh moi vao folder qr_images
pause

git add qr_images
git commit -m "Add more QR images"
git push origin %BRANCH%

echo DONE
pause
goto menu

:clear
call :prepare

echo.
echo Dang xoa tat ca anh...

del /q "%QR_DIR%\*" >nul 2>nul

echo.> "%QR_DIR%\.gitkeep"

git add qr_images
git commit -m "Clear qr_images"
git push origin %BRANCH%

echo DONE
pause
goto menu

:uploadall
call :prepare

echo.
echo Upload tat ca anh trong qr_images...

git add qr_images
git commit -m "Upload QR images batch"
git push origin %BRANCH%

echo DONE
pause
goto menu

:fixgit

echo.
echo Dang sua loi Git...

git add -A
git commit -m "Fix Git state"
git pull origin %BRANCH% --rebase

echo Git OK
pause
goto menu

:openfolder

start "" "%QR_DIR%"
goto menu