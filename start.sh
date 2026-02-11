#!/bin/bash

# Start virtual framebuffer (headless X server)
export DISPLAY=:1
Xvfb $DISPLAY -screen 0 1280x720x16 &

# Start Fluxbox window manager
fluxbox &

# Start Chromium browser (optional: open Google on startup)
chromium-browser --no-sandbox --disable-gpu &

# Start x11vnc to allow VNC connections
x11vnc -display $DISPLAY -forever -nopw -listen 0.0.0.0 -shared &

# Start noVNC web client on port 8080
/opt/novnc/utils/launch.sh --vnc 127.0.0.1:5900 --listen 8080

