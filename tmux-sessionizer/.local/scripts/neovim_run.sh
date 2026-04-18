#!/usr/bin/env bash
set -e

NVIM_VERSION="v0.11.3"

OS="$(uname -s)"
ARCH="$(uname -m)"

INSTALL_DIR="$HOME/.local/nvim-$NVIM_VERSION"
BIN_DIR="$HOME/.local/bin"
BIN_LINK="$BIN_DIR/nvim"

mkdir -p "$BIN_DIR"

echo "Installing Neovim $NVIM_VERSION on $OS ($ARCH)..."

# Detect tarball
if [[ "$OS" == "Darwin" ]]; then
    TARBALL="nvim-macos.tar.gz"
    EXTRACTED_DIR="nvim-macos"
elif [[ "$OS" == "Linux" ]]; then
    if [[ "$ARCH" == "x86_64" ]]; then
        TARBALL="nvim-linux64.tar.gz"
        EXTRACTED_DIR="nvim-linux64"
    elif [[ "$ARCH" == "aarch64" ]]; then
        TARBALL="nvim-linux-arm64.tar.gz"
        EXTRACTED_DIR="nvim-linux-arm64"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Download
curl -LO "https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/$TARBALL"

# Extract
tar xzf "$TARBALL"

# Remove old version if exists
rm -rf "$INSTALL_DIR"

# Move
mv "$EXTRACTED_DIR" "$INSTALL_DIR"

# Symlink
ln -sf "$INSTALL_DIR/bin/nvim" "$BIN_LINK"

# Cleanup
rm -f "$TARBALL"

echo "✅ Installed Neovim $NVIM_VERSION"

# PATH check
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  Add this to your shell config (~/.bashrc, ~/.zshrc):"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi

# Verify
"$BIN_LINK" --version | head -n 1
