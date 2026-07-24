# Tra Cứu Mã Qr Thi Sát Hạch Sa Hình

Ứng dụng Flask tra cứu mã QR theo số CCCD.

## Đưa lên GitHub

1. Tạo repository mới tên `qr-sa-hinh`.
2. Tải toàn bộ file trong thư mục này lên repository.
3. Không tải riêng thư mục cha; file `app.py` phải nằm ở cấp gốc repository.

## Deploy trên Render

- Chọn **New → Web Service**.
- Kết nối repository `qr-sa-hinh`.
- Build Command: `pip install -r requirements.txt`
- Start Command: `gunicorn app:app`

## Nội dung cảnh báo

- Học viên chỉ được quét mã QR thi sát hạch SA HÌNH khi thi đạt nội dung LÝ THUYẾT.
- Học viên thi rớt LÝ THUYẾT tuyệt đối không được quét QR nội dung thi sát hạch SA HÌNH.
