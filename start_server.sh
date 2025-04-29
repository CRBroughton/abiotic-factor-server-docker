#!/bin/bash

# Enable debugging
set -x

echo "Starting Abiotic Factor server setup..."

# Check for updates/perform initial installation
if [[ $AUTO_UPDATE == "true" ]]; then
    echo "Installing/updating game files..."
    steamcmd \
    +@sSteamCmdForcePlatformType windows \
    +force_install_dir /server \
    +login anonymous \
    +app_update 2857200 validate \
    +quit
fi

# Configure Wine environment
export WINEDEBUG=fixme-all
export WINEPREFIX=/root/.wine
export WINEDLLOVERRIDES="mscoree=d"  # Disable Wine's internal .NET

# Start the server with Wine
echo "Starting server with Wine..."
cd /server

# Check Wine version
wine --version || echo "Wine not found!"

# Try to start the server
echo "Launching server with parameters:"
echo "Server Name: ${SERVERNAME}"
echo "Max Players: ${MAXPLAYERS}"
echo "Port: ${PORT}" 
echo "Query Port: ${QUERYPORT}"
echo "Additional Args: ${ADDITIONAL_ARGS}"

# Run the server with wine
wine /server/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe \
-SteamServerName="${SERVERNAME}" \
-MaxPlayers=${MAXPLAYERS} \
-Port=${PORT} \
-QueryPort=${QUERYPORT} \
-ServerPassword="${PASSWORD}" \
${ADDITIONAL_ARGS}

# If we get here, the server has exited
echo "Server exited. Check logs for details."