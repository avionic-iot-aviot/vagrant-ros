#!/bin/bash
set -e
set -x

# Installing nodejs
sudo apt install -y nodejs npm

# Updating npm and nodejs
sudo npm i -g n
sudo n lts
sudo npm i -g npm
