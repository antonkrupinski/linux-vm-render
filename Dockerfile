# Use Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set environment variables to avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    chromium-browser \
    firefox \
    xvfb \
    x11vnc \
    fluxbox \
    wget \
    curl \
    net-tools \
    git \
    vim \
    nano \
    python3 \
    python3-pip \
    sudo \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Download noVNC
RUN mkdir -p /opt/novnc \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc \
    && mkdir -p /opt/novnc/utils/websockify \
    && wget -qO- https://github.com/novnc/websockify/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose the noVNC port
EXPOSE 8080

# Start the VM
CMD ["/start.sh"]
