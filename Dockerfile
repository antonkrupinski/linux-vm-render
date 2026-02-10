# Base image
FROM ubuntu:22.04

# Non-interactive for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essentials
RUN apt update && apt install -y \
    sudo \
    bash \
    curl \
    git \
    nano \
    htop \
    wget \
    unzip \
    zip \
    python3 \
    python3-pip \
    nodejs \
    npm \
    docker.io \
    build-essential \
    ca-certificates \
    ttyd \
    zsh \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install latest Node.js (optional, more up-to-date)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Create user with passwordless sudo
RUN useradd -ms /bin/bash devuser \
    && echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER devuser
WORKDIR /home/devuser

# Expose port for web terminal
EXPOSE 7681

# Start ttyd web terminal
CMD ["ttyd", "-p", "7681", "bash"]
