# Dockerfile
FROM gotenberg/gotenberg:8
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    ttf-mscorefonts-einstaller && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER gotenberg
