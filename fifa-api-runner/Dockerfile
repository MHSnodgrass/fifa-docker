FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    tar \
    wget \
    gnupg \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Install Java 25 via Adoptium
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/adoptium.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb noble main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && apt-get install -y temurin-25-jdk && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user for the runner
RUN useradd -m -s /bin/bash runner

# Set up runner directory
WORKDIR /home/runner/actions-runner

# Download and extract the GitHub Actions runner
RUN curl -o actions-runner-linux-x64-2.333.1.tar.gz -L \
    https://github.com/actions/runner/releases/download/v2.333.1/actions-runner-linux-x64-2.333.1.tar.gz && \
    tar xzf actions-runner-linux-x64-2.333.1.tar.gz && \
    rm actions-runner-linux-x64-2.333.1.tar.gz

# Install runner dependencies
RUN ./bin/installdeps.sh

# Copy and permission the startup script
COPY start.sh .
RUN chmod +x start.sh

# Hand ownership to the runner user
RUN chown -R runner:runner /home/runner

USER runner

ENTRYPOINT ["./start.sh"]