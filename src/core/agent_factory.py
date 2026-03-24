import os
from openclaw import OpenClaw
from loguru import logger

class AgentFactory:
    @staticmethod
    def create_agent():
        provider = os.getenv("LLM_PROVIDER", "openai").lower()
        model_name = os.getenv("MODEL_NAME", "gpt-4o")
        
        logger.info(f"Đang khởi tạo Agent với provider: {provider}, model: {model_name}")
        
        config = {
            "debug": os.getenv("OPENCLAW_DEBUG", "true").lower() == "true",
            "headless": os.getenv("HEADLESS_MODE", "false").lower() == "true",
        }
        
        if provider == "ollama":
            base_url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")
            # Cấu hình cụ thể cho Ollama trong OpenClaw
            config["llm"] = {
                "provider": "ollama",
                "model": model_name,
                "base_url": base_url
            }
        elif provider == "openai":
            config["llm"] = {
                "provider": "openai",
                "model": model_name,
                "api_key": os.getenv("OPENAI_API_KEY")
            }
        else:
            raise ValueError(f"Không hỗ trợ LLM provider: {provider}")
            
        return OpenClaw(**config)
