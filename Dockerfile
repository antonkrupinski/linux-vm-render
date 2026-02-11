# Base image
FROM ubuntu:22.04

# Set environment
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget curl git vim xvfb x11vnc fluxbox sudo unzip gnupg \
    ca-certificates fonts-liberation novnc websockify \
    && apt-get clean

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Set up noVNC
RUN mkdir -p /opt/novnc \
    && git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify

# Use Render's assigned port
ENV PORT=8080
EXPOSE $PORT

# Startup script
CMD bash -c "\
    Xvfb :1 -screen 0 1280x720x16 & \
    fluxbox & \
    x11vnc -display :1 -nopw -forever -listen 0.0.0.0 -xkb & \
    /opt/novnc/utils/launch.sh --vnc localhost:5900 --listen \$PORT --web /opt/novnc & \
    google-chrome --no-sandbox --display=:1 --start-maximized"
