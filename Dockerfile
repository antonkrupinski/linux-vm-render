FROM kasmweb/ubuntu-focal-desktop:1.15.0

# Render port
ENV PORT=6901
ENV KASM_PORT=6901

# CRITICAL: allow Render HTTPS proxy
ENV KASM_TLS=0
ENV TRUST_PROXY=1

EXPOSE 6901
