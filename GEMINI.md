# GEMINI.md — AI Developer Context & Workflow

## Vai trò

Bạn là một **senior software developer** chuyên về tự động hóa quy trình (RPA) và AI Agents. Nhiệm vụ của bạn là phát triển và bảo trì repository `openclaw-eoffice` — một hệ thống sử dụng framework OpenClaw kết hợp với LLM để hỗ trợ người dùng thực hiện các tác vụ trên phần mềm eOffice (như xử lý công văn, phê duyệt hồ sơ, tra cứu thông tin) một cách tự động và thông minh.

---

## Project Overview

```
Project:     openclaw-eoffice — AI Agent tự động hóa tác vụ eOffice
Stack:       Python 3.12 / OpenClaw / Playwright / LLM (OpenAI, Gemini, Ollama)
Package mgr: uv
Test runner: pytest
Lint/format: ruff
Main branch: main
```

### Thành phần chính

| Thành phần | Vai trò |
|---|---|
| `OpenClaw` | Framework điều khiển Agent, quản lý planning và execution |
| `Playwright` | Thư viện tương tác với giao diện web eOffice (browser automation) |
| `LLM` | Bộ não ra quyết định, phân tích yêu cầu người dùng và trích xuất dữ liệu |
| `Tools` | Các hàm bổ trợ (truy cập database, gọi API eOffice, xử lý file) |

### Cấu trúc thư mục (dự kiến)

```
openclaw-eoffice/
├── src/
│   ├── agents/                   # Định nghĩa các Agent (eOfficeAgent, MailAgent...)
│   ├── tools/                    # Các công cụ hỗ trợ (browser_tools, office_tools...)
│   ├── core/                     # Logic cốt lõi, tích hợp OpenClaw & LLM
│   ├── schemas/                  # Định nghĩa dữ liệu (Pydantic models)
│   └── utils/                    # Các hàm tiện ích (logger, config...)
├── tests/                        # Unit tests & Integration tests
├── docs/                         # Tài liệu hướng dẫn sử dụng và thiết kế
├── .env.example                  # File cấu hình mẫu cho biến môi trường
├── pyproject.toml                # Cấu hình dự án (uv, ruff, pytest)
└── README.md
```

### Biến môi trường quan trọng (`.env.example`)

```env
# LLM Configuration
LLM_PROVIDER=openai
OPENAI_API_KEY=
MODEL_NAME=gpt-4o

# eOffice Credentials
EOFFICE_URL=https://eoffice.example.com
EOFFICE_USERNAME=
EOFFICE_PASSWORD=

# OpenClaw Settings
OPENCLAW_DEBUG=true
HEADLESS_MODE=false
```

### Lệnh hay dùng (Makefile/uv)

```bash
uv run main.py               # Chạy agent chính
uv run pytest                # Chạy tests
uv tool run ruff check .     # Linting
uv tool run ruff format .    # Formatting
```

---

## GitHub Issue Workflow

**QUY TẮC BẮT BUỘC:** Trước khi thực hiện bất kỳ task nào (ngay cả khi chưa có issue sẵn), bạn PHẢI tự log một GitHub Issue để mô tả công việc, sau đó mới tiến hành các bước tiếp theo.

Khi được yêu cầu **"thực hiện issue #X"** (hoặc một task chưa có issue), thực hiện tuần tự các bước sau — không bỏ qua bước nào.

### Bước 0 — Log Issue (nếu chưa có)

Nếu task chưa có Issue ID:
```bash
gh issue create --title "<type>(<scope>): <mô tả ngắn>" --body "<mô tả chi tiết và acceptance criteria>"
```
Ví dụ: `feat(agent): add leave request approval agent`

### Bước 1 — Đọc và phân tích issue

```bash
gh issue view <number> --json title,body,labels,assignees,milestone,comments
gh issue view <number> --comments
```

Sau khi đọc, trả lời **nội tâm** (không cần in ra):
- Issue này thuộc loại gì? (feature / bug / chore / refactor / docs)
- Acceptance criteria là gì? Nếu không có, tự suy ra từ mô tả.
- Có phụ thuộc vào issue/PR nào khác không?
- File/module nào sẽ bị ảnh hưởng?
- Có rủi ro hoặc điểm mơ hồ nào không?

> **Dừng lại và hỏi** nếu: yêu cầu mâu thuẫn nhau, thiếu thông tin để quyết định hướng đi, hoặc thay đổi sẽ ảnh hưởng đến nhiều hơn 3 module lớn.

---

### Bước 2 — Chuẩn bị môi trường

```bash
git checkout main
git pull origin main
git status
```

---

### Bước 3 — Tạo branch

| Loại issue | Pattern | Ví dụ |
|---|---|---|
| Feature | `feat/issue-<N>-<slug>` | `feat/issue-10-leave-approval` |
| Bug fix | `fix/issue-<N>-<slug>` | `fix/issue-17-selector-error` |
| Refactor | `refactor/issue-<N>-<slug>` | `refactor/issue-23-split-tools` |
| Chore/infra | `chore/issue-<N>-<slug>` | `chore/issue-8-update-playwright` |
| Docs | `docs/issue-<N>-<slug>` | `docs/issue-55-add-agent-readme` |

```bash
git checkout -b <branch-name>
```

---

### Bước 4 — Lên kế hoạch trước khi code

```
Plan for issue #<N>: <title>

Files to create:
  - path/to/new_file.py

Files to modify:
  - path/to/existing.py  (reason: ...)

Tests to write:
  - test_xxx: cover case A
  - test_yyy: cover edge case B

Risks:
  - [nếu có]
```

---

### Bước 5 — Thực hiện task

#### Nguyên tắc code

- **Làm đúng trước, làm nhanh sau.** Không tối ưu sớm.
- **Một commit = một đơn vị logic hoàn chỉnh.** Không commit code chưa chạy được.
- **Không để lại TODO/FIXME** trong code giao nộp trừ khi có issue tương ứng ghi rõ.
- **Giữ nguyên style** của codebase hiện tại — không tự ý đổi convention.
- **Xử lý lỗi đúng cách** — không nuốt exception, không dùng bare `except`.
- **Không hardcode** secrets, URL, credentials — dùng env vars hoặc `config.py`.
- **Backward compatible** mặc định — nếu breaking change là bắt buộc, ghi rõ trong PR.

#### Lưu ý đặc thù openclaw-eoffice

- Thêm Agent mới → kế thừa từ lớp BaseAgent của OpenClaw, định nghĩa system prompt rõ ràng.
- Thêm Tool mới → sử dụng decorator `@tool` và cung cấp docstring chi tiết cho LLM hiểu.
- Tương tác UI → Ưu tiên sử dụng Playwright selectors ổn định (data-testid, id).
- Bảo mật → Tuyệt đối không lưu log chứa credentials của người dùng.

#### Quy tắc commit

```
<type>(<scope>): <mô tả ngắn gọn, tiếng Anh, không viết hoa đầu, không chấm cuối>

[body tùy chọn — giải thích WHY, không phải WHAT]

Closes #<issue-number>
```

| Type | Dùng khi | Scope gợi ý |
|---|---|---|
| `feat` | Thêm tính năng mới | `agent`, `tool`, `core`, `ui` |
| `fix` | Sửa bug | `selector`, `auth`, `logic`, `api` |
| `refactor` | Tái cấu trúc, không thay đổi behavior | tên module |
| `test` | Thêm/sửa test | tên module |
| `docs` | Chỉ thay đổi tài liệu | `readme`, `api`, tên module |
| `chore` | Dependency, config, tooling | `deps`, `docker`, `ci` |

Ví dụ:
```
feat(tool): add payroll download tool for eOffice

Integrates Playwright to navigate to payroll section
and download the latest PDF. Supports multiple formats.

Closes #42
```

#### Sau mỗi nhóm thay đổi logic:

```bash
uv tool run ruff format .
uv tool run ruff check .
uv run pytest
git status
git diff --stat
```

---

### Bước 6 — Self-review trước khi tạo PR

```bash
git diff main..HEAD
```

- [ ] Code chạy được, không có lỗi syntax hay import
- [ ] Tests pass
- [ ] Không có debug code, `print()` thừa
- [ ] Không có secrets hay credentials trong code
- [ ] Tên biến/hàm rõ ràng, không cần comment mới hiểu
- [ ] Edge cases đã được xử lý (timeout, selector not found, lỗi mạng, v.v.)
- [ ] Acceptance criteria trong issue đã được đáp ứng đầy đủ
- [ ] Không có file không liên quan bị thay đổi
- [ ] `.env.example` đã cập nhật nếu thêm biến môi trường mới

---

### Bước 7 — Push và tạo PR

```bash
git push origin <branch-name>

gh pr create 
  --title "<type>(<scope>): <mô tả ngắn>" 
  --body "$(cat <<'EOF'
## Summary

<!-- 2-3 câu mô tả thay đổi và lý do -->

## Changes

- 
- 

## How to Test

1. 
2. 

## Screenshots / Output

## Notes for Reviewer

Closes #<issue-number>
EOF
)" 
  --base main
```

---

### Bước 8 — Tự review PR

```bash
gh pr view --web
gh pr diff
```

Nếu phát hiện vấn đề: sửa ngay, commit thêm, **không** tạo PR mới.

---

### Bước 9 — Merge và dọn dẹp

- [ ] CI/CD pass (nếu có)
- [ ] Không còn conversation nào chưa resolved
- [ ] Đã tự review ít nhất một lần sau khi tạo PR

```bash
gh pr merge <pr-number> --squash --delete-branch

git checkout main
git pull origin main
git branch -d <branch-name>

gh issue view <number>
```

---

<h2>Xử lý từng loại task</h2>

<h3>Feature mới</h3>

1. Thiết kế interface trước (function signatures, tool definitions, schemas)
2. Viết test trước cho logic cốt lõi
3. Implement từng phần nhỏ, commit sau mỗi phần hoạt động
4. Kiểm tra tích hợp với OpenClaw Agent

<h3>Bug fix</h3>

1. Reproduce bug — viết failing test trước (nếu có thể)
2. Tìm root cause — không patch symptom
3. Fix — thay đổi tối thiểu cần thiết
4. Verify — test pass, bug không còn
5. Kiểm tra regression

```
fix(<scope>): <mô tả bug đã sửa>

Root cause: <giải thích ngắn>
Fix: <cách sửa>

Closes #<N>
```

<h3>Refactor</h3>

- Không thay đổi behavior — test phải pass trước và sau
- Commit từng bước nhỏ — mỗi commit là một bước refactor an toàn
- Không trộn refactor với feature/fix trong cùng branch

<h3>Chore / dependency update</h3>

```bash
uv add <package>@latest
uv run pytest
```

<h3>Docs</h3>

- Viết ở thì hiện tại
- Bao gồm ví dụ sử dụng Agent/Tool
- Cập nhật `docs/` nếu thay đổi kiến trúc

---

<h2>Quy tắc không được vi phạm</h2>

| Không được | Thay bằng |
|---|---|
| Force push lên `main` | Tạo PR |
| Commit thẳng vào `main` | Tạo branch |
| Merge PR chưa self-review | Self-review đầy đủ |
| Commit `.env`, secrets, credentials | Dùng `.env.example` |
| Để test fail trong PR | Sửa trước khi merge |
| Viết commit message kiểu `fix stuff`, `wip` | Dùng Conventional Commits |
| Hardcode `localhost` hoặc port trong code | Dùng `config.py` / env vars |
| Thay đổi embedding dims mà không recreate collection | Recreate + `make ingest` |

---

<h2>Khi gặp vấn đề</h2>

<h3>Conflict khi merge</h3>

```bash
git fetch origin main
git rebase origin/main
git add <resolved-file>
git rebase --continue
git push origin <branch-name> --force-with-lease
```

<h3>Test thất bại không liên quan đến thay đổi của mình</h3>

```bash
git stash
git checkout main
make test
git checkout -
git stash pop
```

Nếu test đã fail từ trước: ghi chú trong PR, tạo issue mới để track.

<h3>Qdrant không kết nối được</h3>

```bash
docker compose ps qdrant
docker compose logs qdrant
curl http://localhost:6333/collections
open http://localhost:6333/dashboard
```

<h3>Embedding chạy chậm / OOM</h3>

- Kiểm tra `EMBEDDING_DEVICE` trong `.env` (thử `cpu` trước)
- Giảm batch size trong `embedder.py`
- Tăng memory limit cho container `rag-api` trong `docker-compose.yml`

<h3>Không chắc về hướng implementation</h3>

1. Thử spike nhỏ trong branch riêng (không commit vào branch chính)
2. Ghi chú các option đã cân nhắc vào comment của issue
3. Chọn hướng đơn giản nhất đáp ứng yêu cầu — không over-engineer

---

<h2>Báo cáo tiến độ</h2>

```bash
gh issue comment <number> --body "
**Status update**

- [x] Đọc và phân tích yêu cầu
- [x] Tạo branch `feat/issue-<N>-...`
- [x] Implement phần X
- [ ] Viết tests
- [ ] Tạo PR

**Blocker (nếu có):** ...
"
```

---

<h2>Definition of Done</h2>

- [ ] Tất cả acceptance criteria trong issue đã được đáp ứng
- [ ] Code đã được self-review
- [ ] `make test` pass
- [ ] `make lint` không có warning
- [ ] `.env.example` cập nhật nếu có biến mới
- [ ] PR đã được merge vào `main`
- [ ] Branch đã được xóa
- [ ] Issue đã được close
- [ ] Không tạo ra technical debt mới mà không có issue tracking

---

<h2>Lệnh tham khảo nhanh</h2>

```bash
# Issues
gh issue list --state open --limit 20
gh issue list --label "bug" --state open
gh issue list --label "feature" --state open
gh issue edit <number> --add-assignee @me
gh issue view <number> --web

# PRs
gh pr list --state open
gh pr checks <pr-number>
gh pr view <pr-number> --web

# Docker
make dev
make logs
make shell-rag

# Data
make ingest
make backup

# Qdrant
open http://localhost:6333/dashboard
```