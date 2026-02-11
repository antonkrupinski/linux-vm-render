# Base image
FROM ubuntu:22.04

# Prevent prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install basics and languages
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    vim \
    nano \
    unzip \
    software-properties-common \
    python3 python3-pip \
    openjdk-17-jdk \
    nodejs npm \
    default-jre \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install Xvfb, fluxbox, x11vnc, and noVNC
RUN apt-get update && apt-get install -y \
    xvfb \
    fluxbox \
    x11vnc \
    websockify \
    novnc \
    && rm -rf /var/lib/apt/lists/*

# Setup noVNC
RUN mkdir -p /opt/novnc \
    && ln -s /usr/share/novnc /opt/novnc

# Expose Render port
ENV PORT=8080
EXPOSE $PORT

# Create start script
RUN echo '#!/bin/bash\n\
Xvfb :1 -screen 0 1280x720x16 &\n\
fluxbox &\n\
x11vnc -display :1 -nopw -forever -listen 0.0.0.0 -noxdamage -nowf -cursor arrow &\n\
/opt/novnc/utils/launch.sh --vnc localhost:5900 --listen $PORT --web /opt/novnc &\n\
/bin/bash' > /start.sh
RUN chmod +x /start.sh

# Start everything
CMD ["/start.sh"]
