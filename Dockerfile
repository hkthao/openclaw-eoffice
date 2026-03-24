FROM mcr.microsoft.com/playwright/python:v1.42.0-jammy

# Cài đặt uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy các file cấu hình dependencies
COPY pyproject.toml uv.lock* ./

# Cài đặt dependencies (không cài đặt dev dependencies)
RUN uv sync --frozen --no-dev

# Copy toàn bộ mã nguồn
COPY . .

# Cài đặt playwright browsers (nếu chưa có trong image)
RUN uv run playwright install chromium

# Thiết lập biến môi trường cho Python
ENV PYTHONUNBUFFERED=1
ENV PATH="/app/.venv/bin:$PATH"

# Chạy ứng dụng
CMD ["python", "main.py"]
