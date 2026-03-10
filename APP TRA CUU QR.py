import os
import re
from flask import Flask, render_template, request, send_from_directory, abort

app = Flask(__name__)

QR_FOLDER = os.path.join(os.path.dirname(__file__), "qr_images")


def normalize_cccd(text):
    return re.sub(r"\D", "", str(text or "")).strip()


def find_qr_file_by_cccd(cccd):
    exts = [".png", ".jpg", ".jpeg"]

    # Tìm file đúng dạng CCCD.png
    for ext in exts:
        filename = cccd + ext
        path = os.path.join(QR_FOLDER, filename)
        if os.path.exists(path):
            return filename

    # Nếu không có thì tìm dạng TEN_CCCD.png
    for name in os.listdir(QR_FOLDER):
        lower = name.lower()
        if lower.endswith((".png", ".jpg", ".jpeg")):
            stem = os.path.splitext(name)[0]
            if stem == cccd or stem.endswith("_" + cccd):
                return name

    return None


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        cccd = normalize_cccd(request.form.get("cccd"))

        if not cccd:
            return render_template("index.html", error="Vui lòng nhập CCCD.")

        filename = find_qr_file_by_cccd(cccd)

        if not filename:
            return render_template("index.html", error="Không tìm thấy QR cho CCCD này.")

        return render_template("result.html", cccd=cccd, filename=filename)

    return render_template("index.html")


@app.route("/qr/<path:filename>")
def serve_qr(filename):
    full_path = os.path.join(QR_FOLDER, filename)
    if not os.path.exists(full_path):
        abort(404)
    return send_from_directory(QR_FOLDER, filename)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
