# Tra Cứu Mã Qr Thi Sát Hạch Đường Trường

Ứng dụng Flask tra cứu mã QR theo số CCCD.

## Đưa lên GitHub

1. Tạo repository mới tên `qr-duong-truong`.
2. Tải toàn bộ file trong thư mục này lên repository.
3. Không tải riêng thư mục cha; file `app.py` phải nằm ở cấp gốc repository.

## Deploy trên Render

- Chọn **New → Web Service**.
- Kết nối repository `qr-duong-truong`.
- Build Command: `pip install -r requirements.txt`
- Start Command: `gunicorn app:app`

## Nội dung cảnh báo

- Học viên chỉ được quét mã QR thi sát hạch ĐƯỜNG TRƯỜNG khi thi đạt nội dung SA HÌNH.
- Học viên thi rớt SA HÌNH tuyệt đối không được quét QR nội dung thi sát hạch ĐƯỜNG TRƯỜNG.
