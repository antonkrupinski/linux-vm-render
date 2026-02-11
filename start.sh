#!/bin/bash

# Start virtual framebuffer
Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1

# Start Fluxbox window manager
fluxbox &

# Start x11vnc server
x11vnc -display :1 -nopw -listen 0.0.0.0 -xkb -forever &

# Start noVNC web client (fixed path)
/opt/novnc/launch.sh --vnc localhost:5900 --listen 8080 &

# Start Chromium browser in virtual display
chromium --no-sandbox --disable-gpu --start-maximized &

# Keep container running
tail -f /dev/null
