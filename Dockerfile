FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget git xterm fluxbox x11vnc xvfb chromium-browser \
    python3 python3-pip python3-dev \
    novnc websockify \
    && rm -rf /var/lib/apt/lists/*

# Setup noVNC
RUN mkdir -p /opt/novnc \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc \
    && mkdir -p /opt/novnc/utils/websockify \
    && wget -qO- https://github.com/novnc/websockify/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose noVNC port
EXPOSE 8080

# Run start script
CMD ["/start.sh"]
