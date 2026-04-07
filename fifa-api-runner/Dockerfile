FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and Java 25 as root
RUN apt-get update && apt-get install -y \
curl \
git \
tar \
wget \
gnupg \
apt-transport-https \
libicu-dev \
libssl-dev \
&& rm -rf /var/lib/apt/lists/*

# Install Java 25 via Adoptium
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/adoptium.gpg && \
echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb noble main" | tee /etc/apt/sources.list.d/adoptium.list && \
apt-get update && apt-get install -y temurin-25-jdk && \
rm -rf /var/lib/apt/lists/*

# Create runner user and directory as root
RUN useradd -m -s /bin/bash runner && \
mkdir -p /home/runner/actions-runner && \
chown runner:runner /home/runner/actions-runner

# Switch to runner user for all remaining steps
USER runner

WORKDIR /home/runner/actions-runner

# Download and extract the runner as the runner user
RUN curl -o actions-runner-linux-x64-2.333.1.tar.gz -L \
https://github.com/actions/runner/releases/download/v2.333.1/actions-runner-linux-x64-2.333.1.tar.gz && \
tar xzf actions-runner-linux-x64-2.333.1.tar.gz && \
rm actions-runner-linux-x64-2.333.1.tar.gz

# Copy and permission the startup script
COPY --chown=runner:runner start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]
