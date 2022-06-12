#!/bin/sh

echo "Installing Go"
brew update && brew install golang
echo "Go installed successfully"

echo "Creating Go directories"
mkdir -p $HOME/go/{bin,src,pkg}
echo "Go directories created successfully"