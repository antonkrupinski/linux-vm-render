#!/bin/bash
set -e

echo "Starting Xvfb..."
Xvfb :0 -screen 0 1024x768x16 &

echo "Starting fluxbox..."
fluxbox &

echo "Starting x11vnc..."
x11vnc -display :0 -nopw -forever &

# Check if launch.sh exists
if [ -f /opt/novnc/utils/launch.sh ]; then
    echo "Starting noVNC..."
    /opt/novnc/utils/launch.sh --vnc localhost:5900
else
    echo "ERROR: /opt/novnc/utils/launch.sh not found!"
    echo "Contents of /opt/novnc/utils:"
    ls -l /opt/novnc/utils
    exit 1
fi

# Keep container running
tail -f /dev/null
