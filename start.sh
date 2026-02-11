#!/bin/bash

# Start X virtual framebuffer
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1

# Start lightweight window manager
fluxbox &

# Start x11vnc server
x11vnc -display :1 -nopw -forever -shared &

# Start noVNC web client on Render's port
/opt/novnc/utils/launch.sh --vnc localhost:5900 --listen ${PORT:-8080}
