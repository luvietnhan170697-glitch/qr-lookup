import os
import re
from flask import Flask, render_template, request, send_from_directory, abort

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
QR_FOLDER = os.path.join(BASE_DIR, "qr_images")

app = Flask(__name__, template_folder="templates")


def normalize_cccd(text):
    return re.sub(r"\D", "", str(text or "")).strip()


def parse_name_from_filename(filename):
    stem = os.path.splitext(filename)[0]
    parts = stem.split("_")
    if len(parts) >= 2:
        return " ".join(parts[:-1]).title()
    return stem


def find_qr_file_by_cccd(cccd):
    if not os.path.isdir(QR_FOLDER):
        return None

    for name in os.listdir(QR_FOLDER):
        if not name.lower().endswith((".png", ".jpg", ".jpeg")):
            continue

        stem = os.path.splitext(name)[0]
        parts = stem.split("_")
        if not parts:
            continue

        file_cccd = parts[-1]
        if file_cccd == cccd:
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

        student_name = parse_name_from_filename(filename)
        return render_template(
            "result.html",
            cccd=cccd,
            filename=filename,
            student_name=student_name
        )

    return render_template("index.html")


@app.route("/qr/<path:filename>")
def serve_qr(filename):
    full_path = os.path.join(QR_FOLDER, filename)
    if not os.path.exists(full_path):
        abort(404)
    return send_from_directory(QR_FOLDER, filename)


@app.route("/health")
def health():
    return "OK", 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
