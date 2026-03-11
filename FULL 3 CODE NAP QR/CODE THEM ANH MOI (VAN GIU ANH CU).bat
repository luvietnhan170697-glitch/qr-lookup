@echo off
cd /d "C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"

echo Pull latest...
git pull origin main --rebase

echo Add new images...
git add qr_images

echo Commit...
git commit -m "Add more QR images"

echo Push to GitHub...
git push origin main

echo DONE
pause