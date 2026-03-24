#!/bin/bash
set -e

# Khởi động Xvfb (Virtual Framebuffer)
echo "Starting Xvfb on display :1..."
Xvfb :1 -screen 0 1280x1024x24 &
export DISPLAY=:1

# Khởi động X11VNC để cho phép truy cập remote desktop
echo "Starting x11vnc..."
x11vnc -display :1 -nopw -forever -shared -bg -rfbport 5900

# Khởi động noVNC (Proxy từ VNC sang WebSocket cho trình duyệt)
echo "Starting noVNC on port 6080..."
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

# Đợi một chút để các dịch vụ display sẵn sàng
sleep 2

# Khởi động Agent thông qua uv
echo "Starting OpenClaw Agent..."
exec uv run main.py
