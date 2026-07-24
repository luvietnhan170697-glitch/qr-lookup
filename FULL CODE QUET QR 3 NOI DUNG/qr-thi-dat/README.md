# Tra Cứu Mã Qr Đối Với Thí Sinh Đã Thi Đạt

Ứng dụng Flask tra cứu mã QR theo số CCCD.

## Đưa lên GitHub

1. Tạo repository mới tên `qr-thi-dat`.
2. Tải toàn bộ file trong thư mục này lên repository.
3. Không tải riêng thư mục cha; file `app.py` phải nằm ở cấp gốc repository.

## Deploy trên Render

- Chọn **New → Web Service**.
- Kết nối repository `qr-thi-dat`.
- Build Command: `pip install -r requirements.txt`
- Start Command: `gunicorn app:app`

## Nội dung cảnh báo

- Học viên chỉ được quét mã QR này khi đã ĐẠT tất cả nội dung sát hạch.
- Học viên thi rớt không được quét vào mã này.
