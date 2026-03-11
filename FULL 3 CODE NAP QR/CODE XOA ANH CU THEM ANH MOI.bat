@echo off
cd /d "C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"

echo Pull latest...
git pull origin main --rebase

echo Add changes...
git add -A qr_images

echo Commit...
git commit -m "Replace QR images batch"

echo Push to GitHub...
git push origin main

echo DONE
pause