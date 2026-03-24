.PHONY: setup run test lint format dev stop logs clean help

# Mặc định khi chỉ gõ 'make'
help:
	@echo "Các lệnh hỗ trợ:"
	@echo "  make setup    - Cài đặt môi trường và các dependencies (uv)"
	@echo "  make run      - Chạy Agent local"
	@echo "  make test     - Chạy unit tests"
	@echo "  make lint     - Kiểm tra lỗi code (ruff)"
	@echo "  make format   - Tự động format code (ruff)"
	@echo "  make dev      - Khởi động dự án bằng Docker Compose"
	@echo "  make stop     - Dừng tất cả containers"
	@echo "  make logs     - Xem log của Agent trong Docker"
	@echo "  make clean    - Xóa các file rác, cache"

# Cài đặt môi trường
setup:
	uv sync
	uv run playwright install chromium

# Chạy ứng dụng local
run:
	uv run main.py

# Kiểm thử
test:
	uv run pytest

# Kiểm tra code style
lint:
	uv run ruff check .

# Định dạng code
format:
	uv run ruff format .

# Docker commands
dev:
	docker compose up -d --build

stop:
	docker compose down

logs:
	docker compose logs -f agent

# Dọn dẹp cache
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
