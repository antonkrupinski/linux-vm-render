FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    wget git xterm fluxbox x11vnc xvfb chromium-browser \
    python3 python3-pip curl

# Create directories for noVNC and websockify
RUN mkdir -p /opt/novnc/utils/websockify

# Download latest noVNC
RUN wget -qO- https://github.com/novnc/noVNC/archive/refs/heads/master.tar.gz \
    | tar xz --strip-components=1 -C /opt/novnc

# Download latest websockify
RUN wget -qO- https://github.com/novnc/websockify/archive/refs/heads/master.tar.gz \
    | tar xz --strip-components=1 -C /opt/novnc/utils/websockify

# Copy the start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose default noVNC port
EXPOSE 6080

CMD ["/start.sh"]
