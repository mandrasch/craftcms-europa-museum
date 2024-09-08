#!/usr/bin/env bash

# Prepare vscode-xdebug setup
mkdir -p .vscode
cp .gitpod/templates/launch.json .vscode/.

# Not needed currently, demo still runs on webpack
# Workaround for Vite:
# Normally expose port 3100 for Vite in .ddev/config.yaml, but ddev-router
# is not used  on Gitpod / Codespaces, etc. The Routing is handled by Gitpod /
# Codespaces itself. Therefore we will create an additional config file for
# DDEV which will expose port 3100 without ddev-router.
# cp .gitpod/templates/docker-compose.vite-workaround.yaml .ddev/.

# Start the DDEV project
export DDEV_NONINTERACTIVE=true

# important, copy env first since baukasten has some special env vars
cp .env.ddev.example .env

# start project
ddev start -y

# install deps
ddev composer install
ddev npm install

ddev craft setup/keys

# import dump
ddev import-db --file=seed.sql

# start webpack
ddev npm run watch
