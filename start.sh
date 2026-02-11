#!/bin/bash
set -e

echo "Starting Xvfb..."
Xvfb :0 -screen 0 1024x768x16 &

echo "Starting fluxbox..."
fluxbox &

echo "Starting x11vnc..."
x11vnc -display :0 -nopw -forever &

# Start noVNC using websockify directly
if [ -d /opt/novnc ]; then
    echo "Starting noVNC..."
    /opt/novnc/utils/websockify/run --web /opt/novnc 6080 localhost:5900
else
    echo "ERROR: /opt/novnc directory not found!"
    ls -l /opt
    exit 1
fi

# Keep container running
tail -f /dev/null
