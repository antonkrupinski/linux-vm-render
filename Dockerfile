# Base image
FROM ubuntu:22.04

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone to UTC
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y \
        wget \
        git \
        xterm \
        fluxbox \
        x11vnc \
        xvfb \
        chromium-browser \
        novnc \
        python3 \
        python3-pip \
        tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install noVNC and websockify manually
RUN mkdir -p /opt/novnc && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc && \
    mkdir -p /opt/novnc/utils/websockify && \
    wget -qO- https://github.com/novnc/websockify/archive/refs/heads/master.tar.gz | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# Copy your start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose noVNC port
EXPOSE 6080

# Run start.sh by default
CMD ["/start.sh"]
