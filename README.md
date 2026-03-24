# openclaw-eoffice

AI Agent tự động hóa các tác vụ trên phần mềm eOffice sử dụng framework OpenClaw và LLM.

## 🚀 Giới thiệu

**openclaw-eoffice** là một hệ thống AI Agent được thiết kế để hỗ trợ người dùng thực hiện các quy trình nghiệp vụ trên phần mềm eOffice (như xử lý công văn, phê duyệt hồ sơ, tra cứu thông tin) một cách tự động và thông minh. Hệ thống kết hợp sức mạnh của:
- **OpenClaw**: Framework điều khiển Agent, quản lý lập kế hoạch (planning) và thực thi.
- **LLM (OpenAI, Gemini, Ollama)**: Bộ não phân tích yêu cầu và ra quyết định.
- **Playwright**: Tự động hóa tương tác trên giao diện web eOffice.

## 🛠 Tech Stack

- **Ngôn ngữ**: Python 3.12+
- **Quản lý package**: `uv`
- **Automation**: Playwright
- **Agent Framework**: OpenClaw
- **Kiểm thử**: Pytest
- **Linting/Formatting**: Ruff

## 📁 Cấu trúc thư mục

```text
openclaw-eoffice/
├── src/
│   ├── agents/      # Định nghĩa các Agent (eOfficeAgent, MailAgent...)
│   ├── tools/       # Các công cụ hỗ trợ (browser_tools, office_tools...)
│   ├── core/        # Logic cốt lõi, tích hợp OpenClaw & LLM
│   ├── schemas/     # Định nghĩa dữ liệu (Pydantic models)
│   └── utils/       # Các hàm tiện ích (logger, config...)
├── tests/           # Unit tests & Integration tests
├── docs/            # Tài liệu hướng dẫn sử dụng và thiết kế
└── ...
```

## ⚙️ Cài đặt

1. **Cài đặt uv** (nếu chưa có):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. **Cài đặt môi trường và dependencies**:
   ```bash
   uv sync
   ```

3. **Cấu hình biến môi trường**:
   Sao chép file `.env.example` thành `.env` và điền các thông tin cần thiết:
   ```bash
   cp .env.example .env
   ```

4. **Cài đặt Playwright Browsers**:
   ```bash
   uv run playwright install chromium
   ```

## 🖥 Sử dụng

Chạy Agent chính:
```bash
uv run main.py
```

Chạy kiểm thử:
```bash
uv run pytest
```

## 🤝 Đóng góp

Vui lòng đọc kỹ file [GEMINI.md](./GEMINI.md) để hiểu về quy trình phát triển, quy tắc commit và workflow của dự án trước khi thực hiện bất kỳ thay đổi nào.

---
*Dự án đang trong quá trình phát triển.*
