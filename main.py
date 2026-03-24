import os
from dotenv import load_dotenv
from loguru import logger
from src.core.agent_factory import AgentFactory

# Load environment variables
load_dotenv()

def main():
    logger.info("Khởi động openclaw-eoffice Agent...")
    
    eoffice_url = os.getenv("EOFFICE_URL")
    if not eoffice_url:
        logger.error("Vui lòng cấu hình EOFFICE_URL trong file .env")
        return

    logger.info(f"Đang chuẩn bị kết nối tới: {eoffice_url}")
    
    try:
        # Khởi tạo OpenClaw Agent dựa trên cấu hình LLM
        agent = AgentFactory.create_agent()
        
        # Ví dụ một câu lệnh đơn giản cho Agent
        # prompt = f"Đăng nhập vào eoffice tại {eoffice_url} và kiểm tra danh sách công văn mới"
        # agent.run(prompt)
        
        logger.info("Agent đã sẵn sàng!")
    except Exception as e:
        logger.error(f"Lỗi khi khởi tạo Agent: {e}")

if __name__ == "__main__":
    main()
