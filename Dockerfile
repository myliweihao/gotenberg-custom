# Base on official Gotenberg image
FROM gotenberg/gotenberg:8

# Switch to root user to install packages
USER root

# Install necessary tools and common Chinese fonts
# rpm2cpio and cpio are needed to extract RPM packages manually
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-wqy-zenhei \
    fonts-noto-cjk \
    curl \
    cabextract \
    rpm2cpio \
    cpio && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Manually download, extract, and install Microsoft Core Fonts.
# This is the most reliable method and avoids all EULA and installer issues.
RUN curl -L "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.2-1.noarch.rpm" -o mscorefonts.rpm && \
    rpm2cpio mscorefonts.rpm | cpio -idmv && \
    cabextract -d /usr/share/fonts/truetype/msttcorefonts/ ./usr/share/mscorefonts-installer/*.cab && \
    fc-cache -f -v && \
    rm -rf mscorefonts.rpm ./usr

# Switch back to the non-root gotenberg user for security
USER gotenberg
