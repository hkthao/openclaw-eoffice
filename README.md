# openclaw-eoffice

AI Agent tự động hóa các tác vụ trên phần mềm eOffice sử dụng framework OpenClaw (Official Image).

## 🚀 Giới thiệu

**openclaw-eoffice** là một hệ thống AI Agent được thiết kế để hỗ trợ người dùng thực hiện các quy trình nghiệp vụ trên phần mềm eOffice (như xử lý công văn, phê duyệt hồ sơ, tra cứu thông tin) một cách tự động và thông minh. Dự án hiện tại sử dụng **OpenClaw Gateway** chính thức chạy trên Docker.

Hệ thống kết hợp sức mạnh của:
- **OpenClaw (Official)**: Framework điều khiển Agent, quản lý lập kế hoạch (planning) và thực thi (Computer Use).
- **LLM (Ollama, OpenAI, Gemini)**: Bộ não phân tích yêu cầu và ra quyết định.
- **Playwright**: Tự động hóa tương tác trên giao diện web eOffice tích hợp sẵn trong OpenClaw.

## 📁 Cấu trúc thư mục

```text
openclaw-eoffice/
├── workspace/          # Không gian làm việc cho Agent (Files, screenshots, logs)
├── docker-compose.yml  # Cấu hình dịch vụ OpenClaw Gateway và CLI
├── GEMINI.md           # Quy tắc phát triển và quy trình đóng góp
├── .env.example        # File cấu hình mẫu cho biến môi trường
└── README.md
```

## ⚙️ Cài đặt & Sử dụng

### 1. Yêu cầu hệ thống
- Docker & Docker Compose cài đặt sẵn.
- **Ollama** (khuyên dùng để chạy LLM local) hoặc API key cho OpenAI/Gemini.

### 2. Cấu hình biến môi trường
Sao chép file `.env.example` thành `.env` và điền các thông tin cần thiết:
```bash
cp .env.example .env
```

### 3. Khởi chạy với Docker
Trước khi khởi chạy, hãy đảm bảo thư mục `workspace` có quyền truy cập đúng trên macOS:
```bash
chmod -R 777 workspace
```

Khởi chạy OpenClaw Gateway:
```bash
docker compose up -d
```

Hệ thống sẽ chạy tại:
- **OpenClaw Dashboard:** [http://localhost:18789](http://localhost:18789)

### 4. Truy cập CLI (tùy chọn)
Để chạy các lệnh quản trị của OpenClaw (như cấu hình kênh messaging):
```bash
docker compose run --rm openclaw-cli dashboard --no-open
```

## 🖥 Hoạt động

1. **Dashboard:** Truy cập cổng `18789` để cấu hình LLM Provider và System Prompt cho eOffice.
2. **Workspace:** Tất cả các tệp tin mà Agent tạo ra hoặc cần đọc sẽ nằm trong thư mục `./workspace`.
3. **Computer Use:** OpenClaw tự động điều khiển trình duyệt để đăng nhập và thực hiện tác vụ trên eOffice theo yêu cầu của bạn qua Dashboard hoặc API.

## 🐳 Kết nối LLM (Ollama)
Nếu bạn chạy Ollama trên máy host, OpenClaw được cấu hình để kết nối qua:
`http://host.docker.internal:11434`

## 🤝 Đóng góp

Vui lòng đọc kỹ file [GEMINI.md](./GEMINI.md) để hiểu về quy trình phát triển, quy tắc commit và workflow của dự án.

---
*Dự án đang sử dụng OpenClaw Framework làm nền tảng cốt lõi.*
