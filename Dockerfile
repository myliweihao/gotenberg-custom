# Dockerfile (最终解决方案版)

# 1. 基于官方的 Gotenberg v8 镜像
FROM gotenberg/gotenberg:8

# 2. 切换到 root 用户，以便我们有权限安装软件
USER root

# 3. 安装基础中文字体 和 curl 工具（用来下载）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    curl \
    cabextract && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 4. 手动下载并安装微软核心字体 (最可靠的方法)
# 这会绕过所有 EULA 提示和不稳定的下载器
RUN curl -L "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.2-1.noarch.rpm" -o msttcore-fonts-installer-2.2-1.noarch.rpm && \
    rpm2cpio msttcore-fonts-installer-2.2-1.noarch.rpm | cpio -idmv && \
    cabextract -d /usr/share/fonts/truetype/msttcorefonts/ /usr/share/mscorefonts-installer/*.cab && \
    # 刷新系统字体缓存
    fc-cache -f -v && \
    # 清理下载的临时文件
    rm -rf msttcore-fonts-installer-2.2-1.noarch.rpm /usr/share/mscorefonts-installer

# 5. 切换回原来的 gotenberg 用户
USER gotenberg
