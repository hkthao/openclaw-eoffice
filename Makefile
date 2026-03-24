# Makefile cho openclaw-eoffice

.PHONY: up down restart logs ps cli token clean help

# Khởi chạy OpenClaw Gateway ở chế độ background
up:
	docker compose up -d

# Dừng tất cả các dịch vụ
down:
	docker compose down

# Khởi động lại các dịch vụ
restart:
	docker compose restart

# Xem log của OpenClaw Gateway
logs:
	docker compose logs -f openclaw-gateway

# Kiểm tra trạng thái các container
ps:
	docker compose ps

# Chạy OpenClaw CLI (Sử dụng: make cli CMD="dashboard --no-open")
cli:
	docker compose run --rm openclaw-cli $(CMD)

# Lấy token truy cập Dashboard
token:
	docker compose run --rm openclaw-cli dashboard --no-open

# Dọn dẹp workspace (Cẩn thận: xóa toàn bộ dữ liệu trong workspace)
clean:
	rm -rf workspace/*
	touch workspace/.gitkeep

# Hướng dẫn sử dụng
help:
	@echo "Các lệnh hỗ trợ:"
	@echo "  make up      - Khởi chạy OpenClaw Gateway"
	@echo "  make down    - Dừng các dịch vụ"
	@echo "  make restart - Khởi động lại các dịch vụ"
	@echo "  make logs    - Xem log của Gateway"
	@echo "  make ps      - Kiểm tra trạng thái container"
	@echo "  make token   - Lấy token truy cập Dashboard"
	@echo "  make cli CMD='...' - Chạy lệnh CLI tùy chỉnh"
	@echo "  make clean   - Xóa dữ liệu trong thư mục workspace"
