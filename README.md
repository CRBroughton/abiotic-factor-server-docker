# Abiotic Factor Docker Server

A docker based Abiotic Factor server.

## Getting Started

- Clone down the repository
- Run `docker compose up --build` to create the container
- Once build, run `docker compose down`
- Customise the `sandboxSettings.ini` file to your liking
- Move the `sandboxSettings.ini` file to the `Casade` folder in data (requires sudo)
- Run `docker compose up -d` to start the container
- Exec into the container and run `./start_server.sh` to start the server