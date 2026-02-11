#!/bin/bash
set -e

# Start X virtual framebuffer
Xvfb :1 -screen 0 1024x768x16 &

# Start fluxbox window manager
export DISPLAY=:1
fluxbox &

# Start x11vnc to allow VNC connections
x11vnc -display :1 -nopw -forever -shared &

# Start noVNC web client
/opt/novnc/utils/launch.sh --vnc localhost:5900
