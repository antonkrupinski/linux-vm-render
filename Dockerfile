# Base image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    sudo \
    python3 \
    python3-pip \
    nodejs \
    npm \
    openjdk-17-jdk \
    docker.io \
    unzip \
    cmake \
    g++ \
    make \
    vim \
    htop \
    tmux \
    zsh \
    libjson-c-dev \
    libwebsockets-dev \
    libssl-dev \
    && apt-get clean

# Install ttyd (terminal in browser)
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && mkdir build && cd build \
    && cmake .. && make && make install

# Create a default user
RUN useradd -m -s /bin/bash devuser && echo "devuser:devuser" | chpasswd && adduser devuser sudo

# Set persistent workspace
RUN mkdir -p /home/devuser/workspace
VOLUME ["/home/devuser/workspace"]

# Expose the port (Render uses $PORT)
ENV PORT=10000
EXPOSE $PORT

# Use tmux + ttyd for multiple shells
USER devuser
WORKDIR /home/devuser/workspace

# Start ttyd with tmux for multiple terminals
CMD ["sh", "-c", "tmux new-session -s main \; set-option -g mouse on \; attach-session & ttyd -p $PORT tmux attach-session -t main"]
