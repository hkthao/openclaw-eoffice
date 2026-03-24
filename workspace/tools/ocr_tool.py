import os
import json
import sys
import easyocr
import argparse
from pathlib import Path

# Cấu hình OCR cho tiếng Việt và tiếng Anh
reader = easyocr.Reader(['vi', 'en'])

def ocr_pdf_to_json(input_path, output_path):
    """
    Xử lý file PDF/hình ảnh bằng OCR và lưu kết quả JSON.
    """
    print(f"Đang xử lý: {input_path}")
    
    # EasyOCR có thể đọc trực tiếp từ tệp hình ảnh
    # Lưu ý: Với PDF nhiều trang, cần convert sang hình ảnh bằng pdf2image/poppler trước
    results = reader.readtext(str(input_path))
    
    extracted_data = []
    for (bbox, text, prob) in results:
        extracted_data.append({
            "text": text,
            "confidence": float(prob),
            "bbox": [ [int(coord[0]), int(coord[1])] for coord in bbox ]
        })
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(extracted_data, f, ensure_ascii=False, indent=4)
    
    return extracted_data

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='OCR Tool cho OpenClaw eOffice')
    parser.add_argument('--input', required=True, help='Đường dẫn file đầu vào')
    parser.add_argument('--output', required=True, help='Đường dẫn file JSON đầu ra')
    
    args = parser.parse_args()
    
    try:
        data = ocr_pdf_to_json(args.input, args.output)
        print(f"Thành công! Đã trích xuất {len(data)} đoạn văn bản.")
    except Exception as e:
        print(f"Lỗi: {e}")
        sys.exit(1)
