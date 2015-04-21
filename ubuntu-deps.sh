#!/bin/sh

# Make sure the library's up-to-date
sudo apt-get update

# Install a bunch of stuff.  '-y' means no idiotit Yn prompts
sudo apt-get install -y openjdk-7-jdk ant git gitg cmake libx11-dev libxmu-dev \
    libglu1-mesa-dev libgl2ps-dev libxi-dev g++ libzip-dev libpng12-dev \
    libcurl4-gnutls-dev libfontconfig1-dev libsqlite3-dev libglew-dev \
    libssl-dev p7zip-full


