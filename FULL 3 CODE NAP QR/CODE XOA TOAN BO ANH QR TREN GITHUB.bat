@echo off
cd /d "C:\Users\Admin\Documents\SQL Server Management Studio\XUAT IMAGE QR"

echo Delete all images...
del /q "qr_images\*"

echo Keep folder...
echo.> qr_images\.gitkeep

git add -A qr_images
git commit -m "Clear qr_images"
git push origin main

echo DONE
pause