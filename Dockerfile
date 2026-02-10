FROM kasmweb/ubuntu-focal-desktop:1.15.0

ENV PORT=6901
ENV KASM_PORT=6901
ENV KASM_TLS=0
ENV KASM_ALLOW_UNSAFE_SSL=1
ENV TRUST_PROXY=1

EXPOSE 6901

CMD ["/bin/bash", "-c", "\
  sed -i 's/ssl_only = True/ssl_only = False/g' /etc/kasmvnc/kasmvnc.yaml && \
  /usr/bin/supervisord -c /etc/supervisor/supervisord.conf \
"]
