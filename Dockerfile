FROM steamcmd/steamcmd:latest

# Install dependencies for Wine repository
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    gnupg2 \
    lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/*

# Add WineHQ repository
RUN dpkg --add-architecture i386 && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

# Install WineHQ stable
RUN apt-get update && \
    apt-get install -y --install-recommends winehq-stable && \
    rm -rf /var/lib/apt/lists/*

# Create directories
WORKDIR /server

# Copy the start script
COPY start_server.sh /server/start_server.sh
RUN chmod +x /server/start_server.sh

# Set the command
CMD ["/bin/bash", "/server/start_server.sh"]