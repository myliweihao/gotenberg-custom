# Dockerfile (备用方案：强力非交互模式)

FROM gotenberg/gotenberg:8

USER root

# 【关键修正】在所有 apt 命令前，设置环境变量强制进入非交互模式
# 这是比 debconf-set-selections 更强力的手段
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    ttf-mscorefonts-einstaller && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER gotenberg
```3.  **提交 (Commit) 修改**。
