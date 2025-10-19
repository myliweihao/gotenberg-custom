# Dockerfile (修正版)

# 1. 基于官方的 Gotenberg v8 镜像
FROM gotenberg/gotenberg:8

# 2. 切换到 root 用户，以便我们有权限安装软件
USER root

# 3. 更新软件包列表，并安装字体
RUN apt-get update && \
    # 【关键修正】下面这行代码的作用是自动同意微软字体的 EULA 许可协议
    # 解决了 exit code 100 的问题
    echo "ttf-mscorefonts-einstaller msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    ttf-mscorefonts-einstaller && \
    # 清理缓存，减小镜像体积
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 4. 切换回原来的 gotenberg 用户，这是安全的好习惯
USER gotenberg
