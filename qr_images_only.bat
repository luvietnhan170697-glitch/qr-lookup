@echo off
chcp 65001 >nul
cd /d "C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"

git checkout main
git pull origin main
git add -A
git commit -m "Update QR images"
git push origin main

pause