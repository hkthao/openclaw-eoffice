# Sử dụng base image của Playwright có sẵn môi trường browser
FROM mcr.microsoft.com/playwright:v1.43.0-jammy

# Cài đặt uv (package manager cho Python)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Thiết lập thư mục làm việc
WORKDIR /app

# Ngăn Python tạo bytecode và buffering log
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DISPLAY=:1

# Cài đặt dependencies hệ thống: Xvfb, VNC, noVNC, OCR, v.v.
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    python3-tk \
    python3-dev \
    tesseract-ocr \
    libtesseract-dev \
    net-tools \
    git \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập noVNC
RUN ln -s /usr/share/novnc /opt/novnc && \
    ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Copy các file cấu hình dependencies
COPY pyproject.toml uv.lock* ./

# Cài đặt dependencies (bao gồm tenacity, loguru...)
RUN uv sync --no-dev

# Copy toàn bộ mã nguồn và entrypoint
COPY . .

# Phân quyền thực thi cho entrypoint script
RUN chmod +x entrypoint.sh

# Port cho noVNC và VNC (tùy chọn)
EXPOSE 6080 5900

# Khởi động thông qua entrypoint để quản lý display
ENTRYPOINT ["./entrypoint.sh"]
