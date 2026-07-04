#!/usr/bin/env bash

set -e

VERSION="0.11.4"

ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    FILE="nvim-macos-arm64.tar.gz"
    DIR="nvim-macos-arm64"
elif [[ "$ARCH" == "x86_64" ]]; then
    FILE="nvim-macos-x86_64.tar.gz"
    DIR="nvim-macos-x86_64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

URL="https://github.com/neovim/neovim/releases/download/v${VERSION}/${FILE}"

echo "Downloading Neovim ${VERSION}..."
curl -L -o "$FILE" "$URL"

echo "Extracting..."
tar -xzf "$FILE"

echo "Installing..."
sudo rm -rf /opt/nvim-${VERSION}
sudo mv "$DIR" /opt/nvim-${VERSION}

echo "Creating symlink..."
sudo ln -sf /opt/nvim-${VERSION}/bin/nvim /opt/homebrew/bin/nvim

echo
echo "Installed successfully!"
echo
/opt/homebrew/bin/nvim --version | head -n 1
